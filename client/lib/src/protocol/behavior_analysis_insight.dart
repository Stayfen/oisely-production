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
import 'behavior_frame_insight.dart' as _i2;
import 'package:oisely_client/src/protocol/protocol.dart' as _i3;

abstract class BehaviorAnalysisInsight implements _i1.SerializableModel {
  BehaviorAnalysisInsight._({
    required this.analysisId,
    this.identifiedSpecies,
    this.identifiedBreed,
    required this.activityLevel,
    required this.emotionalState,
    required this.behaviorPatterns,
    required this.movementSummary,
    required this.postureSummary,
    required this.vocalizationSummary,
    required this.movementPatterns,
    required this.vocalizationPatterns,
    required this.keyFrames,
    required this.analysisConfidence,
    required this.videoDurationSeconds,
    required this.modelName,
    required this.requestId,
  });

  factory BehaviorAnalysisInsight({
    required int analysisId,
    String? identifiedSpecies,
    String? identifiedBreed,
    required String activityLevel,
    required String emotionalState,
    required List<String> behaviorPatterns,
    required String movementSummary,
    required String postureSummary,
    required String vocalizationSummary,
    required List<String> movementPatterns,
    required List<String> vocalizationPatterns,
    required List<_i2.BehaviorFrameInsight> keyFrames,
    required double analysisConfidence,
    required double videoDurationSeconds,
    required String modelName,
    required String requestId,
  }) = _BehaviorAnalysisInsightImpl;

  factory BehaviorAnalysisInsight.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return BehaviorAnalysisInsight(
      analysisId: jsonSerialization['analysisId'] as int,
      identifiedSpecies: jsonSerialization['identifiedSpecies'] as String?,
      identifiedBreed: jsonSerialization['identifiedBreed'] as String?,
      activityLevel: jsonSerialization['activityLevel'] as String,
      emotionalState: jsonSerialization['emotionalState'] as String,
      behaviorPatterns: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['behaviorPatterns'],
      ),
      movementSummary: jsonSerialization['movementSummary'] as String,
      postureSummary: jsonSerialization['postureSummary'] as String,
      vocalizationSummary: jsonSerialization['vocalizationSummary'] as String,
      movementPatterns: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['movementPatterns'],
      ),
      vocalizationPatterns: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['vocalizationPatterns'],
      ),
      keyFrames: _i3.Protocol().deserialize<List<_i2.BehaviorFrameInsight>>(
        jsonSerialization['keyFrames'],
      ),
      analysisConfidence: (jsonSerialization['analysisConfidence'] as num)
          .toDouble(),
      videoDurationSeconds: (jsonSerialization['videoDurationSeconds'] as num)
          .toDouble(),
      modelName: jsonSerialization['modelName'] as String,
      requestId: jsonSerialization['requestId'] as String,
    );
  }

  int analysisId;

  String? identifiedSpecies;

  String? identifiedBreed;

  String activityLevel;

  String emotionalState;

  List<String> behaviorPatterns;

  String movementSummary;

  String postureSummary;

  String vocalizationSummary;

  List<String> movementPatterns;

  List<String> vocalizationPatterns;

  List<_i2.BehaviorFrameInsight> keyFrames;

  double analysisConfidence;

  double videoDurationSeconds;

  String modelName;

  String requestId;

  /// Returns a shallow copy of this [BehaviorAnalysisInsight]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BehaviorAnalysisInsight copyWith({
    int? analysisId,
    String? identifiedSpecies,
    String? identifiedBreed,
    String? activityLevel,
    String? emotionalState,
    List<String>? behaviorPatterns,
    String? movementSummary,
    String? postureSummary,
    String? vocalizationSummary,
    List<String>? movementPatterns,
    List<String>? vocalizationPatterns,
    List<_i2.BehaviorFrameInsight>? keyFrames,
    double? analysisConfidence,
    double? videoDurationSeconds,
    String? modelName,
    String? requestId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BehaviorAnalysisInsight',
      'analysisId': analysisId,
      if (identifiedSpecies != null) 'identifiedSpecies': identifiedSpecies,
      if (identifiedBreed != null) 'identifiedBreed': identifiedBreed,
      'activityLevel': activityLevel,
      'emotionalState': emotionalState,
      'behaviorPatterns': behaviorPatterns.toJson(),
      'movementSummary': movementSummary,
      'postureSummary': postureSummary,
      'vocalizationSummary': vocalizationSummary,
      'movementPatterns': movementPatterns.toJson(),
      'vocalizationPatterns': vocalizationPatterns.toJson(),
      'keyFrames': keyFrames.toJson(valueToJson: (v) => v.toJson()),
      'analysisConfidence': analysisConfidence,
      'videoDurationSeconds': videoDurationSeconds,
      'modelName': modelName,
      'requestId': requestId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BehaviorAnalysisInsightImpl extends BehaviorAnalysisInsight {
  _BehaviorAnalysisInsightImpl({
    required int analysisId,
    String? identifiedSpecies,
    String? identifiedBreed,
    required String activityLevel,
    required String emotionalState,
    required List<String> behaviorPatterns,
    required String movementSummary,
    required String postureSummary,
    required String vocalizationSummary,
    required List<String> movementPatterns,
    required List<String> vocalizationPatterns,
    required List<_i2.BehaviorFrameInsight> keyFrames,
    required double analysisConfidence,
    required double videoDurationSeconds,
    required String modelName,
    required String requestId,
  }) : super._(
         analysisId: analysisId,
         identifiedSpecies: identifiedSpecies,
         identifiedBreed: identifiedBreed,
         activityLevel: activityLevel,
         emotionalState: emotionalState,
         behaviorPatterns: behaviorPatterns,
         movementSummary: movementSummary,
         postureSummary: postureSummary,
         vocalizationSummary: vocalizationSummary,
         movementPatterns: movementPatterns,
         vocalizationPatterns: vocalizationPatterns,
         keyFrames: keyFrames,
         analysisConfidence: analysisConfidence,
         videoDurationSeconds: videoDurationSeconds,
         modelName: modelName,
         requestId: requestId,
       );

  /// Returns a shallow copy of this [BehaviorAnalysisInsight]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BehaviorAnalysisInsight copyWith({
    int? analysisId,
    Object? identifiedSpecies = _Undefined,
    Object? identifiedBreed = _Undefined,
    String? activityLevel,
    String? emotionalState,
    List<String>? behaviorPatterns,
    String? movementSummary,
    String? postureSummary,
    String? vocalizationSummary,
    List<String>? movementPatterns,
    List<String>? vocalizationPatterns,
    List<_i2.BehaviorFrameInsight>? keyFrames,
    double? analysisConfidence,
    double? videoDurationSeconds,
    String? modelName,
    String? requestId,
  }) {
    return BehaviorAnalysisInsight(
      analysisId: analysisId ?? this.analysisId,
      identifiedSpecies: identifiedSpecies is String?
          ? identifiedSpecies
          : this.identifiedSpecies,
      identifiedBreed: identifiedBreed is String?
          ? identifiedBreed
          : this.identifiedBreed,
      activityLevel: activityLevel ?? this.activityLevel,
      emotionalState: emotionalState ?? this.emotionalState,
      behaviorPatterns:
          behaviorPatterns ?? this.behaviorPatterns.map((e0) => e0).toList(),
      movementSummary: movementSummary ?? this.movementSummary,
      postureSummary: postureSummary ?? this.postureSummary,
      vocalizationSummary: vocalizationSummary ?? this.vocalizationSummary,
      movementPatterns:
          movementPatterns ?? this.movementPatterns.map((e0) => e0).toList(),
      vocalizationPatterns:
          vocalizationPatterns ??
          this.vocalizationPatterns.map((e0) => e0).toList(),
      keyFrames:
          keyFrames ?? this.keyFrames.map((e0) => e0.copyWith()).toList(),
      analysisConfidence: analysisConfidence ?? this.analysisConfidence,
      videoDurationSeconds: videoDurationSeconds ?? this.videoDurationSeconds,
      modelName: modelName ?? this.modelName,
      requestId: requestId ?? this.requestId,
    );
  }
}
