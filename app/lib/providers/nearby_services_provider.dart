import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oisely_client/oisely_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for managing nearby pet services (vets, pet stores)
class NearbyServicesProvider extends ChangeNotifier {
  final Client _client;
  static const String _cacheKey = 'nearby_services_cache';
  static const Duration _cacheDuration = Duration(minutes: 15);

  List<NearbyPlace> _places = [];
  bool _isLoading = false;
  String? _error;
  Position? _currentPosition;
  bool _locationPermissionDenied = false;
  String _selectedFilter = 'both'; // 'both', 'veterinary_care', 'pet_store'
  int _selectedRadius = 5000; // meters
  String? _nextPageToken;
  bool _hasMorePages = false;

  // Getters
  List<NearbyPlace> get places => _places;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Position? get currentPosition => _currentPosition;
  bool get locationPermissionDenied => _locationPermissionDenied;
  String get selectedFilter => _selectedFilter;
  int get selectedRadius => _selectedRadius;
  bool get hasMorePages => _hasMorePages;

  List<NearbyPlace> get filteredPlaces {
    if (_selectedFilter == 'both') return _places;
    return _places.where((place) {
      if (_selectedFilter == 'veterinary_care') {
        return place.types.contains('veterinary_care');
      } else {
        return place.types.contains('pet_store');
      }
    }).toList();
  }

  NearbyServicesProvider(this._client);

  /// Check and request location permissions
  Future<bool> checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _error =
          'Location services are disabled. Please enable them in settings.';
      _locationPermissionDenied = true;
      notifyListeners();
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _error = 'Location permission denied';
        _locationPermissionDenied = true;
        notifyListeners();
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _error = 'Location permissions are permanently denied';
      _locationPermissionDenied = true;
      notifyListeners();
      return false;
    }

    _locationPermissionDenied = false;
    return true;
  }

  /// Get current user location
  Future<Position?> getCurrentLocation() async {
    try {
      final hasPermission = await checkLocationPermission();
      if (!hasPermission) return null;

      _currentPosition = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );
      notifyListeners();
      return _currentPosition;
    } catch (e) {
      _error = 'Failed to get location: $e';
      notifyListeners();
      return null;
    }
  }

  /// Fetch nearby services from backend
  Future<void> fetchNearbyServices({bool refresh = false}) async {
    if (_isLoading) return;

    // Check cache first (unless refreshing)
    if (!refresh) {
      final cached = await _loadFromCache();
      if (cached != null) {
        _places = cached;
        _error = null;
        notifyListeners();
        return;
      }
    }

    _isLoading = true;
    _error = null;
    if (refresh) {
      _places = [];
      _nextPageToken = null;
    }
    notifyListeners();

    try {
      // Get location first
      final position = await getCurrentLocation();
      if (position == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await _client.nearbyServices.searchNearbyServices(
        position.latitude,
        position.longitude,
        radius: _selectedRadius,
        types: _selectedFilter,
        pageToken: _nextPageToken,
      );

      if (refresh || _nextPageToken == null) {
        _places = response.places;
      } else {
        _places.addAll(response.places);
      }

      _nextPageToken = response.nextPageToken;
      _hasMorePages = response.nextPageToken != null;
      _error = null;

      // Cache results
      await _saveToCache(_places);
    } catch (e) {
      _error =
          'Failed to load nearby services: ${e.toString().replaceAll('Exception:', '').trim()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load more results (pagination)
  Future<void> loadMore() async {
    if (!_hasMorePages || _isLoading) return;
    await fetchNearbyServices();
  }

  /// Set filter type
  void setFilter(String filter) {
    if (_selectedFilter != filter) {
      _selectedFilter = filter;
      _nextPageToken = null;
      notifyListeners();
      fetchNearbyServices(refresh: true);
    }
  }

  /// Set search radius
  void setRadius(int radius) {
    if (_selectedRadius != radius) {
      _selectedRadius = radius;
      _nextPageToken = null;
      notifyListeners();
      fetchNearbyServices(refresh: true);
    }
  }

  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Reset state
  void reset() {
    _places = [];
    _isLoading = false;
    _error = null;
    _nextPageToken = null;
    _hasMorePages = false;
    notifyListeners();
  }

  /// Get photo URL for a place
  Future<String?> getPhotoUrl(String? photoReference) async {
    if (photoReference == null) return null;
    try {
      return await _client.nearbyServices.getPlacePhotoUrl(
        photoReference,
        maxWidth: 400,
      );
    } catch (e) {
      return null;
    }
  }

  /// Format distance for display
  String formatDistance(double? meters) {
    if (meters == null) return '';
    if (meters < 1000) {
      return '${meters.round()}m';
    }
    return '${(meters / 1000).toStringAsFixed(1)}km';
  }

  // Cache management
  Future<List<NearbyPlace>?> _loadFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheData = prefs.getString(_cacheKey);
      if (cacheData == null) return null;

      final cache = jsonDecode(cacheData) as Map<String, dynamic>;
      final timestamp = DateTime.parse(cache['timestamp'] as String);

      // Check if cache is expired
      if (DateTime.now().difference(timestamp) > _cacheDuration) {
        return null;
      }

      // Check if filter and radius match
      if (cache['filter'] != _selectedFilter ||
          cache['radius'] != _selectedRadius) {
        return null;
      }

      final placesJson = cache['places'] as List;
      return placesJson
          .map((p) => NearbyPlace.fromJson(p as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return null;
    }
  }

  Future<void> _saveToCache(List<NearbyPlace> places) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cache = {
        'timestamp': DateTime.now().toIso8601String(),
        'filter': _selectedFilter,
        'radius': _selectedRadius,
        'places': places.map((p) => p.toJson()).toList(),
      };
      await prefs.setString(_cacheKey, jsonEncode(cache));
    } catch (e) {
      // Ignore cache errors
    }
  }

  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cacheKey);
    } catch (e) {
      // Ignore
    }
  }
}
