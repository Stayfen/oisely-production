import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';

const apiKey = 'AIzaSyBVLDOT8OLNeDgsrcrHx8saKJH_955Wxek';

void main() async {
  final file = File('../test-data/test_image.jpg'); // Relative to server directory
  if (!await file.exists()) {
    // Try relative to tool directory if run from there? 
    // Usually run as 'dart tool/script.dart' from server root.
    print('Error: Test image not found at ${file.path}. CWD: ${Directory.current.path}');
    return;
  }
  print('Found image at ${file.path}');
  await runTest(file);
}

Future<void> runTest(File file) async {
  final bytes = await file.readAsBytes();
  
  final model = GenerativeModel(
    model: 'gemini-flash-latest',
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
      DataPart('image/jpeg', bytes),
    ])
  ];

  print('Sending request to Gemini...');
  try {
    final response = await model.generateContent(content);
    print('Response received:');
    print(response.text);
  } catch (e) {
    print('Error: $e');
  }
}
