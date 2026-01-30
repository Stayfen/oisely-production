import 'dart:convert';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class NearbyServicesEndpoint extends Endpoint {
  static const _baseUrl =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json';

  @override
  bool get requireLogin => true;

  /// Search for nearby pet services (veterinarians and pet stores)
  /// [latitude] and [longitude] are the user's current location
  /// [radius] is the search radius in meters (default 5000m = 5km)
  /// [types] can be 'veterinary_care', 'pet_store', or 'both'
  /// [pageToken] is used for pagination
  Future<NearbyPlacesResponse> searchNearbyServices(
    Session session,
    double latitude,
    double longitude, {
    int radius = 5000,
    String types = 'both',
    String? pageToken,
  }) async {
    final authInfo = await session.authenticated;
    if (authInfo?.userIdentifier == null) {
      throw Exception('User must be logged in');
    }

    // Rate limiting
    final rateLimitKey = 'nearby_services_${authInfo!.userIdentifier}';
    var rateLimitEntry =
        await session.caches.local.get(rateLimitKey) as RateLimitCounter?;
    var count = rateLimitEntry?.count ?? 0;

    if (count >= 30) {
      throw Exception('Rate limit exceeded. Please try again later.');
    }

    await session.caches.local.put(
      rateLimitKey,
      RateLimitCounter(count: count + 1),
      lifetime: Duration(minutes: 1),
    );

    try {
      final apiKey = _readGooglePlacesApiKey(session);

      // Determine which types to search
      String typeParam;
      switch (types) {
        case 'veterinary_care':
          typeParam = 'veterinary_care';
          break;
        case 'pet_store':
          typeParam = 'pet_store';
          break;
        case 'both':
        default:
          // For 'both', we'll do two requests and merge
          final vetResults = await _fetchPlaces(
            session,
            apiKey,
            latitude,
            longitude,
            radius,
            'veterinary_care',
            pageToken,
          );
          final storeResults = await _fetchPlaces(
            session,
            apiKey,
            latitude,
            longitude,
            radius,
            'pet_store',
            pageToken,
          );

          // Merge and deduplicate results
          final allPlaces = <String, NearbyPlace>{};
          for (final place in vetResults.places) {
            allPlaces[place.placeId] = place;
          }
          for (final place in storeResults.places) {
            allPlaces[place.placeId] = place;
          }

          // Sort by distance
          final sortedPlaces = allPlaces.values.toList()
            ..sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));

          return NearbyPlacesResponse(
            places: sortedPlaces,
            nextPageToken:
                vetResults.nextPageToken ?? storeResults.nextPageToken,
            status: 'OK',
          );
      }

      return await _fetchPlaces(
        session,
        apiKey,
        latitude,
        longitude,
        radius,
        typeParam,
        pageToken,
      );
    } catch (e, stackTrace) {
      session.log(
        'Error fetching nearby services',
        exception: e,
        stackTrace: stackTrace,
        level: LogLevel.error,
      );
      if (e.toString().contains('User must be logged in') ||
          e.toString().contains('Rate limit exceeded')) {
        rethrow;
      }
      throw Exception('Failed to fetch nearby services: $e');
    }
  }

  Future<NearbyPlacesResponse> _fetchPlaces(
    Session session,
    String apiKey,
    double latitude,
    double longitude,
    int radius,
    String type,
    String? pageToken,
  ) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'location': '$latitude,$longitude',
        'radius': radius.toString(),
        'type': type,
        'key': apiKey,
        if (pageToken != null) 'pagetoken': pageToken,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      session.log(
        'Google Places API error: ${response.statusCode}',
        level: LogLevel.error,
      );
      throw Exception('Failed to fetch places from Google API');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final status = data['status'] as String;

    if (status != 'OK' && status != 'ZERO_RESULTS') {
      session.log(
        'Google Places API status: $status - ${data['error_message'] ?? ''}',
        level: LogLevel.error,
      );
      throw Exception('Google Places API error: $status');
    }

    final results = (data['results'] as List?) ?? [];
    final places = results.map((place) {
      final location = place['geometry']['location'];
      final lat = (location['lat'] as num).toDouble();
      final lng = (location['lng'] as num).toDouble();

      // Calculate distance using Haversine formula
      final distance = _calculateDistance(latitude, longitude, lat, lng);

      // Get photo reference if available
      String? photoRef;
      if (place['photos'] != null && (place['photos'] as List).isNotEmpty) {
        photoRef = place['photos'][0]['photo_reference'] as String?;
      }

      return NearbyPlace(
        placeId: place['place_id'] as String,
        name: place['name'] as String,
        address: place['vicinity'] as String? ?? '',
        latitude: lat,
        longitude: lng,
        rating: (place['rating'] as num?)?.toDouble(),
        userRatingsTotal: place['user_ratings_total'] as int?,
        isOpen: place['opening_hours']?['open_now'] as bool?,
        photoReference: photoRef,
        types: (place['types'] as List?)?.cast<String>() ?? [],
        distance: distance,
      );
    }).toList();

    // Sort by distance
    places.sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));

    return NearbyPlacesResponse(
      places: places,
      nextPageToken: data['next_page_token'] as String?,
      status: status,
    );
  }

  /// Get photo URL for a place photo
  Future<String> getPlacePhotoUrl(
    Session session,
    String photoReference, {
    int maxWidth = 400,
  }) async {
    final apiKey = _readGooglePlacesApiKey(session);
    return 'https://maps.googleapis.com/maps/api/place/photo'
        '?maxwidth=$maxWidth'
        '&photo_reference=$photoReference'
        '&key=$apiKey';
  }

  String _readGooglePlacesApiKey(Session session) {
    final apiKey = session.passwords['googlePlacesApiKey'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Google Places API key not configured');
    }
    return apiKey;
  }

  /// Calculate distance between two points using Haversine formula
  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371000; // meters
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final a =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) *
            math.cos(_toRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  double _toRadians(double degrees) => degrees * math.pi / 180;
}
