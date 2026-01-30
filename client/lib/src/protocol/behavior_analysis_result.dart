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

abstract class BehaviorAnalysisResult implements _i1.SerializableModel {
  BehaviorAnalysisResult._({
    this.id,
    required this.userIdentifier,
    required this.createdAt,
    required this.requestId,
    required this.videoSha256,
    required this.videoDurationSeconds,
    this.identifiedSpecies,
    this.identifiedBreed,
    required this.activityLevel,
    required this.emotionalState,
    required this.behaviorPatternsJson,
    required this.movementSummary,
    required this.postureSummary,
    required this.vocalizationSummary,
    required this.movementPatternsJson,
    required this.vocalizationPatternsJson,
    required this.keyFramesJson,
    required this.analysisConfidence,
    required this.modelName,
    required this.modelResponseCiphertext,
    required this.modelResponseNonce,
    required this.modelResponseMac,
  });

  factory BehaviorAnalysisResult({
    int? id,
    required String userIdentifier,
    required DateTime createdAt,
    required String requestId,
    required String videoSha256,
    required double videoDurationSeconds,
    String? identifiedSpecies,
    String? identifiedBreed,
    required String activityLevel,
    required String emotionalState,
    required String behaviorPatternsJson,
    required String movementSummary,
    required String postureSummary,
    required String vocalizationSummary,
    required String movementPatternsJson,
    required String vocalizationPatternsJson,
    required String keyFramesJson,
    required double analysisConfidence,
    required String modelName,
    required String modelResponseCiphertext,
    required String modelResponseNonce,
    required String modelResponseMac,
  }) = _BehaviorAnalysisResultImpl;

  factory BehaviorAnalysisResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return BehaviorAnalysisResult(
      id: jsonSerialization['id'] as int?,
      userIdentifier: jsonSerialization['userIdentifier'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      requestId: jsonSerialization['requestId'] as String,
      videoSha256: jsonSerialization['videoSha256'] as String,
      videoDurationSeconds: (jsonSerialization['videoDurationSeconds'] as num)
          .toDouble(),
      identifiedSpecies: jsonSerialization['identifiedSpecies'] as String?,
      identifiedBreed: jsonSerialization['identifiedBreed'] as String?,
      activityLevel: jsonSerialization['activityLevel'] as String,
      emotionalState: jsonSerialization['emotionalState'] as String,
      behaviorPatternsJson: jsonSerialization['behaviorPatternsJson'] as String,
      movementSummary: jsonSerialization['movementSummary'] as String,
      postureSummary: jsonSerialization['postureSummary'] as String,
      vocalizationSummary: jsonSerialization['vocalizationSummary'] as String,
      movementPatternsJson: jsonSerialization['movementPatternsJson'] as String,
      vocalizationPatternsJson:
          jsonSerialization['vocalizationPatternsJson'] as String,
      keyFramesJson: jsonSerialization['keyFramesJson'] as String,
      analysisConfidence: (jsonSerialization['analysisConfidence'] as num)
          .toDouble(),
      modelName: jsonSerialization['modelName'] as String,
      modelResponseCiphertext:
          jsonSerialization['modelResponseCiphertext'] as String,
      modelResponseNonce: jsonSerialization['modelResponseNonce'] as String,
      modelResponseMac: jsonSerialization['modelResponseMac'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String userIdentifier;

  DateTime createdAt;

  String requestId;

  String videoSha256;

  double videoDurationSeconds;

  String? identifiedSpecies;

  String? identifiedBreed;

  String activityLevel;

  String emotionalState;

  String behaviorPatternsJson;

  String movementSummary;

  String postureSummary;

  String vocalizationSummary;

  String movementPatternsJson;

  String vocalizationPatternsJson;

  String keyFramesJson;

  double analysisConfidence;

  String modelName;

  String modelResponseCiphertext;

  String modelResponseNonce;

  String modelResponseMac;

  /// Returns a shallow copy of this [BehaviorAnalysisResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BehaviorAnalysisResult copyWith({
    int? id,
    String? userIdentifier,
    DateTime? createdAt,
    String? requestId,
    String? videoSha256,
    double? videoDurationSeconds,
    String? identifiedSpecies,
    String? identifiedBreed,
    String? activityLevel,
    String? emotionalState,
    String? behaviorPatternsJson,
    String? movementSummary,
    String? postureSummary,
    String? vocalizationSummary,
    String? movementPatternsJson,
    String? vocalizationPatternsJson,
    String? keyFramesJson,
    double? analysisConfidence,
    String? modelName,
    String? modelResponseCiphertext,
    String? modelResponseNonce,
    String? modelResponseMac,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BehaviorAnalysisResult',
      if (id != null) 'id': id,
      'userIdentifier': userIdentifier,
      'createdAt': createdAt.toJson(),
      'requestId': requestId,
      'videoSha256': videoSha256,
      'videoDurationSeconds': videoDurationSeconds,
      if (identifiedSpecies != null) 'identifiedSpecies': identifiedSpecies,
      if (identifiedBreed != null) 'identifiedBreed': identifiedBreed,
      'activityLevel': activityLevel,
      'emotionalState': emotionalState,
      'behaviorPatternsJson': behaviorPatternsJson,
      'movementSummary': movementSummary,
      'postureSummary': postureSummary,
      'vocalizationSummary': vocalizationSummary,
      'movementPatternsJson': movementPatternsJson,
      'vocalizationPatternsJson': vocalizationPatternsJson,
      'keyFramesJson': keyFramesJson,
      'analysisConfidence': analysisConfidence,
      'modelName': modelName,
      'modelResponseCiphertext': modelResponseCiphertext,
      'modelResponseNonce': modelResponseNonce,
      'modelResponseMac': modelResponseMac,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BehaviorAnalysisResultImpl extends BehaviorAnalysisResult {
  _BehaviorAnalysisResultImpl({
    int? id,
    required String userIdentifier,
    required DateTime createdAt,
    required String requestId,
    required String videoSha256,
    required double videoDurationSeconds,
    String? identifiedSpecies,
    String? identifiedBreed,
    required String activityLevel,
    required String emotionalState,
    required String behaviorPatternsJson,
    required String movementSummary,
    required String postureSummary,
    required String vocalizationSummary,
    required String movementPatternsJson,
    required String vocalizationPatternsJson,
    required String keyFramesJson,
    required double analysisConfidence,
    required String modelName,
    required String modelResponseCiphertext,
    required String modelResponseNonce,
    required String modelResponseMac,
  }) : super._(
         id: id,
         userIdentifier: userIdentifier,
         createdAt: createdAt,
         requestId: requestId,
         videoSha256: videoSha256,
         videoDurationSeconds: videoDurationSeconds,
         identifiedSpecies: identifiedSpecies,
         identifiedBreed: identifiedBreed,
         activityLevel: activityLevel,
         emotionalState: emotionalState,
         behaviorPatternsJson: behaviorPatternsJson,
         movementSummary: movementSummary,
         postureSummary: postureSummary,
         vocalizationSummary: vocalizationSummary,
         movementPatternsJson: movementPatternsJson,
         vocalizationPatternsJson: vocalizationPatternsJson,
         keyFramesJson: keyFramesJson,
         analysisConfidence: analysisConfidence,
         modelName: modelName,
         modelResponseCiphertext: modelResponseCiphertext,
         modelResponseNonce: modelResponseNonce,
         modelResponseMac: modelResponseMac,
       );

  /// Returns a shallow copy of this [BehaviorAnalysisResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BehaviorAnalysisResult copyWith({
    Object? id = _Undefined,
    String? userIdentifier,
    DateTime? createdAt,
    String? requestId,
    String? videoSha256,
    double? videoDurationSeconds,
    Object? identifiedSpecies = _Undefined,
    Object? identifiedBreed = _Undefined,
    String? activityLevel,
    String? emotionalState,
    String? behaviorPatternsJson,
    String? movementSummary,
    String? postureSummary,
    String? vocalizationSummary,
    String? movementPatternsJson,
    String? vocalizationPatternsJson,
    String? keyFramesJson,
    double? analysisConfidence,
    String? modelName,
    String? modelResponseCiphertext,
    String? modelResponseNonce,
    String? modelResponseMac,
  }) {
    return BehaviorAnalysisResult(
      id: id is int? ? id : this.id,
      userIdentifier: userIdentifier ?? this.userIdentifier,
      createdAt: createdAt ?? this.createdAt,
      requestId: requestId ?? this.requestId,
      videoSha256: videoSha256 ?? this.videoSha256,
      videoDurationSeconds: videoDurationSeconds ?? this.videoDurationSeconds,
      identifiedSpecies: identifiedSpecies is String?
          ? identifiedSpecies
          : this.identifiedSpecies,
      identifiedBreed: identifiedBreed is String?
          ? identifiedBreed
          : this.identifiedBreed,
      activityLevel: activityLevel ?? this.activityLevel,
      emotionalState: emotionalState ?? this.emotionalState,
      behaviorPatternsJson: behaviorPatternsJson ?? this.behaviorPatternsJson,
      movementSummary: movementSummary ?? this.movementSummary,
      postureSummary: postureSummary ?? this.postureSummary,
      vocalizationSummary: vocalizationSummary ?? this.vocalizationSummary,
      movementPatternsJson: movementPatternsJson ?? this.movementPatternsJson,
      vocalizationPatternsJson:
          vocalizationPatternsJson ?? this.vocalizationPatternsJson,
      keyFramesJson: keyFramesJson ?? this.keyFramesJson,
      analysisConfidence: analysisConfidence ?? this.analysisConfidence,
      modelName: modelName ?? this.modelName,
      modelResponseCiphertext:
          modelResponseCiphertext ?? this.modelResponseCiphertext,
      modelResponseNonce: modelResponseNonce ?? this.modelResponseNonce,
      modelResponseMac: modelResponseMac ?? this.modelResponseMac,
    );
  }
}
