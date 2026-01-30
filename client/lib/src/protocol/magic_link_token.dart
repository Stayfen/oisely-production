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

abstract class MagicLinkToken implements _i1.SerializableModel {
  MagicLinkToken._({
    this.id,
    required this.token,
    required this.email,
    required this.requestedAt,
    required this.expiration,
  });

  factory MagicLinkToken({
    int? id,
    required String token,
    required String email,
    required DateTime requestedAt,
    required DateTime expiration,
  }) = _MagicLinkTokenImpl;

  factory MagicLinkToken.fromJson(Map<String, dynamic> jsonSerialization) {
    return MagicLinkToken(
      id: jsonSerialization['id'] as int?,
      token: jsonSerialization['token'] as String,
      email: jsonSerialization['email'] as String,
      requestedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['requestedAt'],
      ),
      expiration: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiration'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String token;

  String email;

  DateTime requestedAt;

  DateTime expiration;

  /// Returns a shallow copy of this [MagicLinkToken]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MagicLinkToken copyWith({
    int? id,
    String? token,
    String? email,
    DateTime? requestedAt,
    DateTime? expiration,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MagicLinkToken',
      if (id != null) 'id': id,
      'token': token,
      'email': email,
      'requestedAt': requestedAt.toJson(),
      'expiration': expiration.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MagicLinkTokenImpl extends MagicLinkToken {
  _MagicLinkTokenImpl({
    int? id,
    required String token,
    required String email,
    required DateTime requestedAt,
    required DateTime expiration,
  }) : super._(
         id: id,
         token: token,
         email: email,
         requestedAt: requestedAt,
         expiration: expiration,
       );

  /// Returns a shallow copy of this [MagicLinkToken]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MagicLinkToken copyWith({
    Object? id = _Undefined,
    String? token,
    String? email,
    DateTime? requestedAt,
    DateTime? expiration,
  }) {
    return MagicLinkToken(
      id: id is int? ? id : this.id,
      token: token ?? this.token,
      email: email ?? this.email,
      requestedAt: requestedAt ?? this.requestedAt,
      expiration: expiration ?? this.expiration,
    );
  }
}
