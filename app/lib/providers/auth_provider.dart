import 'package:flutter/material.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

/// Provider for managing authentication state
class AuthProvider extends ChangeNotifier {
  final SessionManager _sessionManager;
  bool _isLoading = false;
  String? _errorMessage;

  AuthProvider(this._sessionManager) {
    _sessionManager.addListener(_onSessionChanged);
  }

  SessionManager get sessionManager => _sessionManager;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Returns the currently signed in user info, or null if not signed in
  UserInfo? get userInfo => _sessionManager.signedInUser;

  /// Returns true if a user is currently signed in
  bool get isAuthenticated => _sessionManager.signedInUser != null;

  /// Returns the user's profile image URL if available
  String? get userProfileImageUrl {
    final user = _sessionManager.signedInUser;
    if (user?.imageUrl != null && user!.imageUrl!.isNotEmpty) {
      return user.imageUrl;
    }
    return null;
  }

  /// Returns the user's display name
  String get userDisplayName {
    final user = _sessionManager.signedInUser;
    if (user?.fullName != null && user!.fullName!.isNotEmpty) {
      return user.fullName!;
    }
    if (user?.userName != null && user!.userName!.isNotEmpty) {
      return user.userName!;
    }
    return 'User';
  }

  /// Returns the user's email
  String? get userEmail => _sessionManager.signedInUser?.email;

  void _onSessionChanged() {
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> signOut() async {
    setLoading(true);
    try {
      await _sessionManager.signOutDevice();
      setError(null);
    } catch (e) {
      setError('Failed to sign out: $e');
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    _sessionManager.removeListener(_onSessionChanged);
    super.dispose();
  }
}
