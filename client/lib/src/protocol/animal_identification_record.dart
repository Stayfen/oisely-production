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

abstract class AnimalIdentificationRecord implements _i1.SerializableModel {
  AnimalIdentificationRecord._({
    this.id,
    required this.userIdentifier,
    required this.species,
    this.breed,
    required this.confidence,
    required this.createdAt,
    required this.imageSha256,
    required this.modelName,
  });

  factory AnimalIdentificationRecord({
    int? id,
    required String userIdentifier,
    required String species,
    String? breed,
    required double confidence,
    required DateTime createdAt,
    required String imageSha256,
    required String modelName,
  }) = _AnimalIdentificationRecordImpl;

  factory AnimalIdentificationRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AnimalIdentificationRecord(
      id: jsonSerialization['id'] as int?,
      userIdentifier: jsonSerialization['userIdentifier'] as String,
      species: jsonSerialization['species'] as String,
      breed: jsonSerialization['breed'] as String?,
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      imageSha256: jsonSerialization['imageSha256'] as String,
      modelName: jsonSerialization['modelName'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String userIdentifier;

  String species;

  String? breed;

  double confidence;

  DateTime createdAt;

  String imageSha256;

  String modelName;

  /// Returns a shallow copy of this [AnimalIdentificationRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AnimalIdentificationRecord copyWith({
    int? id,
    String? userIdentifier,
    String? species,
    String? breed,
    double? confidence,
    DateTime? createdAt,
    String? imageSha256,
    String? modelName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnimalIdentificationRecord',
      if (id != null) 'id': id,
      'userIdentifier': userIdentifier,
      'species': species,
      if (breed != null) 'breed': breed,
      'confidence': confidence,
      'createdAt': createdAt.toJson(),
      'imageSha256': imageSha256,
      'modelName': modelName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnimalIdentificationRecordImpl extends AnimalIdentificationRecord {
  _AnimalIdentificationRecordImpl({
    int? id,
    required String userIdentifier,
    required String species,
    String? breed,
    required double confidence,
    required DateTime createdAt,
    required String imageSha256,
    required String modelName,
  }) : super._(
         id: id,
         userIdentifier: userIdentifier,
         species: species,
         breed: breed,
         confidence: confidence,
         createdAt: createdAt,
         imageSha256: imageSha256,
         modelName: modelName,
       );

  /// Returns a shallow copy of this [AnimalIdentificationRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AnimalIdentificationRecord copyWith({
    Object? id = _Undefined,
    String? userIdentifier,
    String? species,
    Object? breed = _Undefined,
    double? confidence,
    DateTime? createdAt,
    String? imageSha256,
    String? modelName,
  }) {
    return AnimalIdentificationRecord(
      id: id is int? ? id : this.id,
      userIdentifier: userIdentifier ?? this.userIdentifier,
      species: species ?? this.species,
      breed: breed is String? ? breed : this.breed,
      confidence: confidence ?? this.confidence,
      createdAt: createdAt ?? this.createdAt,
      imageSha256: imageSha256 ?? this.imageSha256,
      modelName: modelName ?? this.modelName,
    );
  }
}
