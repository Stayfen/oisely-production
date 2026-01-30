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
import 'nearby_place.dart' as _i2;
import 'package:oisely_client/src/protocol/protocol.dart' as _i3;

abstract class NearbyPlacesResponse implements _i1.SerializableModel {
  NearbyPlacesResponse._({
    required this.places,
    this.nextPageToken,
    required this.status,
  });

  factory NearbyPlacesResponse({
    required List<_i2.NearbyPlace> places,
    String? nextPageToken,
    required String status,
  }) = _NearbyPlacesResponseImpl;

  factory NearbyPlacesResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return NearbyPlacesResponse(
      places: _i3.Protocol().deserialize<List<_i2.NearbyPlace>>(
        jsonSerialization['places'],
      ),
      nextPageToken: jsonSerialization['nextPageToken'] as String?,
      status: jsonSerialization['status'] as String,
    );
  }

  List<_i2.NearbyPlace> places;

  String? nextPageToken;

  String status;

  /// Returns a shallow copy of this [NearbyPlacesResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  NearbyPlacesResponse copyWith({
    List<_i2.NearbyPlace>? places,
    String? nextPageToken,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NearbyPlacesResponse',
      'places': places.toJson(valueToJson: (v) => v.toJson()),
      if (nextPageToken != null) 'nextPageToken': nextPageToken,
      'status': status,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NearbyPlacesResponseImpl extends NearbyPlacesResponse {
  _NearbyPlacesResponseImpl({
    required List<_i2.NearbyPlace> places,
    String? nextPageToken,
    required String status,
  }) : super._(
         places: places,
         nextPageToken: nextPageToken,
         status: status,
       );

  /// Returns a shallow copy of this [NearbyPlacesResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  NearbyPlacesResponse copyWith({
    List<_i2.NearbyPlace>? places,
    Object? nextPageToken = _Undefined,
    String? status,
  }) {
    return NearbyPlacesResponse(
      places: places ?? this.places.map((e0) => e0.copyWith()).toList(),
      nextPageToken: nextPageToken is String?
          ? nextPageToken
          : this.nextPageToken,
      status: status ?? this.status,
    );
  }
}
