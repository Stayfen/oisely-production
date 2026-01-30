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

abstract class BehaviorFrameInsight implements _i1.SerializableModel {
  BehaviorFrameInsight._({
    required this.timestampSeconds,
    required this.action,
    this.bodyLanguage,
  });

  factory BehaviorFrameInsight({
    required double timestampSeconds,
    required String action,
    String? bodyLanguage,
  }) = _BehaviorFrameInsightImpl;

  factory BehaviorFrameInsight.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return BehaviorFrameInsight(
      timestampSeconds: (jsonSerialization['timestampSeconds'] as num)
          .toDouble(),
      action: jsonSerialization['action'] as String,
      bodyLanguage: jsonSerialization['bodyLanguage'] as String?,
    );
  }

  double timestampSeconds;

  String action;

  String? bodyLanguage;

  /// Returns a shallow copy of this [BehaviorFrameInsight]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BehaviorFrameInsight copyWith({
    double? timestampSeconds,
    String? action,
    String? bodyLanguage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BehaviorFrameInsight',
      'timestampSeconds': timestampSeconds,
      'action': action,
      if (bodyLanguage != null) 'bodyLanguage': bodyLanguage,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BehaviorFrameInsightImpl extends BehaviorFrameInsight {
  _BehaviorFrameInsightImpl({
    required double timestampSeconds,
    required String action,
    String? bodyLanguage,
  }) : super._(
         timestampSeconds: timestampSeconds,
         action: action,
         bodyLanguage: bodyLanguage,
       );

  /// Returns a shallow copy of this [BehaviorFrameInsight]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BehaviorFrameInsight copyWith({
    double? timestampSeconds,
    String? action,
    Object? bodyLanguage = _Undefined,
  }) {
    return BehaviorFrameInsight(
      timestampSeconds: timestampSeconds ?? this.timestampSeconds,
      action: action ?? this.action,
      bodyLanguage: bodyLanguage is String? ? bodyLanguage : this.bodyLanguage,
    );
  }
}
