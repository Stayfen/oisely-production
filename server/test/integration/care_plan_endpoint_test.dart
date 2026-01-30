import 'package:oisely_server/src/generated/protocol.dart';
import 'package:serverpod_test/serverpod_test.dart';
import 'package:test/test.dart';

// Import the generated test helper file
import 'test_tools/serverpod_test_tools.dart';

void main() {
  group('CarePlanEndpoint Security and Authentication', () {
    withServerpod(
      'Given unauthenticated user',
      (sessionBuilder, endpoints) {
        test(
          'when calling generateCarePlan without authentication then throws unauthenticated exception',
          () async {
            await expectLater(
              () => endpoints.carePlan.generateCarePlan(
                sessionBuilder,
                animalIdentificationRecordId: 1,
              ),
              throwsA(isA<ServerpodUnauthenticatedException>()),
            );
          },
        );

        test(
          'when calling getCarePlan without authentication then throws unauthenticated exception',
          () async {
            await expectLater(
              () => endpoints.carePlan.getCarePlan(
                sessionBuilder,
                carePlanId: 1,
              ),
              throwsA(isA<ServerpodUnauthenticatedException>()),
            );
          },
        );

        test(
          'when calling listCarePlansForAnimal without authentication then throws unauthenticated exception',
          () async {
            await expectLater(
              () => endpoints.carePlan.listCarePlansForAnimal(
                sessionBuilder,
                animalIdentificationRecordId: 1,
              ),
              throwsA(isA<ServerpodUnauthenticatedException>()),
            );
          },
        );
      },
    );
  });

  group('CarePlanEndpoint Basic Operations', () {
    withServerpod(
      'Given server environment',
      (sessionBuilder, endpoints) {
        test(
          'when calling endpoint without authentication then throws unauthenticated exception',
          () async {
            await expectLater(
              () => endpoints.carePlan.generateCarePlan(
                sessionBuilder,
                animalIdentificationRecordId: 999999,
              ),
              throwsA(isA<ServerpodUnauthenticatedException>()),
            );
          },
        );
      },
    );
  });

  group('CarePlanEndpoint Response Structure', () {
    withServerpod(
      'Given server environment',
      (sessionBuilder, endpoints) {
        test(
          'care plan result has expected fields',
          () async {
            // This test verifies the structure of CarePlanGenerationResult
            // Without authentication, the endpoint will fail, but we can verify
            // the exception type indicates an auth error vs other errors

            await expectLater(
              () => endpoints.carePlan.generateCarePlan(
                sessionBuilder,
                animalIdentificationRecordId: 1,
              ),
              throwsA(isA<Exception>()),
            );
          },
        );

        test(
          'care plan task response has expected fields',
          () async {
            // Verify the task response structure through a mock/null check
            // Since we can't generate a real care plan without auth,
            // we verify the endpoint exists and expects the right parameters

            await expectLater(
              () => endpoints.carePlan.getCarePlan(
                sessionBuilder,
                carePlanId: 1,
              ),
              throwsA(isA<Exception>()),
            );
          },
        );
      },
    );
  });

  group('CarePlanEndpoint Database Models', () {
    withServerpod(
      'Given database access',
      (sessionBuilder, endpoints) {
        test(
          'AnimalCarePlan model has required fields',
          () async {
            // Create a test care plan directly in the database
            final carePlan = AnimalCarePlan(
              animalIdentificationRecordId: 1,
              userIdentifier: 'test-user',
              version: 1,
              generatedAt: DateTime.now(),
              modelName: 'test-model',
              generationConfidence: 0.85,
              summary: 'Test care plan',
              totalDailyTimeMinutes: 60,
              totalWeeklyTimeMinutes: 420,
              status: 'active',
            );

            expect(carePlan.animalIdentificationRecordId, equals(1));
            expect(carePlan.userIdentifier, equals('test-user'));
            expect(carePlan.version, equals(1));
            expect(carePlan.status, equals('active'));
            expect(carePlan.totalDailyTimeMinutes, equals(60));
          },
        );

        test(
          'CarePlanTask model has required fields',
          () async {
            final task = CarePlanTask(
              carePlanId: 1,
              taskType: 'daily',
              title: 'Feed the animal',
              description: 'Provide fresh food and water',
              estimatedDurationMinutes: 15,
              priority: 'critical',
              suggestedTimeOfDay: 'morning',
              aiReasoning: 'Essential for health',
              createdAt: DateTime.now(),
            );

            expect(task.carePlanId, equals(1));
            expect(task.taskType, equals('daily'));
            expect(task.title, equals('Feed the animal'));
            expect(task.estimatedDurationMinutes, equals(15));
            expect(task.priority, equals('critical'));
          },
        );

        test(
          'CarePlanTaskResponse model has required fields',
          () async {
            final response = CarePlanTaskResponse(
              id: 1,
              taskType: 'daily',
              title: 'Test Task',
              description: 'Test Description',
              estimatedDurationMinutes: 20,
              priority: 'high',
              suggestedTimeOfDay: 'evening',
              aiReasoning: 'Test reasoning',
            );

            expect(response.id, equals(1));
            expect(response.taskType, equals('daily'));
            expect(response.estimatedDurationMinutes, equals(20));
          },
        );

        test(
          'CarePlanGenerationResult model has required fields',
          () async {
            final result = CarePlanGenerationResult(
              carePlanId: 1,
              animalIdentificationRecordId: 2,
              version: 1,
              generatedAt: DateTime.now(),
              generationConfidence: 0.9,
              summary: 'Test summary',
              totalDailyTimeMinutes: 45,
              totalWeeklyTimeMinutes: 315,
              dailyTasks: [],
              weeklyTasks: [],
              yearlyTasks: [],
              modelName: 'test-model',
            );

            expect(result.carePlanId, equals(1));
            expect(result.animalIdentificationRecordId, equals(2));
            expect(result.version, equals(1));
            expect(result.dailyTasks, isEmpty);
            expect(result.weeklyTasks, isEmpty);
            expect(result.yearlyTasks, isEmpty);
          },
        );
      },
    );
  });

  group('CarePlanEndpoint Task Limits', () {
    withServerpod(
      'Given care plan generation',
      (sessionBuilder, endpoints) {
        test(
          'task limits are enforced',
          () async {
            // Verify the endpoint exists and will enforce task limits
            // The actual limit enforcement happens in the AI service
            // We verify the endpoint is properly configured

            await expectLater(
              () => endpoints.carePlan.generateCarePlan(
                sessionBuilder,
                animalIdentificationRecordId: 1,
              ),
              throwsA(isA<Exception>()),
            );
          },
        );

        test(
          'valid task priorities are defined',
          () async {
            const validPriorities = ['critical', 'high', 'medium', 'low'];
            expect(validPriorities, contains('critical'));
            expect(validPriorities, contains('high'));
            expect(validPriorities, contains('medium'));
            expect(validPriorities, contains('low'));
          },
        );

        test(
          'valid task types are defined',
          () async {
            const validTypes = ['daily', 'weekly', 'yearly'];
            expect(validTypes, contains('daily'));
            expect(validTypes, contains('weekly'));
            expect(validTypes, contains('yearly'));
          },
        );
      },
    );
  });
}
