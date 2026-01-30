import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';

// Key from tool/test_gemini_direct.dart
const apiKey = 'AIzaSyBVLDOT8OLNeDgsrcrHx8saKJH_955Wxek';
const modelName = 'gemini-3-flash-preview';

void main() async {
  print('Starting behavior analysis test with model: $modelName');
  
  final file = File('../test-data/budgerigar.mp4');
  if (!await file.exists()) {
    print('Error: Video file not found at ${file.path}');
    return;
  }
  
  final videoBytes = await file.readAsBytes();
  print('Video loaded: ${videoBytes.length} bytes');

  // Simulate duration (approximate or extracted if we had the helper)
  // For the prompt, we'll use 18.0 as per the constraint/expectation
  final durationSeconds = 18.0;

  final model = GenerativeModel(
    model: modelName,
    apiKey: apiKey,
    generationConfig: GenerationConfig(
      responseMimeType: 'application/json',
      temperature: 0.2,
    ),
  );

  final prompt = '''
Analyze this ${durationSeconds.toStringAsFixed(2)} second video of a budgerigar and return JSON only.
Use the requestId "test-request-real-1" when referencing this analysis.
Previously identified animals for this user: [].
Return a JSON object with:
- identifiedSpecies
- identifiedBreed
- activityLevel
- emotionalState
- behaviorPatterns (array of strings)
- movementSummary
- postureSummary
- vocalizationSummary
- movementPatterns (array of strings)
- vocalizationPatterns (array of strings)
- keyFrames (array of objects with timestampSeconds, action, bodyLanguage)
- analysisConfidence (0.0 to 1.0)
Ensure keyFrames include 3 to 8 entries across the video timeline.
''';

  print('Sending request to Gemini...');
  try {
    final response = await model.generateContent([
      Content.multi([
        TextPart(prompt),
        DataPart('video/mp4', videoBytes),
      ]),
    ]);

    if (response.text == null) {
      print('Error: Empty response from Gemini');
      return;
    }

    print('\n--- Gemini Response ---');
    print(response.text);
    print('-----------------------\n');

  } catch (e) {
    print('Error calling Gemini: $e');
  }
}
