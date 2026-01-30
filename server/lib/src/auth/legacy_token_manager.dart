import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as legacy;

// Import internal files to access defaultAuthKeySalt and hashString
import 'package:serverpod_auth_server/src/business/authentication_util.dart';

/// Token manager that handles legacy authentication keys from
/// serverpod_auth_server's UserAuthentication system.
///
/// This allows compatibility with auth keys created using
/// [legacy.UserAuthentication.signInUser] which generates keys
/// in the format "keyId:key".
class LegacyAuthTokenManager implements TokenManager {
  @override
  String get tokenIssuerName => 'legacy';

  @override
  Future<AuthenticationInfo?> validateToken(
    Session session,
    String token,
  ) async {
    try {
      // Parse the token (format: "keyId:key")
      final parts = token.split(':');
      if (parts.length != 2) {
        return null;
      }

      final keyIdStr = parts[0];
      final keyId = int.tryParse(keyIdStr);
      if (keyId == null) return null;

      final secret = parts[1];

      // Get the authentication key from the database
      // Use a temporary session to avoid logging
      final tempSession = await session.serverpod.createSession(
        enableLogging: false,
      );

      final authKey = await legacy.AuthKey.db.findById(tempSession, keyId);
      await tempSession.close();

      if (authKey == null) return null;

      // Hash the key from the user and check that it matches
      final signInSalt = session.passwords['authKeySalt'] ?? defaultAuthKeySalt;
      final expectedHash = hashString(signInSalt, secret);

      if (authKey.hash != expectedHash) return null;

      // Build scopes set
      final scopes = <Scope>{};
      for (final scopeName in authKey.scopeNames) {
        scopes.add(Scope(scopeName));
      }

      return AuthenticationInfo(
        authKey.userId.toString(),
        scopes,
        authId: keyIdStr,
      );
    } catch (exception, stackTrace) {
      stderr.writeln('Legacy authentication failed: $exception');
      stderr.writeln('$stackTrace');
      return null;
    }
  }

  @override
  Future<AuthSuccess> issueToken(
    Session session, {
    required UuidValue authUserId,
    required String method,
    Set<Scope>? scopes,
    Transaction? transaction,
  }) {
    // Legacy token manager doesn't issue new tokens
    // Use the legacy UserAuthentication.signInUser instead
    throw UnsupportedError(
      'LegacyAuthTokenManager does not issue new tokens. '
      'Use UserAuthentication.signInUser instead.',
    );
  }

  @override
  Future<List<TokenInfo>> listTokens(
    Session session, {
    required UuidValue? authUserId,
    String? method,
    String? tokenIssuer,
    Transaction? transaction,
  }) async {
    if (tokenIssuer != null && tokenIssuer != tokenIssuerName) {
      return [];
    }

    // Build the where expression
    final userId = authUserId != null
        ? int.tryParse(authUserId.toString())
        : null;

    final List<legacy.AuthKey> keys;
    if (userId != null && method != null) {
      keys = await legacy.AuthKey.db.find(
        session,
        where: (t) => t.userId.equals(userId) & t.method.equals(method),
      );
    } else if (userId != null) {
      keys = await legacy.AuthKey.db.find(
        session,
        where: (t) => t.userId.equals(userId),
      );
    } else if (method != null) {
      keys = await legacy.AuthKey.db.find(
        session,
        where: (t) => t.method.equals(method),
      );
    } else {
      // Match all
      keys = await legacy.AuthKey.db.find(session);
    }

    return keys
        .map(
          (key) => TokenInfo(
            userId: key.userId.toString(),
            tokenId: key.id.toString(),
            tokenIssuer: tokenIssuerName,
            scopes: key.scopeNames.map((s) => Scope(s)).toSet(),
            method: key.method,
          ),
        )
        .toList();
  }

  @override
  Future<void> revokeToken(
    Session session, {
    required String tokenId,
    Transaction? transaction,
    String? tokenIssuer,
  }) async {
    if (tokenIssuer != null && tokenIssuer != tokenIssuerName) {
      return;
    }

    final keyId = int.tryParse(tokenId);
    if (keyId == null) return;

    // Find and delete the auth key
    final authKey = await legacy.AuthKey.db.findById(session, keyId);
    if (authKey == null) return;

    await legacy.AuthKey.db.deleteRow(session, authKey);
  }

  @override
  Future<void> revokeAllTokens(
    Session session, {
    required UuidValue? authUserId,
    Transaction? transaction,
    String? method,
    String? tokenIssuer,
  }) async {
    if (tokenIssuer != null && tokenIssuer != tokenIssuerName) {
      return;
    }

    final userId = authUserId != null
        ? int.tryParse(authUserId.toString())
        : null;

    if (userId != null && method != null) {
      await legacy.AuthKey.db.deleteWhere(
        session,
        where: (t) => t.userId.equals(userId) & t.method.equals(method),
      );
    } else if (userId != null) {
      await legacy.AuthKey.db.deleteWhere(
        session,
        where: (t) => t.userId.equals(userId),
      );
    } else if (method != null) {
      await legacy.AuthKey.db.deleteWhere(
        session,
        where: (t) => t.method.equals(method),
      );
    } else {
      // Match all - delete all keys
      await legacy.AuthKey.db.deleteWhere(session, where: (t) => t.id > 0);
    }
  }
}

/// Builder for [LegacyAuthTokenManager].
class LegacyAuthTokenManagerBuilder
    implements TokenManagerBuilder<LegacyAuthTokenManager> {
  const LegacyAuthTokenManagerBuilder();

  @override
  LegacyAuthTokenManager build({required AuthUsers authUsers}) {
    return LegacyAuthTokenManager();
  }
}
