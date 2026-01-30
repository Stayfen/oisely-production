import 'package:serverpod/serverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as auth_core;
import '../generated/protocol.dart';

class MagicLinkEndpoint extends Endpoint {
  Future<bool> sendMagicLink(Session session, String email) async {
    email = email.trim().toLowerCase();

    // Rate limiting: Check if a token was requested in the last 30 seconds
    var existingToken = await MagicLinkToken.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
      orderBy: (t) => t.requestedAt,
      orderDescending: true,
    );

    if (existingToken != null &&
        DateTime.now().difference(existingToken.requestedAt).inSeconds < 30) {
      session.log('Rate limit exceeded for $email', level: LogLevel.info);
      return false;
    }

    // Invalidate old tokens for this email
    await MagicLinkToken.db.deleteWhere(
      session,
      where: (t) => t.email.equals(email),
    );

    // Generate 6-digit code
    var rng = Random();
    var code = (rng.nextInt(900000) + 100000).toString();

    var magicLinkToken = MagicLinkToken(
      token: code,
      email: email,
      requestedAt: DateTime.now(),
      expiration: DateTime.now().add(Duration(minutes: 10)),
    );
    await MagicLinkToken.db.insertRow(session, magicLinkToken);

    var resendApiKey = Serverpod.instance.getPassword('resendApiKey');

    if (resendApiKey == null) {
      session.log('Resend API Key not found', level: LogLevel.error);
      return false;
    }

    var url = Uri.parse('https://api.resend.com/emails');
    var headers = {
      'Authorization': 'Bearer $resendApiKey',
      'Content-Type': 'application/json',
    };

    var htmlContent =
        """
    <!DOCTYPE html>
    <html>
    <head>
      <style>
        body { font-family: sans-serif; background-color: #f4f4f4; padding: 20px; }
        .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .code { font-size: 32px; font-weight: bold; letter-spacing: 5px; color: #333; text-align: center; margin: 20px 0; padding: 10px; background: #f0f0f0; border-radius: 4px; }
        .footer { font-size: 12px; color: #888; text-align: center; margin-top: 30px; }
      </style>
    </head>
    <body>
      <div class="container">
        <h2 style="text-align: center; color: #333;">Sign in to Oisely</h2>
        <p>Hello,</p>
        <p>Use the following code to complete your sign-in process. This code is valid for 10 minutes.</p>
        <div class="code">$code</div>
        <p>If you didn't request this code, you can safely ignore this email.</p>
        <div class="footer">
          &copy; ${DateTime.now().year} Oisely. All rights reserved.
        </div>
      </div>
    </body>
    </html>
    """;

    var body = jsonEncode({
      "from": "noreply@oisely.space",
      "to": email,
      "subject": "Your Oisely Verification Code: $code",
      "html": htmlContent,
    });

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        session.log('Resend Error: ${response.body}', level: LogLevel.error);
        return false;
      }
    } catch (e) {
      session.log('Resend Exception: $e', level: LogLevel.error);
      return false;
    }
  }

  Future<AuthenticationResponse> verifyMagicLink(
    Session session,
    String email,
    String code,
  ) async {
    email = email.trim().toLowerCase();

    var magicToken = await MagicLinkToken.db.findFirstRow(
      session,
      where: (t) =>
          t.email.equals(email) &
          t.token.equals(code) &
          (t.expiration > DateTime.now()),
    );

    if (magicToken == null) {
      return AuthenticationResponse(success: false);
    }

    var emailAuth = await EmailAuth.db.findFirstRow(
      session,
      where: (t) => t.email.equals(magicToken.email),
    );

    int userId;

    if (emailAuth != null) {
      userId = emailAuth.userId;
    } else {
      var now = DateTime.now();
      var userInfo = UserInfo(
        userIdentifier: magicToken.email,
        email: magicToken.email,
        userName: magicToken.email.split('@')[0],
        created: now,
        scopeNames: [],
        blocked: false,
      );
      userInfo = await UserInfo.db.insertRow(session, userInfo);
      userId = userInfo.id!;

      emailAuth = EmailAuth(
        userId: userId,
        email: magicToken.email,
        hash: '',
      );
      await EmailAuth.db.insertRow(session, emailAuth);
    }

    // Generate authentication key for the user using legacy method
    var authKey = await UserAuthentication.signInUser(
      session,
      userId,
      'magic_link',
    );

    await MagicLinkToken.db.deleteRow(session, magicToken);

    var userInfo = await UserInfo.db.findById(session, userId);

    session.log(
      'Generated auth key for user $userId: id=${authKey.id}',
    );

    return AuthenticationResponse(
      success: true,
      keyId: authKey.id,
      key: authKey.key,
      userInfo: userInfo,
    );
  }
}
