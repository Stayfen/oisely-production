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
import 'care_plan_response.dart' as _i2;
import 'package:oisely_client/src/protocol/protocol.dart' as _i3;

abstract class CarePlanGenerationResult implements _i1.SerializableModel {
  CarePlanGenerationResult._({
    required this.carePlanId,
    required this.animalIdentificationRecordId,
    required this.version,
    required this.generatedAt,
    required this.generationConfidence,
    this.summary,
    required this.totalDailyTimeMinutes,
    required this.totalWeeklyTimeMinutes,
    required this.dailyTasks,
    required this.weeklyTasks,
    required this.yearlyTasks,
    required this.modelName,
  });

  factory CarePlanGenerationResult({
    required int carePlanId,
    required int animalIdentificationRecordId,
    required int version,
    required DateTime generatedAt,
    required double generationConfidence,
    String? summary,
    required int totalDailyTimeMinutes,
    required int totalWeeklyTimeMinutes,
    required List<_i2.CarePlanTaskResponse> dailyTasks,
    required List<_i2.CarePlanTaskResponse> weeklyTasks,
    required List<_i2.CarePlanTaskResponse> yearlyTasks,
    required String modelName,
  }) = _CarePlanGenerationResultImpl;

  factory CarePlanGenerationResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CarePlanGenerationResult(
      carePlanId: jsonSerialization['carePlanId'] as int,
      animalIdentificationRecordId:
          jsonSerialization['animalIdentificationRecordId'] as int,
      version: jsonSerialization['version'] as int,
      generatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
      generationConfidence: (jsonSerialization['generationConfidence'] as num)
          .toDouble(),
      summary: jsonSerialization['summary'] as String?,
      totalDailyTimeMinutes: jsonSerialization['totalDailyTimeMinutes'] as int,
      totalWeeklyTimeMinutes:
          jsonSerialization['totalWeeklyTimeMinutes'] as int,
      dailyTasks: _i3.Protocol().deserialize<List<_i2.CarePlanTaskResponse>>(
        jsonSerialization['dailyTasks'],
      ),
      weeklyTasks: _i3.Protocol().deserialize<List<_i2.CarePlanTaskResponse>>(
        jsonSerialization['weeklyTasks'],
      ),
      yearlyTasks: _i3.Protocol().deserialize<List<_i2.CarePlanTaskResponse>>(
        jsonSerialization['yearlyTasks'],
      ),
      modelName: jsonSerialization['modelName'] as String,
    );
  }

  int carePlanId;

  int animalIdentificationRecordId;

  int version;

  DateTime generatedAt;

  double generationConfidence;

  String? summary;

  int totalDailyTimeMinutes;

  int totalWeeklyTimeMinutes;

  List<_i2.CarePlanTaskResponse> dailyTasks;

  List<_i2.CarePlanTaskResponse> weeklyTasks;

  List<_i2.CarePlanTaskResponse> yearlyTasks;

  String modelName;

  /// Returns a shallow copy of this [CarePlanGenerationResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CarePlanGenerationResult copyWith({
    int? carePlanId,
    int? animalIdentificationRecordId,
    int? version,
    DateTime? generatedAt,
    double? generationConfidence,
    String? summary,
    int? totalDailyTimeMinutes,
    int? totalWeeklyTimeMinutes,
    List<_i2.CarePlanTaskResponse>? dailyTasks,
    List<_i2.CarePlanTaskResponse>? weeklyTasks,
    List<_i2.CarePlanTaskResponse>? yearlyTasks,
    String? modelName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CarePlanGenerationResult',
      'carePlanId': carePlanId,
      'animalIdentificationRecordId': animalIdentificationRecordId,
      'version': version,
      'generatedAt': generatedAt.toJson(),
      'generationConfidence': generationConfidence,
      if (summary != null) 'summary': summary,
      'totalDailyTimeMinutes': totalDailyTimeMinutes,
      'totalWeeklyTimeMinutes': totalWeeklyTimeMinutes,
      'dailyTasks': dailyTasks.toJson(valueToJson: (v) => v.toJson()),
      'weeklyTasks': weeklyTasks.toJson(valueToJson: (v) => v.toJson()),
      'yearlyTasks': yearlyTasks.toJson(valueToJson: (v) => v.toJson()),
      'modelName': modelName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CarePlanGenerationResultImpl extends CarePlanGenerationResult {
  _CarePlanGenerationResultImpl({
    required int carePlanId,
    required int animalIdentificationRecordId,
    required int version,
    required DateTime generatedAt,
    required double generationConfidence,
    String? summary,
    required int totalDailyTimeMinutes,
    required int totalWeeklyTimeMinutes,
    required List<_i2.CarePlanTaskResponse> dailyTasks,
    required List<_i2.CarePlanTaskResponse> weeklyTasks,
    required List<_i2.CarePlanTaskResponse> yearlyTasks,
    required String modelName,
  }) : super._(
         carePlanId: carePlanId,
         animalIdentificationRecordId: animalIdentificationRecordId,
         version: version,
         generatedAt: generatedAt,
         generationConfidence: generationConfidence,
         summary: summary,
         totalDailyTimeMinutes: totalDailyTimeMinutes,
         totalWeeklyTimeMinutes: totalWeeklyTimeMinutes,
         dailyTasks: dailyTasks,
         weeklyTasks: weeklyTasks,
         yearlyTasks: yearlyTasks,
         modelName: modelName,
       );

  /// Returns a shallow copy of this [CarePlanGenerationResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CarePlanGenerationResult copyWith({
    int? carePlanId,
    int? animalIdentificationRecordId,
    int? version,
    DateTime? generatedAt,
    double? generationConfidence,
    Object? summary = _Undefined,
    int? totalDailyTimeMinutes,
    int? totalWeeklyTimeMinutes,
    List<_i2.CarePlanTaskResponse>? dailyTasks,
    List<_i2.CarePlanTaskResponse>? weeklyTasks,
    List<_i2.CarePlanTaskResponse>? yearlyTasks,
    String? modelName,
  }) {
    return CarePlanGenerationResult(
      carePlanId: carePlanId ?? this.carePlanId,
      animalIdentificationRecordId:
          animalIdentificationRecordId ?? this.animalIdentificationRecordId,
      version: version ?? this.version,
      generatedAt: generatedAt ?? this.generatedAt,
      generationConfidence: generationConfidence ?? this.generationConfidence,
      summary: summary is String? ? summary : this.summary,
      totalDailyTimeMinutes:
          totalDailyTimeMinutes ?? this.totalDailyTimeMinutes,
      totalWeeklyTimeMinutes:
          totalWeeklyTimeMinutes ?? this.totalWeeklyTimeMinutes,
      dailyTasks:
          dailyTasks ?? this.dailyTasks.map((e0) => e0.copyWith()).toList(),
      weeklyTasks:
          weeklyTasks ?? this.weeklyTasks.map((e0) => e0.copyWith()).toList(),
      yearlyTasks:
          yearlyTasks ?? this.yearlyTasks.map((e0) => e0.copyWith()).toList(),
      modelName: modelName ?? this.modelName,
    );
  }
}
