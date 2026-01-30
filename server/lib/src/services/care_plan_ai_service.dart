import 'dart:convert';
import 'dart:math';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Service for generating intelligent care plans using AI
class CarePlanAiService {
  static const _modelName = 'gemini-2.0-flash';

  // Task limits to prevent overload
  static const int minDailyTasks = 3;
  static const int maxDailyTasks = 5;
  static const int minWeeklyTasks = 2;
  static const int maxWeeklyTasks = 4;
  static const int minYearlyTasks = 2;
  static const int maxYearlyTasks = 3;

  final Session _session;
  GenerativeModel? _model;

  CarePlanAiService(this._session);

  /// Initialize the AI model with API key
  void _initializeModel() {
    final apiKey = _readGeminiApiKey();
    _model = GenerativeModel(
      model: _modelName,
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        temperature: 0.3,
      ),
    );
  }

  /// Generate a comprehensive care plan for an animal
  Future<CarePlanAiResult> generateCarePlan({
    required AnimalIdentificationRecord animal,
    String? additionalNotes,
  }) async {
    if (_model == null) {
      _initializeModel();
    }

    try {
      final prompt = _buildPrompt(
        animal: animal,
        additionalNotes: additionalNotes,
      );

      final content = [Content.text(prompt)];
      final response = await _model!.generateContent(content);

      if (response.text == null || response.text!.isEmpty) {
        throw CarePlanGenerationException('AI returned empty response');
      }

      final parsed = _parseAiResponse(response.text!);
      final validated = _validateAndBalanceTasks(parsed);

      return CarePlanAiResult(
        dailyTasks: validated['daily']!,
        weeklyTasks: validated['weekly']!,
        yearlyTasks: validated['yearly']!,
        summary: parsed['summary'] as String?,
        confidence: parsed['confidence'] as double? ?? 0.7,
      );
    } on CarePlanGenerationException {
      rethrow;
    } catch (e, stackTrace) {
      _session.log(
        'AI care plan generation failed',
        exception: e,
        stackTrace: stackTrace,
        level: LogLevel.error,
      );
      throw CarePlanGenerationException('Failed to generate care plan: $e');
    }
  }

  /// Build the AI prompt for care plan generation
  String _buildPrompt({
    required AnimalIdentificationRecord animal,
    String? additionalNotes,
  }) {
    return '''
You are an expert animal care specialist. Create a balanced, realistic care plan for the following animal:

ANIMAL INFORMATION:
- Species: ${animal.species}
- Breed: ${animal.breed ?? 'Unknown/Not specified'}
- Record ID: ${animal.id}

${additionalNotes != null ? 'ADDITIONAL NOTES: $additionalNotes\n' : ''}

TASK REQUIREMENTS:
Generate a comprehensive care plan with these EXACT limits:
- DAILY TASKS: $minDailyTasks to $maxDailyTasks essential daily care items
- WEEKLY TASKS: $minWeeklyTasks to $maxWeeklyTasks maintenance activities
- YEARLY TASKS: $minYearlyTasks to $maxYearlyTasks major care milestones or veterinary checkups

For each task, provide:
- title: Brief, actionable task name (max 50 characters)
- description: Clear instructions on what to do (max 200 characters)
- estimatedDurationMinutes: Realistic time estimate in minutes (5-120 minutes)
- priority: One of "critical", "high", "medium", "low"
- suggestedTimeOfDay: One of "morning", "afternoon", "evening", "any", or null
- aiReasoning: Brief explanation of why this task is important for this species

TASK PRIORITY GUIDELINES:
- Critical: Feeding, water, essential medication, emergency care
- High: Exercise, grooming, cleaning primary living space
- Medium: Enrichment, training, socialization
- Low: Optional activities, detailed inspections

SPECIES-SPECIFIC CONSIDERATIONS:
Consider the unique needs of ${animal.species} including:
- Natural behavior patterns and activity levels
- Dietary requirements and feeding frequency
- Exercise and enrichment needs
- Grooming requirements
- Social interaction needs
- Health monitoring specific to the species
- Environmental requirements

RESPONSE FORMAT:
Return ONLY a JSON object with this exact structure:
{
  "summary": "Brief overview of the care plan tailored to this animal",
  "confidence": 0.85,
  "dailyTasks": [
    {
      "title": "Task name",
      "description": "What to do",
      "estimatedDurationMinutes": 15,
      "priority": "critical",
      "suggestedTimeOfDay": "morning",
      "aiReasoning": "Why this matters"
    }
  ],
  "weeklyTasks": [...],
  "yearlyTasks": [...]
}

IMPORTANT:
- Ensure tasks are realistically balanced and not overwhelming for caretakers
- Time estimates should be reasonable for typical caretakers
- Tasks must be species-appropriate
- Do not exceed the task limits specified above
- Return valid JSON only, no markdown formatting
'''
        .trim();
  }

  /// Parse and validate the AI response
  Map<String, dynamic> _parseAiResponse(String responseText) {
    try {
      // Clean up the response - remove markdown code blocks if present
      var cleanText = responseText.trim();
      if (cleanText.startsWith('```json')) {
        cleanText = cleanText.substring(7);
      } else if (cleanText.startsWith('```')) {
        cleanText = cleanText.substring(3);
      }
      if (cleanText.endsWith('```')) {
        cleanText = cleanText.substring(0, cleanText.length - 3);
      }
      cleanText = cleanText.trim();

      final parsed = jsonDecode(cleanText) as Map<String, dynamic>;

      // Validate required fields
      if (!parsed.containsKey('dailyTasks') ||
          !parsed.containsKey('weeklyTasks') ||
          !parsed.containsKey('yearlyTasks')) {
        throw CarePlanGenerationException(
          'AI response missing required task arrays',
        );
      }

      return parsed;
    } on FormatException catch (e) {
      throw CarePlanGenerationException('Invalid JSON in AI response: $e');
    } catch (e) {
      throw CarePlanGenerationException('Failed to parse AI response: $e');
    }
  }

  /// Validate task counts and balance if needed
  Map<String, List<CarePlanTaskData>> _validateAndBalanceTasks(
    Map<String, dynamic> parsed,
  ) {
    final dailyTasks = _parseTaskList(parsed['dailyTasks'], 'daily');
    final weeklyTasks = _parseTaskList(parsed['weeklyTasks'], 'weekly');
    final yearlyTasks = _parseTaskList(parsed['yearlyTasks'], 'yearly');

    // Validate daily task count
    if (dailyTasks.length < minDailyTasks ||
        dailyTasks.length > maxDailyTasks) {
      _session.log(
        'Daily task count ${dailyTasks.length} outside recommended range '
        '($minDailyTasks-$maxDailyTasks), adjusting...',
        level: LogLevel.warning,
      );
    }

    // Validate weekly task count
    if (weeklyTasks.length < minWeeklyTasks ||
        weeklyTasks.length > maxWeeklyTasks) {
      _session.log(
        'Weekly task count ${weeklyTasks.length} outside recommended range '
        '($minWeeklyTasks-$maxWeeklyTasks), adjusting...',
        level: LogLevel.warning,
      );
    }

    // Validate yearly task count
    if (yearlyTasks.length < minYearlyTasks ||
        yearlyTasks.length > maxYearlyTasks) {
      _session.log(
        'Yearly task count ${yearlyTasks.length} outside recommended range '
        '($minYearlyTasks-$maxYearlyTasks), adjusting...',
        level: LogLevel.warning,
      );
    }

    return {
      'daily': dailyTasks,
      'weekly': weeklyTasks,
      'yearly': yearlyTasks,
    };
  }

  /// Parse a list of tasks from JSON
  List<CarePlanTaskData> _parseTaskList(dynamic taskList, String taskType) {
    if (taskList is! List) {
      return [];
    }

    return taskList
        .whereType<Map<String, dynamic>>()
        .map((task) => CarePlanTaskData.fromJson(task, taskType))
        .toList();
  }

  /// Read Gemini API key from session passwords
  String _readGeminiApiKey() {
    final apiKey = _session.passwords['geminiApiKey'];
    if (apiKey == null || apiKey.isEmpty) {
      throw CarePlanGenerationException('Gemini API key not configured');
    }
    return apiKey;
  }
}

/// Data class representing a parsed care plan task
class CarePlanTaskData {
  final String title;
  final String description;
  final int estimatedDurationMinutes;
  final String priority;
  final String? suggestedTimeOfDay;
  final String? aiReasoning;
  final String taskType;

  CarePlanTaskData({
    required this.title,
    required this.description,
    required this.estimatedDurationMinutes,
    required this.priority,
    this.suggestedTimeOfDay,
    this.aiReasoning,
    required this.taskType,
  });

  factory CarePlanTaskData.fromJson(
    Map<String, dynamic> json,
    String taskType,
  ) {
    return CarePlanTaskData(
      title: json['title']?.toString() ?? 'Unnamed Task',
      description: json['description']?.toString() ?? 'No description provided',
      estimatedDurationMinutes: _parseDuration(
        json['estimatedDurationMinutes'],
      ),
      priority: _validatePriority(json['priority']?.toString()),
      suggestedTimeOfDay: _validateTimeOfDay(
        json['suggestedTimeOfDay']?.toString(),
      ),
      aiReasoning: json['aiReasoning']?.toString(),
      taskType: taskType,
    );
  }

  static int _parseDuration(dynamic value) {
    if (value is int) {
      return value.clamp(5, 120);
    }
    if (value is double) {
      return value.toInt().clamp(5, 120);
    }
    if (value is String) {
      final parsed = int.tryParse(value);
      if (parsed != null) {
        return parsed.clamp(5, 120);
      }
    }
    return 15; // Default duration
  }

  static String _validatePriority(String? value) {
    const validPriorities = ['critical', 'high', 'medium', 'low'];
    if (value != null && validPriorities.contains(value.toLowerCase())) {
      return value.toLowerCase();
    }
    return 'medium';
  }

  static String? _validateTimeOfDay(String? value) {
    const validTimes = ['morning', 'afternoon', 'evening', 'any'];
    if (value != null && validTimes.contains(value.toLowerCase())) {
      return value.toLowerCase();
    }
    return null;
  }
}

/// Result of AI care plan generation
class CarePlanAiResult {
  final List<CarePlanTaskData> dailyTasks;
  final List<CarePlanTaskData> weeklyTasks;
  final List<CarePlanTaskData> yearlyTasks;
  final String? summary;
  final double confidence;

  CarePlanAiResult({
    required this.dailyTasks,
    required this.weeklyTasks,
    required this.yearlyTasks,
    this.summary,
    required this.confidence,
  });

  /// Calculate total daily time commitment in minutes
  int get totalDailyTimeMinutes =>
      dailyTasks.fold(0, (sum, task) => sum + task.estimatedDurationMinutes);

  /// Calculate total weekly time commitment in minutes (including weekly tasks spread out)
  int get totalWeeklyTimeMinutes {
    final dailyTotal = totalDailyTimeMinutes * 7;
    final weeklyTaskTotal = weeklyTasks.fold(
      0,
      (sum, task) => sum + task.estimatedDurationMinutes,
    );
    return dailyTotal + weeklyTaskTotal;
  }
}

/// Exception thrown when care plan generation fails
class CarePlanGenerationException implements Exception {
  final String message;

  CarePlanGenerationException(this.message);

  @override
  String toString() => 'CarePlanGenerationException: $message';
}
