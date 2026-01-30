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
import 'adoption_info.dart' as _i2;
import 'animal_care_plan.dart' as _i3;
import 'animal_identification_record.dart' as _i4;
import 'behavior_analysis_insight.dart' as _i5;
import 'behavior_analysis_result.dart' as _i6;
import 'behavior_frame_insight.dart' as _i7;
import 'care_plan_generation_result.dart' as _i8;
import 'care_plan_response.dart' as _i9;
import 'care_plan_task.dart' as _i10;
import 'greetings/greeting.dart' as _i11;
import 'magic_link_token.dart' as _i12;
import 'rate_limit_counter.dart' as _i13;
import 'package:oisely_client/src/protocol/animal_care_plan.dart' as _i14;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i15;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i16;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i17;
export 'adoption_info.dart';
export 'animal_care_plan.dart';
export 'animal_identification_record.dart';
export 'behavior_analysis_insight.dart';
export 'behavior_analysis_result.dart';
export 'behavior_frame_insight.dart';
export 'care_plan_generation_result.dart';
export 'care_plan_response.dart';
export 'care_plan_task.dart';
export 'greetings/greeting.dart';
export 'magic_link_token.dart';
export 'rate_limit_counter.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.AdoptionInfo) {
      return _i2.AdoptionInfo.fromJson(data) as T;
    }
    if (t == _i3.AnimalCarePlan) {
      return _i3.AnimalCarePlan.fromJson(data) as T;
    }
    if (t == _i4.AnimalIdentificationRecord) {
      return _i4.AnimalIdentificationRecord.fromJson(data) as T;
    }
    if (t == _i5.BehaviorAnalysisInsight) {
      return _i5.BehaviorAnalysisInsight.fromJson(data) as T;
    }
    if (t == _i6.BehaviorAnalysisResult) {
      return _i6.BehaviorAnalysisResult.fromJson(data) as T;
    }
    if (t == _i7.BehaviorFrameInsight) {
      return _i7.BehaviorFrameInsight.fromJson(data) as T;
    }
    if (t == _i8.CarePlanGenerationResult) {
      return _i8.CarePlanGenerationResult.fromJson(data) as T;
    }
    if (t == _i9.CarePlanTaskResponse) {
      return _i9.CarePlanTaskResponse.fromJson(data) as T;
    }
    if (t == _i10.CarePlanTask) {
      return _i10.CarePlanTask.fromJson(data) as T;
    }
    if (t == _i11.Greeting) {
      return _i11.Greeting.fromJson(data) as T;
    }
    if (t == _i12.MagicLinkToken) {
      return _i12.MagicLinkToken.fromJson(data) as T;
    }
    if (t == _i13.RateLimitCounter) {
      return _i13.RateLimitCounter.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AdoptionInfo?>()) {
      return (data != null ? _i2.AdoptionInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AnimalCarePlan?>()) {
      return (data != null ? _i3.AnimalCarePlan.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AnimalIdentificationRecord?>()) {
      return (data != null
              ? _i4.AnimalIdentificationRecord.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i5.BehaviorAnalysisInsight?>()) {
      return (data != null ? _i5.BehaviorAnalysisInsight.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.BehaviorAnalysisResult?>()) {
      return (data != null ? _i6.BehaviorAnalysisResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.BehaviorFrameInsight?>()) {
      return (data != null ? _i7.BehaviorFrameInsight.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.CarePlanGenerationResult?>()) {
      return (data != null ? _i8.CarePlanGenerationResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.CarePlanTaskResponse?>()) {
      return (data != null ? _i9.CarePlanTaskResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.CarePlanTask?>()) {
      return (data != null ? _i10.CarePlanTask.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Greeting?>()) {
      return (data != null ? _i11.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.MagicLinkToken?>()) {
      return (data != null ? _i12.MagicLinkToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.RateLimitCounter?>()) {
      return (data != null ? _i13.RateLimitCounter.fromJson(data) : null) as T;
    }
    if (t == List<_i10.CarePlanTask>) {
      return (data as List)
              .map((e) => deserialize<_i10.CarePlanTask>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i10.CarePlanTask>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i10.CarePlanTask>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i7.BehaviorFrameInsight>) {
      return (data as List)
              .map((e) => deserialize<_i7.BehaviorFrameInsight>(e))
              .toList()
          as T;
    }
    if (t == List<_i9.CarePlanTaskResponse>) {
      return (data as List)
              .map((e) => deserialize<_i9.CarePlanTaskResponse>(e))
              .toList()
          as T;
    }
    if (t == List<_i14.AnimalCarePlan>) {
      return (data as List)
              .map((e) => deserialize<_i14.AnimalCarePlan>(e))
              .toList()
          as T;
    }
    try {
      return _i15.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i16.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i17.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AdoptionInfo => 'AdoptionInfo',
      _i3.AnimalCarePlan => 'AnimalCarePlan',
      _i4.AnimalIdentificationRecord => 'AnimalIdentificationRecord',
      _i5.BehaviorAnalysisInsight => 'BehaviorAnalysisInsight',
      _i6.BehaviorAnalysisResult => 'BehaviorAnalysisResult',
      _i7.BehaviorFrameInsight => 'BehaviorFrameInsight',
      _i8.CarePlanGenerationResult => 'CarePlanGenerationResult',
      _i9.CarePlanTaskResponse => 'CarePlanTaskResponse',
      _i10.CarePlanTask => 'CarePlanTask',
      _i11.Greeting => 'Greeting',
      _i12.MagicLinkToken => 'MagicLinkToken',
      _i13.RateLimitCounter => 'RateLimitCounter',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('oisely.', '');
    }

    switch (data) {
      case _i2.AdoptionInfo():
        return 'AdoptionInfo';
      case _i3.AnimalCarePlan():
        return 'AnimalCarePlan';
      case _i4.AnimalIdentificationRecord():
        return 'AnimalIdentificationRecord';
      case _i5.BehaviorAnalysisInsight():
        return 'BehaviorAnalysisInsight';
      case _i6.BehaviorAnalysisResult():
        return 'BehaviorAnalysisResult';
      case _i7.BehaviorFrameInsight():
        return 'BehaviorFrameInsight';
      case _i8.CarePlanGenerationResult():
        return 'CarePlanGenerationResult';
      case _i9.CarePlanTaskResponse():
        return 'CarePlanTaskResponse';
      case _i10.CarePlanTask():
        return 'CarePlanTask';
      case _i11.Greeting():
        return 'Greeting';
      case _i12.MagicLinkToken():
        return 'MagicLinkToken';
      case _i13.RateLimitCounter():
        return 'RateLimitCounter';
    }
    className = _i15.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    className = _i16.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i17.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AdoptionInfo') {
      return deserialize<_i2.AdoptionInfo>(data['data']);
    }
    if (dataClassName == 'AnimalCarePlan') {
      return deserialize<_i3.AnimalCarePlan>(data['data']);
    }
    if (dataClassName == 'AnimalIdentificationRecord') {
      return deserialize<_i4.AnimalIdentificationRecord>(data['data']);
    }
    if (dataClassName == 'BehaviorAnalysisInsight') {
      return deserialize<_i5.BehaviorAnalysisInsight>(data['data']);
    }
    if (dataClassName == 'BehaviorAnalysisResult') {
      return deserialize<_i6.BehaviorAnalysisResult>(data['data']);
    }
    if (dataClassName == 'BehaviorFrameInsight') {
      return deserialize<_i7.BehaviorFrameInsight>(data['data']);
    }
    if (dataClassName == 'CarePlanGenerationResult') {
      return deserialize<_i8.CarePlanGenerationResult>(data['data']);
    }
    if (dataClassName == 'CarePlanTaskResponse') {
      return deserialize<_i9.CarePlanTaskResponse>(data['data']);
    }
    if (dataClassName == 'CarePlanTask') {
      return deserialize<_i10.CarePlanTask>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i11.Greeting>(data['data']);
    }
    if (dataClassName == 'MagicLinkToken') {
      return deserialize<_i12.MagicLinkToken>(data['data']);
    }
    if (dataClassName == 'RateLimitCounter') {
      return deserialize<_i13.RateLimitCounter>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i15.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i16.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i17.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i15.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i16.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i17.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
