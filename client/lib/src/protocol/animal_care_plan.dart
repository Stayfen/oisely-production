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
import 'care_plan_task.dart' as _i2;
import 'package:oisely_client/src/protocol/protocol.dart' as _i3;

abstract class AnimalCarePlan implements _i1.SerializableModel {
  AnimalCarePlan._({
    this.id,
    required this.animalIdentificationRecordId,
    required this.userIdentifier,
    required this.version,
    required this.generatedAt,
    required this.modelName,
    required this.generationConfidence,
    this.summary,
    required this.totalDailyTimeMinutes,
    required this.totalWeeklyTimeMinutes,
    required this.status,
    this.tasks,
  });

  factory AnimalCarePlan({
    int? id,
    required int animalIdentificationRecordId,
    required String userIdentifier,
    required int version,
    required DateTime generatedAt,
    required String modelName,
    required double generationConfidence,
    String? summary,
    required int totalDailyTimeMinutes,
    required int totalWeeklyTimeMinutes,
    required String status,
    List<_i2.CarePlanTask>? tasks,
  }) = _AnimalCarePlanImpl;

  factory AnimalCarePlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnimalCarePlan(
      id: jsonSerialization['id'] as int?,
      animalIdentificationRecordId:
          jsonSerialization['animalIdentificationRecordId'] as int,
      userIdentifier: jsonSerialization['userIdentifier'] as String,
      version: jsonSerialization['version'] as int,
      generatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
      modelName: jsonSerialization['modelName'] as String,
      generationConfidence: (jsonSerialization['generationConfidence'] as num)
          .toDouble(),
      summary: jsonSerialization['summary'] as String?,
      totalDailyTimeMinutes: jsonSerialization['totalDailyTimeMinutes'] as int,
      totalWeeklyTimeMinutes:
          jsonSerialization['totalWeeklyTimeMinutes'] as int,
      status: jsonSerialization['status'] as String,
      tasks: jsonSerialization['tasks'] == null
          ? null
          : _i3.Protocol().deserialize<List<_i2.CarePlanTask>>(
              jsonSerialization['tasks'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int animalIdentificationRecordId;

  String userIdentifier;

  int version;

  DateTime generatedAt;

  String modelName;

  double generationConfidence;

  String? summary;

  int totalDailyTimeMinutes;

  int totalWeeklyTimeMinutes;

  String status;

  List<_i2.CarePlanTask>? tasks;

  /// Returns a shallow copy of this [AnimalCarePlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AnimalCarePlan copyWith({
    int? id,
    int? animalIdentificationRecordId,
    String? userIdentifier,
    int? version,
    DateTime? generatedAt,
    String? modelName,
    double? generationConfidence,
    String? summary,
    int? totalDailyTimeMinutes,
    int? totalWeeklyTimeMinutes,
    String? status,
    List<_i2.CarePlanTask>? tasks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnimalCarePlan',
      if (id != null) 'id': id,
      'animalIdentificationRecordId': animalIdentificationRecordId,
      'userIdentifier': userIdentifier,
      'version': version,
      'generatedAt': generatedAt.toJson(),
      'modelName': modelName,
      'generationConfidence': generationConfidence,
      if (summary != null) 'summary': summary,
      'totalDailyTimeMinutes': totalDailyTimeMinutes,
      'totalWeeklyTimeMinutes': totalWeeklyTimeMinutes,
      'status': status,
      if (tasks != null) 'tasks': tasks?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnimalCarePlanImpl extends AnimalCarePlan {
  _AnimalCarePlanImpl({
    int? id,
    required int animalIdentificationRecordId,
    required String userIdentifier,
    required int version,
    required DateTime generatedAt,
    required String modelName,
    required double generationConfidence,
    String? summary,
    required int totalDailyTimeMinutes,
    required int totalWeeklyTimeMinutes,
    required String status,
    List<_i2.CarePlanTask>? tasks,
  }) : super._(
         id: id,
         animalIdentificationRecordId: animalIdentificationRecordId,
         userIdentifier: userIdentifier,
         version: version,
         generatedAt: generatedAt,
         modelName: modelName,
         generationConfidence: generationConfidence,
         summary: summary,
         totalDailyTimeMinutes: totalDailyTimeMinutes,
         totalWeeklyTimeMinutes: totalWeeklyTimeMinutes,
         status: status,
         tasks: tasks,
       );

  /// Returns a shallow copy of this [AnimalCarePlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AnimalCarePlan copyWith({
    Object? id = _Undefined,
    int? animalIdentificationRecordId,
    String? userIdentifier,
    int? version,
    DateTime? generatedAt,
    String? modelName,
    double? generationConfidence,
    Object? summary = _Undefined,
    int? totalDailyTimeMinutes,
    int? totalWeeklyTimeMinutes,
    String? status,
    Object? tasks = _Undefined,
  }) {
    return AnimalCarePlan(
      id: id is int? ? id : this.id,
      animalIdentificationRecordId:
          animalIdentificationRecordId ?? this.animalIdentificationRecordId,
      userIdentifier: userIdentifier ?? this.userIdentifier,
      version: version ?? this.version,
      generatedAt: generatedAt ?? this.generatedAt,
      modelName: modelName ?? this.modelName,
      generationConfidence: generationConfidence ?? this.generationConfidence,
      summary: summary is String? ? summary : this.summary,
      totalDailyTimeMinutes:
          totalDailyTimeMinutes ?? this.totalDailyTimeMinutes,
      totalWeeklyTimeMinutes:
          totalWeeklyTimeMinutes ?? this.totalWeeklyTimeMinutes,
      status: status ?? this.status,
      tasks: tasks is List<_i2.CarePlanTask>?
          ? tasks
          : this.tasks?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
