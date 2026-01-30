/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class CarePlanTask implements _i1.SerializableModel {
  CarePlanTask._({
    this.id,
    required this.carePlanId,
    required this.taskType,
    required this.title,
    required this.description,
    required this.estimatedDurationMinutes,
    required this.priority,
    this.suggestedTimeOfDay,
    this.aiReasoning,
    required this.createdAt,
  });

  factory CarePlanTask({
    int? id,
    required int carePlanId,
    required String taskType,
    required String title,
    required String description,
    required int estimatedDurationMinutes,
    required String priority,
    String? suggestedTimeOfDay,
    String? aiReasoning,
    required DateTime createdAt,
  }) = _CarePlanTaskImpl;

  factory CarePlanTask.fromJson(Map<String, dynamic> jsonSerialization) {
    return CarePlanTask(
      id: jsonSerialization['id'] as int?,
      carePlanId: jsonSerialization['carePlanId'] as int,
      taskType: jsonSerialization['taskType'] as String,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      estimatedDurationMinutes:
          jsonSerialization['estimatedDurationMinutes'] as int,
      priority: jsonSerialization['priority'] as String,
      suggestedTimeOfDay: jsonSerialization['suggestedTimeOfDay'] as String?,
      aiReasoning: jsonSerialization['aiReasoning'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int carePlanId;

  String taskType;

  String title;

  String description;

  int estimatedDurationMinutes;

  String priority;

  String? suggestedTimeOfDay;

  String? aiReasoning;

  DateTime createdAt;

  /// Returns a shallow copy of this [CarePlanTask]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CarePlanTask copyWith({
    int? id,
    int? carePlanId,
    String? taskType,
    String? title,
    String? description,
    int? estimatedDurationMinutes,
    String? priority,
    String? suggestedTimeOfDay,
    String? aiReasoning,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CarePlanTask',
      if (id != null) 'id': id,
      'carePlanId': carePlanId,
      'taskType': taskType,
      'title': title,
      'description': description,
      'estimatedDurationMinutes': estimatedDurationMinutes,
      'priority': priority,
      if (suggestedTimeOfDay != null) 'suggestedTimeOfDay': suggestedTimeOfDay,
      if (aiReasoning != null) 'aiReasoning': aiReasoning,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CarePlanTaskImpl extends CarePlanTask {
  _CarePlanTaskImpl({
    int? id,
    required int carePlanId,
    required String taskType,
    required String title,
    required String description,
    required int estimatedDurationMinutes,
    required String priority,
    String? suggestedTimeOfDay,
    String? aiReasoning,
    required DateTime createdAt,
  }) : super._(
         id: id,
         carePlanId: carePlanId,
         taskType: taskType,
         title: title,
         description: description,
         estimatedDurationMinutes: estimatedDurationMinutes,
         priority: priority,
         suggestedTimeOfDay: suggestedTimeOfDay,
         aiReasoning: aiReasoning,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CarePlanTask]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CarePlanTask copyWith({
    Object? id = _Undefined,
    int? carePlanId,
    String? taskType,
    String? title,
    String? description,
    int? estimatedDurationMinutes,
    String? priority,
    Object? suggestedTimeOfDay = _Undefined,
    Object? aiReasoning = _Undefined,
    DateTime? createdAt,
  }) {
    return CarePlanTask(
      id: id is int? ? id : this.id,
      carePlanId: carePlanId ?? this.carePlanId,
      taskType: taskType ?? this.taskType,
      title: title ?? this.title,
      description: description ?? this.description,
      estimatedDurationMinutes:
          estimatedDurationMinutes ?? this.estimatedDurationMinutes,
      priority: priority ?? this.priority,
      suggestedTimeOfDay: suggestedTimeOfDay is String?
          ? suggestedTimeOfDay
          : this.suggestedTimeOfDay,
      aiReasoning: aiReasoning is String? ? aiReasoning : this.aiReasoning,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
