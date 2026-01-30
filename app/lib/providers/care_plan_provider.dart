import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oisely_client/oisely_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

/// Represents a todo task with local completion tracking
class CarePlanTodo {
  final int id;
  final String taskType;
  final String title;
  final String description;
  final int estimatedDurationMinutes;
  final String priority;
  final String? suggestedTimeOfDay;
  final String? aiReasoning;
  final DateTime createdAt;
  final String frequency; // 'daily', 'weekly', 'yearly'
  bool isCompleted;
  DateTime? completedAt;

  CarePlanTodo({
    required this.id,
    required this.taskType,
    required this.title,
    required this.description,
    required this.estimatedDurationMinutes,
    required this.priority,
    this.suggestedTimeOfDay,
    this.aiReasoning,
    required this.createdAt,
    required this.frequency,
    this.isCompleted = false,
    this.completedAt,
  });

  factory CarePlanTodo.fromTaskResponse(
    CarePlanTaskResponse response, {
    required String frequency,
  }) {
    return CarePlanTodo(
      id: response.id,
      taskType: response.taskType,
      title: response.title,
      description: response.description,
      estimatedDurationMinutes: response.estimatedDurationMinutes,
      priority: response.priority,
      suggestedTimeOfDay: response.suggestedTimeOfDay,
      aiReasoning: response.aiReasoning,
      createdAt: DateTime.now(),
      frequency: frequency,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskType': taskType,
      'title': title,
      'description': description,
      'estimatedDurationMinutes': estimatedDurationMinutes,
      'priority': priority,
      'suggestedTimeOfDay': suggestedTimeOfDay,
      'aiReasoning': aiReasoning,
      'createdAt': createdAt.toIso8601String(),
      'frequency': frequency,
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory CarePlanTodo.fromJson(Map<String, dynamic> json) {
    return CarePlanTodo(
      id: json['id'] as int,
      taskType: json['taskType'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      estimatedDurationMinutes: json['estimatedDurationMinutes'] as int,
      priority: json['priority'] as String,
      suggestedTimeOfDay: json['suggestedTimeOfDay'] as String?,
      aiReasoning: json['aiReasoning'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      frequency: json['frequency'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }

  CarePlanTodo copyWith({
    int? id,
    String? taskType,
    String? title,
    String? description,
    int? estimatedDurationMinutes,
    String? priority,
    String? suggestedTimeOfDay,
    String? aiReasoning,
    DateTime? createdAt,
    String? frequency,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return CarePlanTodo(
      id: id ?? this.id,
      taskType: taskType ?? this.taskType,
      title: title ?? this.title,
      description: description ?? this.description,
      estimatedDurationMinutes:
          estimatedDurationMinutes ?? this.estimatedDurationMinutes,
      priority: priority ?? this.priority,
      suggestedTimeOfDay: suggestedTimeOfDay ?? this.suggestedTimeOfDay,
      aiReasoning: aiReasoning ?? this.aiReasoning,
      createdAt: createdAt ?? this.createdAt,
      frequency: frequency ?? this.frequency,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

/// Enum representing the care plan generation status
enum CarePlanGenerationStatus {
  idle,
  loading,
  success,
  error,
}

/// Provider for managing care plan state and API calls
class CarePlanProvider extends ChangeNotifier {
  static const String _carePlanPrefix = 'oisely_care_plan_';

  final String animalId;
  final int? animalIdentificationRecordId;

  CarePlanGenerationResult? _carePlan;
  List<CarePlanTodo> _todos = [];
  CarePlanGenerationStatus _generationStatus = CarePlanGenerationStatus.idle;
  String? _error;
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  double _generationProgress = 0.0;

  // Getters
  CarePlanGenerationResult? get carePlan => _carePlan;
  List<CarePlanTodo> get todos => List.unmodifiable(_todos);
  List<CarePlanTodo> get activeTodos =>
      _todos.where((t) => !t.isCompleted).toList();
  List<CarePlanTodo> get completedTodos =>
      _todos.where((t) => t.isCompleted).toList();
  CarePlanGenerationStatus get generationStatus => _generationStatus;
  bool get isLoading => _generationStatus == CarePlanGenerationStatus.loading;
  bool get isSuccess => _generationStatus == CarePlanGenerationStatus.success;
  bool get isError => _generationStatus == CarePlanGenerationStatus.error;
  String? get error => _error;
  DateTime get selectedDate => _selectedDate;
  DateTime get focusedDate => _focusedDate;
  double get generationProgress => _generationProgress;
  bool get hasCarePlan => _carePlan != null || _todos.isNotEmpty;

  /// Get todos for a specific date
  List<CarePlanTodo> getTodosForDate(DateTime date) {
    return _todos.where((todo) {
      if (todo.isCompleted) return false;
      return _isTaskScheduledForDate(todo, date);
    }).toList();
  }

  /// Check if a task is scheduled for a specific date
  bool _isTaskScheduledForDate(CarePlanTodo todo, DateTime date) {
    switch (todo.frequency) {
      case 'daily':
        return true;
      case 'weekly':
        // Schedule weekly tasks on specific days (e.g., based on task ID)
        return date.weekday == ((todo.id % 7) + 1);
      case 'yearly':
        // Schedule yearly tasks on specific dates
        return date.day == ((todo.id % 28) + 1) && date.month == 1;
      default:
        return false;
    }
  }

  /// Get dates that have active todos
  Set<DateTime> get datesWithTodos {
    final dates = <DateTime>{};
    final now = DateTime.now();
    final thirtyDaysFromNow = now.add(const Duration(days: 30));

    for (
      var date = now;
      date.isBefore(thirtyDaysFromNow);
      date = date.add(const Duration(days: 1))
    ) {
      if (getTodosForDate(date).isNotEmpty) {
        dates.add(DateTime(date.year, date.month, date.day));
      }
    }
    return dates;
  }

  CarePlanProvider({
    required this.animalId,
    this.animalIdentificationRecordId,
  }) {
    _loadStoredCarePlan();
  }

  /// Load stored care plan from local storage
  Future<void> _loadStoredCarePlan() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '$_carePlanPrefix$animalId';
      final todosJson = prefs.getString(key);

      if (todosJson != null) {
        final List<dynamic> decoded = jsonDecode(todosJson);
        _todos = decoded.map((json) => CarePlanTodo.fromJson(json)).toList();
        _generationStatus = CarePlanGenerationStatus.success;
      }

      _error = null;
    } catch (e) {
      _error = 'Failed to load care plan: $e';
      _generationStatus = CarePlanGenerationStatus.error;
    } finally {
      notifyListeners();
    }
  }

  /// Save todos to local storage
  Future<void> _saveTodos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '$_carePlanPrefix$animalId';
      final todosJson = jsonEncode(_todos.map((t) => t.toJson()).toList());
      await prefs.setString(key, todosJson);
    } catch (e) {
      _error = 'Failed to save care plan: $e';
      notifyListeners();
    }
  }

  /// Generate a new care plan from the server
  /// Can be called before navigation to pre-generate the care plan
  Future<void> generateCarePlan({String? additionalNotes}) async {
    if (animalIdentificationRecordId == null) {
      _error = 'Animal identification record ID not available';
      _generationStatus = CarePlanGenerationStatus.error;
      notifyListeners();
      return;
    }

    // If already loading, don't start another generation
    if (_generationStatus == CarePlanGenerationStatus.loading) {
      return;
    }

    _generationStatus = CarePlanGenerationStatus.loading;
    _generationProgress = 0.0;
    _error = null;
    notifyListeners();

    try {
      // Simulate progress for better UX
      _simulateProgress();

      final result = await client.carePlan
          .generateCarePlan(
            animalIdentificationRecordId: animalIdentificationRecordId!,
            additionalNotes: additionalNotes,
          )
          .timeout(
            const Duration(seconds: 60),
            onTimeout: () {
              throw Exception(
                'Care plan generation timed out. Please try again.',
              );
            },
          );

      _carePlan = result;
      _generationProgress = 1.0;

      // Convert server tasks to local todos
      _todos = [
        ...result.dailyTasks.map(
          (t) => CarePlanTodo.fromTaskResponse(t, frequency: 'daily'),
        ),
        ...result.weeklyTasks.map(
          (t) => CarePlanTodo.fromTaskResponse(t, frequency: 'weekly'),
        ),
        ...result.yearlyTasks.map(
          (t) => CarePlanTodo.fromTaskResponse(t, frequency: 'yearly'),
        ),
      ];

      await _saveTodos();
      _generationStatus = CarePlanGenerationStatus.success;
      _error = null;
    } catch (e) {
      _error = 'Failed to generate care plan: $e';
      _generationStatus = CarePlanGenerationStatus.error;
    } finally {
      notifyListeners();
    }
  }

  /// Simulate progress updates for better UX during generation
  void _simulateProgress() {
    final steps = [0.1, 0.25, 0.4, 0.6, 0.75, 0.9];
    var stepIndex = 0;

    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_generationStatus != CarePlanGenerationStatus.loading) {
        timer.cancel();
        return;
      }

      if (stepIndex < steps.length) {
        _generationProgress = steps[stepIndex];
        notifyListeners();
        stepIndex++;
      } else {
        timer.cancel();
      }
    });
  }

  /// Toggle todo completion status
  Future<void> toggleTodoCompletion(int todoId) async {
    final index = _todos.indexWhere((t) => t.id == todoId);
    if (index == -1) return;

    final todo = _todos[index];
    _todos[index] = todo.copyWith(
      isCompleted: !todo.isCompleted,
      completedAt: !todo.isCompleted ? DateTime.now() : null,
    );

    await _saveTodos();
    notifyListeners();
  }

  /// Mark todo as complete
  Future<void> completeTodo(int todoId) async {
    final index = _todos.indexWhere((t) => t.id == todoId);
    if (index == -1 || _todos[index].isCompleted) return;

    _todos[index] = _todos[index].copyWith(
      isCompleted: true,
      completedAt: DateTime.now(),
    );

    await _saveTodos();
    notifyListeners();
  }

  /// Set selected date
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  /// Set focused date (for calendar navigation)
  void setFocusedDate(DateTime date) {
    _focusedDate = date;
    notifyListeners();
  }

  /// Clear error
  void clearError() {
    _error = null;
    if (_generationStatus == CarePlanGenerationStatus.error) {
      _generationStatus = CarePlanGenerationStatus.idle;
    }
    notifyListeners();
  }

  /// Retry loading/generating care plan
  Future<void> retry() async {
    if (_generationStatus == CarePlanGenerationStatus.error ||
        _todos.isEmpty && animalIdentificationRecordId != null) {
      await generateCarePlan();
    } else {
      await _loadStoredCarePlan();
    }
  }

  /// Clear all todos for this animal (for testing)
  Future<void> clearAll() async {
    _todos = [];
    _carePlan = null;
    _generationStatus = CarePlanGenerationStatus.idle;
    final prefs = await SharedPreferences.getInstance();
    final key = '$_carePlanPrefix$animalId';
    await prefs.remove(key);
    notifyListeners();
  }
}
