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

abstract class AdoptionInfo
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AdoptionInfo._({
    required this.species,
    this.breed,
    required this.adoptionCost,
    required this.dietaryRequirements,
    required this.livingEnvironment,
    required this.careInstructions,
    required this.dailyTimeCommitment,
    required this.averageLifespan,
    required this.breedSpecificInfo,
    required this.legalRequirements,
    required this.confidence,
  });

  factory AdoptionInfo({
    required String species,
    String? breed,
    required String adoptionCost,
    required String dietaryRequirements,
    required String livingEnvironment,
    required String careInstructions,
    required String dailyTimeCommitment,
    required String averageLifespan,
    required String breedSpecificInfo,
    required String legalRequirements,
    required double confidence,
  }) = _AdoptionInfoImpl;

  factory AdoptionInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdoptionInfo(
      species: jsonSerialization['species'] as String,
      breed: jsonSerialization['breed'] as String?,
      adoptionCost: jsonSerialization['adoptionCost'] as String,
      dietaryRequirements: jsonSerialization['dietaryRequirements'] as String,
      livingEnvironment: jsonSerialization['livingEnvironment'] as String,
      careInstructions: jsonSerialization['careInstructions'] as String,
      dailyTimeCommitment: jsonSerialization['dailyTimeCommitment'] as String,
      averageLifespan: jsonSerialization['averageLifespan'] as String,
      breedSpecificInfo: jsonSerialization['breedSpecificInfo'] as String,
      legalRequirements: jsonSerialization['legalRequirements'] as String,
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
    );
  }

  String species;

  String? breed;

  String adoptionCost;

  String dietaryRequirements;

  String livingEnvironment;

  String careInstructions;

  String dailyTimeCommitment;

  String averageLifespan;

  String breedSpecificInfo;

  String legalRequirements;

  double confidence;

  /// Returns a shallow copy of this [AdoptionInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdoptionInfo copyWith({
    String? species,
    String? breed,
    String? adoptionCost,
    String? dietaryRequirements,
    String? livingEnvironment,
    String? careInstructions,
    String? dailyTimeCommitment,
    String? averageLifespan,
    String? breedSpecificInfo,
    String? legalRequirements,
    double? confidence,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdoptionInfo',
      'species': species,
      if (breed != null) 'breed': breed,
      'adoptionCost': adoptionCost,
      'dietaryRequirements': dietaryRequirements,
      'livingEnvironment': livingEnvironment,
      'careInstructions': careInstructions,
      'dailyTimeCommitment': dailyTimeCommitment,
      'averageLifespan': averageLifespan,
      'breedSpecificInfo': breedSpecificInfo,
      'legalRequirements': legalRequirements,
      'confidence': confidence,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdoptionInfo',
      'species': species,
      if (breed != null) 'breed': breed,
      'adoptionCost': adoptionCost,
      'dietaryRequirements': dietaryRequirements,
      'livingEnvironment': livingEnvironment,
      'careInstructions': careInstructions,
      'dailyTimeCommitment': dailyTimeCommitment,
      'averageLifespan': averageLifespan,
      'breedSpecificInfo': breedSpecificInfo,
      'legalRequirements': legalRequirements,
      'confidence': confidence,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdoptionInfoImpl extends AdoptionInfo {
  _AdoptionInfoImpl({
    required String species,
    String? breed,
    required String adoptionCost,
    required String dietaryRequirements,
    required String livingEnvironment,
    required String careInstructions,
    required String dailyTimeCommitment,
    required String averageLifespan,
    required String breedSpecificInfo,
    required String legalRequirements,
    required double confidence,
  }) : super._(
         species: species,
         breed: breed,
         adoptionCost: adoptionCost,
         dietaryRequirements: dietaryRequirements,
         livingEnvironment: livingEnvironment,
         careInstructions: careInstructions,
         dailyTimeCommitment: dailyTimeCommitment,
         averageLifespan: averageLifespan,
         breedSpecificInfo: breedSpecificInfo,
         legalRequirements: legalRequirements,
         confidence: confidence,
       );

  /// Returns a shallow copy of this [AdoptionInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdoptionInfo copyWith({
    String? species,
    Object? breed = _Undefined,
    String? adoptionCost,
    String? dietaryRequirements,
    String? livingEnvironment,
    String? careInstructions,
    String? dailyTimeCommitment,
    String? averageLifespan,
    String? breedSpecificInfo,
    String? legalRequirements,
    double? confidence,
  }) {
    return AdoptionInfo(
      species: species ?? this.species,
      breed: breed is String? ? breed : this.breed,
      adoptionCost: adoptionCost ?? this.adoptionCost,
      dietaryRequirements: dietaryRequirements ?? this.dietaryRequirements,
      livingEnvironment: livingEnvironment ?? this.livingEnvironment,
      careInstructions: careInstructions ?? this.careInstructions,
      dailyTimeCommitment: dailyTimeCommitment ?? this.dailyTimeCommitment,
      averageLifespan: averageLifespan ?? this.averageLifespan,
      breedSpecificInfo: breedSpecificInfo ?? this.breedSpecificInfo,
      legalRequirements: legalRequirements ?? this.legalRequirements,
      confidence: confidence ?? this.confidence,
    );
  }
}
