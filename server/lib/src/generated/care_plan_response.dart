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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class CarePlanTaskResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CarePlanTaskResponse._({
    required this.id,
    required this.taskType,
    required this.title,
    required this.description,
    required this.estimatedDurationMinutes,
    required this.priority,
    this.suggestedTimeOfDay,
    this.aiReasoning,
  });

  factory CarePlanTaskResponse({
    required int id,
    required String taskType,
    required String title,
    required String description,
    required int estimatedDurationMinutes,
    required String priority,
    String? suggestedTimeOfDay,
    String? aiReasoning,
  }) = _CarePlanTaskResponseImpl;

  factory CarePlanTaskResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CarePlanTaskResponse(
      id: jsonSerialization['id'] as int,
      taskType: jsonSerialization['taskType'] as String,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      estimatedDurationMinutes:
          jsonSerialization['estimatedDurationMinutes'] as int,
      priority: jsonSerialization['priority'] as String,
      suggestedTimeOfDay: jsonSerialization['suggestedTimeOfDay'] as String?,
      aiReasoning: jsonSerialization['aiReasoning'] as String?,
    );
  }

  int id;

  String taskType;

  String title;

  String description;

  int estimatedDurationMinutes;

  String priority;

  String? suggestedTimeOfDay;

  String? aiReasoning;

  /// Returns a shallow copy of this [CarePlanTaskResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CarePlanTaskResponse copyWith({
    int? id,
    String? taskType,
    String? title,
    String? description,
    int? estimatedDurationMinutes,
    String? priority,
    String? suggestedTimeOfDay,
    String? aiReasoning,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CarePlanTaskResponse',
      'id': id,
      'taskType': taskType,
      'title': title,
      'description': description,
      'estimatedDurationMinutes': estimatedDurationMinutes,
      'priority': priority,
      if (suggestedTimeOfDay != null) 'suggestedTimeOfDay': suggestedTimeOfDay,
      if (aiReasoning != null) 'aiReasoning': aiReasoning,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CarePlanTaskResponse',
      'id': id,
      'taskType': taskType,
      'title': title,
      'description': description,
      'estimatedDurationMinutes': estimatedDurationMinutes,
      'priority': priority,
      if (suggestedTimeOfDay != null) 'suggestedTimeOfDay': suggestedTimeOfDay,
      if (aiReasoning != null) 'aiReasoning': aiReasoning,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CarePlanTaskResponseImpl extends CarePlanTaskResponse {
  _CarePlanTaskResponseImpl({
    required int id,
    required String taskType,
    required String title,
    required String description,
    required int estimatedDurationMinutes,
    required String priority,
    String? suggestedTimeOfDay,
    String? aiReasoning,
  }) : super._(
         id: id,
         taskType: taskType,
         title: title,
         description: description,
         estimatedDurationMinutes: estimatedDurationMinutes,
         priority: priority,
         suggestedTimeOfDay: suggestedTimeOfDay,
         aiReasoning: aiReasoning,
       );

  /// Returns a shallow copy of this [CarePlanTaskResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CarePlanTaskResponse copyWith({
    int? id,
    String? taskType,
    String? title,
    String? description,
    int? estimatedDurationMinutes,
    String? priority,
    Object? suggestedTimeOfDay = _Undefined,
    Object? aiReasoning = _Undefined,
  }) {
    return CarePlanTaskResponse(
      id: id ?? this.id,
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
    );
  }
}
