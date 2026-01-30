import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/care_plan_ai_service.dart';

/// Endpoint for generating and managing AI-powered animal care plans
class CarePlanEndpoint extends Endpoint {
  static const _modelName = 'gemini-2.0-flash';
  static const _maxCarePlansPerHour = 5;

  @override
  bool get requireLogin => true;

  /// Generate a new care plan for an animal
  ///
  /// Requires authentication via session token.
  /// Accepts an animal identification record ID and optional additional notes.
  /// Returns a comprehensive care plan with balanced daily, weekly, and yearly tasks.
  Future<CarePlanGenerationResult> generateCarePlan(
    Session session, {
    required int animalIdentificationRecordId,
    String? additionalNotes,
  }) async {
    // Authenticate user
    final authInfo = await session.authenticated;
    final userIdentifier = authInfo?.userIdentifier;
    if (userIdentifier == null) {
      throw CarePlanAuthException(
        'User must be logged in to generate care plans',
      );
    }
    final userIdentifierValue = userIdentifier.toString();

    try {
      // Check rate limit
      await _checkRateLimit(session, userIdentifierValue);

      // Verify animal exists and belongs to user
      final animal = await _fetchAndVerifyAnimal(
        session,
        animalIdentificationRecordId,
        userIdentifierValue,
      );

      // Generate care plan using AI
      final aiService = CarePlanAiService(session);
      final aiResult = await aiService.generateCarePlan(
        animal: animal,
        additionalNotes: additionalNotes,
      );

      // Calculate next version number for this animal
      final version = await _getNextVersion(
        session,
        animalIdentificationRecordId,
      );

      // Archive existing active care plans for this animal
      await _archiveExistingPlans(session, animalIdentificationRecordId);

      // Create care plan record
      final carePlan = AnimalCarePlan(
        animalIdentificationRecordId: animalIdentificationRecordId,
        userIdentifier: userIdentifierValue,
        version: version,
        generatedAt: DateTime.now(),
        modelName: _modelName,
        generationConfidence: aiResult.confidence,
        summary: aiResult.summary,
        totalDailyTimeMinutes: aiResult.totalDailyTimeMinutes,
        totalWeeklyTimeMinutes: aiResult.totalWeeklyTimeMinutes,
        status: 'active',
      );

      // Insert care plan
      final savedPlan = await AnimalCarePlan.db.insertRow(session, carePlan);

      if (savedPlan.id == null) {
        throw CarePlanDatabaseException('Failed to save care plan');
      }

      // Insert tasks
      final taskResponses = <CarePlanTaskResponse>[];
      final dailyTasks = <CarePlanTaskResponse>[];
      final weeklyTasks = <CarePlanTaskResponse>[];
      final yearlyTasks = <CarePlanTaskResponse>[];

      // Process daily tasks
      for (final taskData in aiResult.dailyTasks) {
        final task = await _createAndInsertTask(
          session,
          savedPlan.id!,
          taskData,
          'daily',
        );
        final response = _toTaskResponse(task);
        dailyTasks.add(response);
        taskResponses.add(response);
      }

      // Process weekly tasks
      for (final taskData in aiResult.weeklyTasks) {
        final task = await _createAndInsertTask(
          session,
          savedPlan.id!,
          taskData,
          'weekly',
        );
        final response = _toTaskResponse(task);
        weeklyTasks.add(response);
        taskResponses.add(response);
      }

      // Process yearly tasks
      for (final taskData in aiResult.yearlyTasks) {
        final task = await _createAndInsertTask(
          session,
          savedPlan.id!,
          taskData,
          'yearly',
        );
        final response = _toTaskResponse(task);
        yearlyTasks.add(response);
        taskResponses.add(response);
      }

      // Log success
      session.log(
        'Care plan generated: id=${savedPlan.id}, '
        'animalId=$animalIdentificationRecordId, '
        'user=$userIdentifierValue, '
        'version=$version, '
        'tasks=${taskResponses.length}',
        level: LogLevel.info,
      );

      return CarePlanGenerationResult(
        carePlanId: savedPlan.id!,
        animalIdentificationRecordId: animalIdentificationRecordId,
        version: version,
        generatedAt: savedPlan.generatedAt,
        generationConfidence: aiResult.confidence,
        summary: aiResult.summary,
        totalDailyTimeMinutes: aiResult.totalDailyTimeMinutes,
        totalWeeklyTimeMinutes: aiResult.totalWeeklyTimeMinutes,
        dailyTasks: dailyTasks,
        weeklyTasks: weeklyTasks,
        yearlyTasks: yearlyTasks,
        modelName: _modelName,
      );
    } on CarePlanAuthException {
      rethrow;
    } on CarePlanNotFoundException {
      rethrow;
    } on CarePlanRateLimitException {
      rethrow;
    } on CarePlanGenerationException {
      rethrow;
    } catch (e, stackTrace) {
      session.log(
        'Care plan generation failed',
        exception: e,
        stackTrace: stackTrace,
        level: LogLevel.error,
      );
      throw CarePlanGenerationException(
        'Internal server error during care plan generation',
      );
    }
  }

  /// Get an existing care plan by ID
  Future<CarePlanGenerationResult?> getCarePlan(
    Session session, {
    required int carePlanId,
  }) async {
    // Authenticate user
    final authInfo = await session.authenticated;
    final userIdentifier = authInfo?.userIdentifier?.toString();
    if (userIdentifier == null) {
      throw CarePlanAuthException('User must be logged in');
    }

    try {
      // Fetch care plan with tasks
      final carePlan = await AnimalCarePlan.db.findById(
        session,
        carePlanId,
      );

      if (carePlan == null) {
        return null;
      }

      // Verify ownership
      if (carePlan.userIdentifier != userIdentifier) {
        throw CarePlanAuthException('Access denied to this care plan');
      }

      // Fetch tasks
      final tasks = await CarePlanTask.db.find(
        session,
        where: (t) => t.carePlanId.equals(carePlanId),
      );

      // Categorize tasks
      final dailyTasks = <CarePlanTaskResponse>[];
      final weeklyTasks = <CarePlanTaskResponse>[];
      final yearlyTasks = <CarePlanTaskResponse>[];

      for (final task in tasks) {
        final response = _toTaskResponse(task);
        switch (task.taskType) {
          case 'daily':
            dailyTasks.add(response);
            break;
          case 'weekly':
            weeklyTasks.add(response);
            break;
          case 'yearly':
            yearlyTasks.add(response);
            break;
        }
      }

      return CarePlanGenerationResult(
        carePlanId: carePlanId,
        animalIdentificationRecordId: carePlan.animalIdentificationRecordId,
        version: carePlan.version,
        generatedAt: carePlan.generatedAt,
        generationConfidence: carePlan.generationConfidence,
        summary: carePlan.summary,
        totalDailyTimeMinutes: carePlan.totalDailyTimeMinutes,
        totalWeeklyTimeMinutes: carePlan.totalWeeklyTimeMinutes,
        dailyTasks: dailyTasks,
        weeklyTasks: weeklyTasks,
        yearlyTasks: yearlyTasks,
        modelName: carePlan.modelName,
      );
    } on CarePlanAuthException {
      rethrow;
    } catch (e, stackTrace) {
      session.log(
        'Failed to fetch care plan',
        exception: e,
        stackTrace: stackTrace,
        level: LogLevel.error,
      );
      throw CarePlanDatabaseException('Failed to retrieve care plan');
    }
  }

  /// List all care plans for a specific animal
  Future<List<AnimalCarePlan>> listCarePlansForAnimal(
    Session session, {
    required int animalIdentificationRecordId,
  }) async {
    // Authenticate user
    final authInfo = await session.authenticated;
    final userIdentifier = authInfo?.userIdentifier?.toString();
    if (userIdentifier == null) {
      throw CarePlanAuthException('User must be logged in');
    }

    try {
      // Verify animal ownership
      await _fetchAndVerifyAnimal(
        session,
        animalIdentificationRecordId,
        userIdentifier,
      );

      // Fetch care plans (excluding tasks for list view)
      final carePlans = await AnimalCarePlan.db.find(
        session,
        where: (p) =>
            p.animalIdentificationRecordId.equals(animalIdentificationRecordId),
        orderBy: (p) => p.generatedAt,
        orderDescending: true,
      );

      return carePlans;
    } on CarePlanAuthException {
      rethrow;
    } on CarePlanNotFoundException {
      rethrow;
    } catch (e, stackTrace) {
      session.log(
        'Failed to list care plans',
        exception: e,
        stackTrace: stackTrace,
        level: LogLevel.error,
      );
      throw CarePlanDatabaseException('Failed to retrieve care plans');
    }
  }

  /// Archive a care plan (soft delete)
  Future<bool> archiveCarePlan(
    Session session, {
    required int carePlanId,
  }) async {
    // Authenticate user
    final authInfo = await session.authenticated;
    final userIdentifier = authInfo?.userIdentifier?.toString();
    if (userIdentifier == null) {
      throw CarePlanAuthException('User must be logged in');
    }

    try {
      final carePlan = await AnimalCarePlan.db.findById(session, carePlanId);

      if (carePlan == null) {
        return false;
      }

      // Verify ownership
      if (carePlan.userIdentifier != userIdentifier) {
        throw CarePlanAuthException('Access denied to this care plan');
      }

      // Update status to archived
      final updated = carePlan.copyWith(status: 'archived');
      await AnimalCarePlan.db.updateRow(session, updated);

      return true;
    } on CarePlanAuthException {
      rethrow;
    } catch (e, stackTrace) {
      session.log(
        'Failed to archive care plan',
        exception: e,
        stackTrace: stackTrace,
        level: LogLevel.error,
      );
      throw CarePlanDatabaseException('Failed to archive care plan');
    }
  }

  // Private helper methods

  Future<void> _checkRateLimit(Session session, String userIdentifier) async {
    final rateLimitKey = 'care_plan_rate_limit_$userIdentifier';
    var rateLimitEntry =
        await session.caches.local.get(rateLimitKey) as RateLimitCounter?;
    var count = rateLimitEntry?.count ?? 0;

    if (count >= _maxCarePlansPerHour) {
      throw CarePlanRateLimitException(
        'Rate limit exceeded. Maximum $_maxCarePlansPerHour care plans per hour.',
      );
    }

    await session.caches.local.put(
      rateLimitKey,
      RateLimitCounter(count: count + 1),
      lifetime: Duration(hours: 1),
    );
  }

  Future<AnimalIdentificationRecord> _fetchAndVerifyAnimal(
    Session session,
    int animalId,
    String userIdentifier,
  ) async {
    final animal = await AnimalIdentificationRecord.db.findById(
      session,
      animalId,
    );

    if (animal == null) {
      throw CarePlanNotFoundException('Animal not found with ID: $animalId');
    }

    if (animal.userIdentifier != userIdentifier) {
      throw CarePlanAuthException('Access denied to this animal record');
    }

    return animal;
  }

  Future<int> _getNextVersion(
    Session session,
    int animalIdentificationRecordId,
  ) async {
    final existingPlans = await AnimalCarePlan.db.find(
      session,
      where: (p) =>
          p.animalIdentificationRecordId.equals(animalIdentificationRecordId),
      orderBy: (p) => p.version,
      orderDescending: true,
      limit: 1,
    );

    if (existingPlans.isEmpty) {
      return 1;
    }

    return (existingPlans.first.version) + 1;
  }

  Future<void> _archiveExistingPlans(
    Session session,
    int animalIdentificationRecordId,
  ) async {
    final activePlans = await AnimalCarePlan.db.find(
      session,
      where: (p) =>
          p.animalIdentificationRecordId.equals(animalIdentificationRecordId) &
          p.status.equals('active'),
    );

    for (final plan in activePlans) {
      final archived = plan.copyWith(status: 'superseded');
      await AnimalCarePlan.db.updateRow(session, archived);
    }
  }

  Future<CarePlanTask> _createAndInsertTask(
    Session session,
    int carePlanId,
    CarePlanTaskData taskData,
    String taskType,
  ) async {
    final task = CarePlanTask(
      carePlanId: carePlanId,
      taskType: taskType,
      title: taskData.title,
      description: taskData.description,
      estimatedDurationMinutes: taskData.estimatedDurationMinutes,
      priority: taskData.priority,
      suggestedTimeOfDay: taskData.suggestedTimeOfDay,
      aiReasoning: taskData.aiReasoning,
      createdAt: DateTime.now(),
    );

    return await CarePlanTask.db.insertRow(session, task);
  }

  CarePlanTaskResponse _toTaskResponse(CarePlanTask task) {
    return CarePlanTaskResponse(
      id: task.id ?? 0,
      taskType: task.taskType,
      title: task.title,
      description: task.description,
      estimatedDurationMinutes: task.estimatedDurationMinutes,
      priority: task.priority,
      suggestedTimeOfDay: task.suggestedTimeOfDay,
      aiReasoning: task.aiReasoning,
    );
  }
}

// Custom exception classes

class CarePlanAuthException implements Exception {
  final String message;
  CarePlanAuthException(this.message);
  @override
  String toString() => 'CarePlanAuthException: $message';
}

class CarePlanNotFoundException implements Exception {
  final String message;
  CarePlanNotFoundException(this.message);
  @override
  String toString() => 'CarePlanNotFoundException: $message';
}

class CarePlanRateLimitException implements Exception {
  final String message;
  CarePlanRateLimitException(this.message);
  @override
  String toString() => 'CarePlanRateLimitException: $message';
}

class CarePlanDatabaseException implements Exception {
  final String message;
  CarePlanDatabaseException(this.message);
  @override
  String toString() => 'CarePlanDatabaseException: $message';
}
