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
import 'package:oisely_client/src/protocol/protocol.dart' as _i2;

abstract class NearbyPlace implements _i1.SerializableModel {
  NearbyPlace._({
    required this.placeId,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.rating,
    this.userRatingsTotal,
    this.isOpen,
    this.photoReference,
    required this.types,
    this.distance,
  });

  factory NearbyPlace({
    required String placeId,
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    double? rating,
    int? userRatingsTotal,
    bool? isOpen,
    String? photoReference,
    required List<String> types,
    double? distance,
  }) = _NearbyPlaceImpl;

  factory NearbyPlace.fromJson(Map<String, dynamic> jsonSerialization) {
    return NearbyPlace(
      placeId: jsonSerialization['placeId'] as String,
      name: jsonSerialization['name'] as String,
      address: jsonSerialization['address'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      rating: (jsonSerialization['rating'] as num?)?.toDouble(),
      userRatingsTotal: jsonSerialization['userRatingsTotal'] as int?,
      isOpen: jsonSerialization['isOpen'] as bool?,
      photoReference: jsonSerialization['photoReference'] as String?,
      types: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['types'],
      ),
      distance: (jsonSerialization['distance'] as num?)?.toDouble(),
    );
  }

  String placeId;

  String name;

  String address;

  double latitude;

  double longitude;

  double? rating;

  int? userRatingsTotal;

  bool? isOpen;

  String? photoReference;

  List<String> types;

  double? distance;

  /// Returns a shallow copy of this [NearbyPlace]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  NearbyPlace copyWith({
    String? placeId,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    double? rating,
    int? userRatingsTotal,
    bool? isOpen,
    String? photoReference,
    List<String>? types,
    double? distance,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NearbyPlace',
      'placeId': placeId,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      if (rating != null) 'rating': rating,
      if (userRatingsTotal != null) 'userRatingsTotal': userRatingsTotal,
      if (isOpen != null) 'isOpen': isOpen,
      if (photoReference != null) 'photoReference': photoReference,
      'types': types.toJson(),
      if (distance != null) 'distance': distance,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NearbyPlaceImpl extends NearbyPlace {
  _NearbyPlaceImpl({
    required String placeId,
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    double? rating,
    int? userRatingsTotal,
    bool? isOpen,
    String? photoReference,
    required List<String> types,
    double? distance,
  }) : super._(
         placeId: placeId,
         name: name,
         address: address,
         latitude: latitude,
         longitude: longitude,
         rating: rating,
         userRatingsTotal: userRatingsTotal,
         isOpen: isOpen,
         photoReference: photoReference,
         types: types,
         distance: distance,
       );

  /// Returns a shallow copy of this [NearbyPlace]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  NearbyPlace copyWith({
    String? placeId,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    Object? rating = _Undefined,
    Object? userRatingsTotal = _Undefined,
    Object? isOpen = _Undefined,
    Object? photoReference = _Undefined,
    List<String>? types,
    Object? distance = _Undefined,
  }) {
    return NearbyPlace(
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      rating: rating is double? ? rating : this.rating,
      userRatingsTotal: userRatingsTotal is int?
          ? userRatingsTotal
          : this.userRatingsTotal,
      isOpen: isOpen is bool? ? isOpen : this.isOpen,
      photoReference: photoReference is String?
          ? photoReference
          : this.photoReference,
      types: types ?? this.types.map((e0) => e0).toList(),
      distance: distance is double? ? distance : this.distance,
    );
  }
}
