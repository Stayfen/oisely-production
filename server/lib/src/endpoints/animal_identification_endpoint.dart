import 'dart:convert';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class AnimalIdentificationEndpoint extends Endpoint {
  static const _maxImageSize = 10 * 1024 * 1024; // 10 MB
  static const _modelName = 'gemini-flash-latest';

  @override
  bool get requireLogin => true;

  Future<AdoptionInfo> identifyAnimal(Session session, String imageBase64) async {
    final authInfo = await session.authenticated;
    final userIdentifier = authInfo?.userIdentifier;
    if (userIdentifier == null) {
      throw Exception('User must be logged in');
    }
    final userIdentifierValue = userIdentifier.toString();

    final rateLimitKey = 'animal_ident_rate_limit_$userIdentifierValue';
    var rateLimitEntry = await session.caches.local.get(rateLimitKey) as RateLimitCounter?;
    var count = rateLimitEntry?.count ?? 0;
    
    if (count >= 10) {
      throw Exception('Rate limit exceeded. Please try again later.');
    }

    await session.caches.local.put(
      rateLimitKey, 
      RateLimitCounter(count: count + 1), 
      lifetime: Duration(minutes: 1),
    );

    Uint8List imageBytes;
    try {
      imageBytes = base64Decode(imageBase64);
    } catch (e) {
      session.log('Invalid base64 image data', level: LogLevel.warning);
      throw Exception('Invalid image format');
    }

    if (imageBytes.length > _maxImageSize) {
      session.log('Image too large: ${imageBytes.length} bytes', level: LogLevel.warning);
      throw Exception('Image size exceeds the limit of 10MB');
    }
    
    // Check for empty image
    if (imageBytes.isEmpty) {
       throw Exception('Image data is empty');
    }

    try {
      final apiKey = _readGeminiApiKey(session);
      final model = GenerativeModel(
        model: _modelName,
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
        ),
      );

      final prompt = '''
        Analyze the provided image. If it contains an animal, identify it and provide the following adoption information in JSON format:
        - species: The species of the animal (e.g., Dog, Cat, Parrot).
        - breed: The breed of the animal if identifiable, otherwise null or "Unknown".
        - adoptionCost: Estimated cost of adoption (e.g., "\$50 - \$200").
        - dietaryRequirements: Brief summary of dietary needs.
        - livingEnvironment: Suitable living environment (e.g., "Apartment friendly", "Needs large yard").
        - careInstructions: Key care instructions.
        - dailyTimeCommitment: Estimated daily time commitment for care.
        - averageLifespan: Average lifespan of the animal.
        - breedSpecificInfo: Important info specific to this breed/species.
        - legalRequirements: Common legal requirements for ownership (if any).
        - confidence: A number between 0.0 and 1.0 indicating confidence in the identification.

        If the image does not contain a clear animal, or you are unsure, set "species" to "Unknown" and "confidence" to 0.0.
      ''';

      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart('image/jpeg', imageBytes),
        ])
      ];

      final response = await model.generateContent(content);
      
      if (response.text == null) {
        session.log('Gemini returned empty response', level: LogLevel.error);
        throw Exception('Failed to identify animal');
      }

      // 5. Response Parsing
      Map<String, dynamic> jsonResponse;
      try {
        jsonResponse = jsonDecode(response.text!) as Map<String, dynamic>;
      } catch (e) {
        session.log('Failed to parse Gemini JSON response: ${response.text}', level: LogLevel.error);
        throw Exception('Failed to parse AI response');
      }
      
      if (jsonResponse['species'] == 'Unknown' || (jsonResponse['confidence'] as num? ?? 0) < 0.4) {
         session.log('Animal not identified or low confidence: ${jsonResponse['confidence']}', level: LogLevel.info);
      }

      final adoptionInfo = AdoptionInfo(
        species: jsonResponse['species'] ?? 'Unknown',
        breed: jsonResponse['breed'],
        adoptionCost: jsonResponse['adoptionCost'] ?? 'Unknown',
        dietaryRequirements: jsonResponse['dietaryRequirements'] ?? 'Unknown',
        livingEnvironment: jsonResponse['livingEnvironment'] ?? 'Unknown',
        careInstructions: jsonResponse['careInstructions'] ?? 'Unknown',
        dailyTimeCommitment: jsonResponse['dailyTimeCommitment'] ?? 'Unknown',
        averageLifespan: jsonResponse['averageLifespan'] ?? 'Unknown',
        breedSpecificInfo: jsonResponse['breedSpecificInfo'] ?? 'Unknown',
        legalRequirements: jsonResponse['legalRequirements'] ?? 'Unknown',
        confidence: (jsonResponse['confidence'] as num?)?.toDouble() ?? 0.0,
      );

      final imageHash = await _sha256Base64(imageBytes);
      final record = AnimalIdentificationRecord(
        userIdentifier: userIdentifierValue,
        species: adoptionInfo.species,
        breed: adoptionInfo.breed,
        confidence: adoptionInfo.confidence,
        createdAt: DateTime.now(),
        imageSha256: imageHash,
        modelName: _modelName,
      );
      await AnimalIdentificationRecord.db.insertRow(session, record);

      return adoptionInfo;
    } catch (e, stackTrace) {
      session.log(
        'Error identifying animal',
        exception: e,
        stackTrace: stackTrace,
        level: LogLevel.error,
      );
      // If it's already an exception we threw, rethrow it
      if (e.toString().contains('User must be logged in') || 
          e.toString().contains('Rate limit exceeded') ||
          e.toString().contains('Invalid image format') ||
          e.toString().contains('Image size exceeds') ||
          e.toString().contains('Image data is empty')) {
        rethrow;
      }
      throw Exception('Internal server error during animal identification: $e');
    }
  }

  String _readGeminiApiKey(Session session) {
    final apiKey = session.passwords['geminiApiKey'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Gemini API key not configured');
    }
    return apiKey;
  }

  Future<String> _sha256Base64(Uint8List bytes) async {
    final digest = await Sha256().hash(bytes);
    return base64Encode(digest.bytes);
  }
}
