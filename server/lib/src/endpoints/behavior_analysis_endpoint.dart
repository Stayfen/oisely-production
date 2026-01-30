import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class BehaviorAnalysisEndpoint extends Endpoint {
  static const _maxVideoSize = 5 * 1024 * 1024;
  static const _maxDurationSeconds = 18.0;
  static const _modelName = 'gemini-3-flash-preview';

  @override
  bool get requireLogin => true;

  Future<BehaviorAnalysisInsight> analyzeBehavior(
    Session session,
    String videoBase64,
  ) async {
    final authInfo = await session.authenticated;
    final userIdentifier = authInfo?.userIdentifier;
    if (userIdentifier == null) {
      throw Exception('User must be logged in');
    }
    final userIdentifierValue = userIdentifier.toString();
    final requestId = _newRequestId();

    try {
      await _checkRateLimit(session, userIdentifierValue);

      Uint8List videoBytes;
      try {
        videoBytes = base64Decode(videoBase64);
      } catch (e) {
        session.log('Invalid base64 video data', level: LogLevel.warning);
        throw Exception('Invalid video format');
      }

      if (videoBytes.isEmpty) {
        throw Exception('Video data is empty');
      }

      if (videoBytes.length > _maxVideoSize) {
        session.log(
          'Video too large: ${videoBytes.length} bytes',
          level: LogLevel.warning,
        );
        throw Exception('Video size exceeds the limit of 5MB');
      }

      if (!_isMp4(videoBytes)) {
        throw Exception('Unsupported video format');
      }

      final durationSeconds = _extractMp4DurationSeconds(videoBytes);
      if (durationSeconds == null || durationSeconds <= 0) {
        throw Exception('Unable to determine video duration');
      }
      if (durationSeconds > _maxDurationSeconds) {
        throw Exception('Video exceeds 18 seconds');
      }

      final videoHash = await _sha256Base64(videoBytes);

      final recentIdentifications = await AnimalIdentificationRecord.db.find(
        session,
        where: (t) => t.userIdentifier.equals(userIdentifierValue),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: 5,
      );

      final prompt = _buildPrompt(
        durationSeconds: durationSeconds,
        recentIdentifications: recentIdentifications,
        requestId: requestId,
      );

      final rawResponse = await _generateResponse(
        session: session,
        prompt: prompt,
        videoBytes: videoBytes,
        durationSeconds: durationSeconds,
        requestId: requestId,
      );
      final parsed = _parseJson(rawResponse);

      final insight = _buildInsight(
        parsed: parsed,
        durationSeconds: durationSeconds,
        requestId: requestId,
      );

      final encrypted = await _encryptResponse(session, rawResponse);

      final result = BehaviorAnalysisResult(
        userIdentifier: userIdentifierValue,
        createdAt: DateTime.now(),
        requestId: requestId,
        videoSha256: videoHash,
        videoDurationSeconds: durationSeconds,
        identifiedSpecies: insight.identifiedSpecies,
        identifiedBreed: insight.identifiedBreed,
        activityLevel: insight.activityLevel,
        emotionalState: insight.emotionalState,
        behaviorPatternsJson: jsonEncode(insight.behaviorPatterns),
        movementSummary: insight.movementSummary,
        postureSummary: insight.postureSummary,
        vocalizationSummary: insight.vocalizationSummary,
        movementPatternsJson: jsonEncode(insight.movementPatterns),
        vocalizationPatternsJson: jsonEncode(insight.vocalizationPatterns),
        keyFramesJson: jsonEncode(
          insight.keyFrames
              .map(
                (frame) => {
                  'timestampSeconds': frame.timestampSeconds,
                  'action': frame.action,
                  'bodyLanguage': frame.bodyLanguage,
                },
              )
              .toList(),
        ),
        analysisConfidence: insight.analysisConfidence,
        modelName: insight.modelName,
        modelResponseCiphertext: encrypted.ciphertext,
        modelResponseNonce: encrypted.nonce,
        modelResponseMac: encrypted.mac,
      );

      final stored = await BehaviorAnalysisResult.db.insertRow(session, result);

      session.log(
        'Behavior analysis completed requestId=$requestId userIdentifier=$userIdentifierValue videoHash=$videoHash durationSeconds=$durationSeconds analysisId=${stored.id}',
        level: LogLevel.info,
      );

      return insight.copyWith(analysisId: stored.id ?? 0);
    } catch (e, stackTrace) {
      session.log(
        'Behavior analysis failed requestId=$requestId userIdentifier=$userIdentifierValue',
        level: LogLevel.error,
        exception: e,
        stackTrace: stackTrace,
      );
      if (e.toString().contains('User must be logged in') ||
          e.toString().contains('Rate limit exceeded') ||
          e.toString().contains('Invalid video format') ||
          e.toString().contains('Video size exceeds') ||
          e.toString().contains('Unsupported video format') ||
          e.toString().contains('Video exceeds 18 seconds') ||
          e.toString().contains('Unable to determine video duration') ||
          e.toString().contains('Video data is empty')) {
        rethrow;
      }
      throw Exception('Internal server error during behavior analysis');
    }
  }

  Future<void> _checkRateLimit(Session session, String userIdentifier) async {
    final rateLimitKey = 'behavior_analysis_rate_limit_$userIdentifier';
    var rateLimitEntry =
        await session.caches.local.get(rateLimitKey) as RateLimitCounter?;
    var count = rateLimitEntry?.count ?? 0;
    if (count >= 3) {
      throw Exception('Rate limit exceeded. Please try again later.');
    }
    await session.caches.local.put(
      rateLimitKey,
      RateLimitCounter(count: count + 1),
      lifetime: Duration(minutes: 1),
    );
  }

  String _buildPrompt({
    required double durationSeconds,
    required List<AnimalIdentificationRecord?> recentIdentifications,
    required String requestId,
  }) {
    final recent = recentIdentifications
        .whereType<AnimalIdentificationRecord>()
        .map(
          (record) => {
            'species': record.species,
            'breed': record.breed,
            'confidence': record.confidence,
            'identifiedAt': record.createdAt.toIso8601String(),
          },
        )
        .toList();
    return '''
Analyze this ${durationSeconds.toStringAsFixed(2)} second video of a budgerigar and return JSON only.
Use the requestId "$requestId" when referencing this analysis.
Previously identified animals for this user: ${jsonEncode(recent)}.
Return a JSON object with:
- identifiedSpecies
- identifiedBreed
- activityLevel
- emotionalState
- behaviorPatterns (array of strings)
- movementSummary
- postureSummary
- vocalizationSummary
- movementPatterns (array of strings)
- vocalizationPatterns (array of strings)
- keyFrames (array of objects with timestampSeconds, action, bodyLanguage)
- analysisConfidence (0.0 to 1.0)
Ensure keyFrames include 3 to 8 entries across the video timeline.
''';
  }

  Map<String, dynamic> _parseJson(String raw) {
    try {
      final parsed = jsonDecode(raw);
      if (parsed is Map<String, dynamic>) {
        return parsed;
      }
      throw Exception('AI response was not a JSON object');
    } catch (_) {
      throw Exception('Failed to parse AI response');
    }
  }

  BehaviorAnalysisInsight _buildInsight({
    required Map<String, dynamic> parsed,
    required double durationSeconds,
    required String requestId,
  }) {
    final keyFrames = _parseKeyFrames(parsed['keyFrames']);
    return BehaviorAnalysisInsight(
      analysisId: 0,
      identifiedSpecies: _stringOrNull(parsed['identifiedSpecies']),
      identifiedBreed: _stringOrNull(parsed['identifiedBreed']),
      activityLevel: _stringOrUnknown(parsed['activityLevel']),
      emotionalState: _stringOrUnknown(parsed['emotionalState']),
      behaviorPatterns: _stringList(parsed['behaviorPatterns']),
      movementSummary: _stringOrUnknown(parsed['movementSummary']),
      postureSummary: _stringOrUnknown(parsed['postureSummary']),
      vocalizationSummary: _stringOrUnknown(parsed['vocalizationSummary']),
      movementPatterns: _stringList(parsed['movementPatterns']),
      vocalizationPatterns: _stringList(parsed['vocalizationPatterns']),
      keyFrames: keyFrames,
      analysisConfidence: _doubleValue(parsed['analysisConfidence']),
      videoDurationSeconds: durationSeconds,
      modelName: _modelName,
      requestId: requestId,
    );
  }

  List<BehaviorFrameInsight> _parseKeyFrames(dynamic value) {
    if (value is! List) {
      return [];
    }
    return value
        .map((entry) {
          if (entry is Map<String, dynamic>) {
            return BehaviorFrameInsight(
              timestampSeconds: _doubleValue(entry['timestampSeconds']),
              action: _stringOrUnknown(entry['action']),
              bodyLanguage: _stringOrNull(entry['bodyLanguage']),
            );
          }
          return null;
        })
        .whereType<BehaviorFrameInsight>()
        .toList();
  }

  List<String> _stringList(dynamic value) {
    if (value is! List) {
      return [];
    }
    return value.map((entry) => entry.toString()).toList();
  }

  String _stringOrUnknown(dynamic value) {
    if (value == null) {
      return 'Unknown';
    }
    final text = value.toString().trim();
    return text.isEmpty ? 'Unknown' : text;
  }

  String? _stringOrNull(dynamic value) {
    if (value == null) {
      return null;
    }
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }

  double _doubleValue(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }

  Future<String> _generateResponse({
    required Session session,
    required String prompt,
    required Uint8List videoBytes,
    required double durationSeconds,
    required String requestId,
  }) async {
    if (_shouldUseTestResponse(session)) {
      return _buildTestResponse(
        durationSeconds: durationSeconds,
        requestId: requestId,
      );
    }
    final model = GenerativeModel(
      model: _modelName,
      apiKey: _readGeminiApiKey(session),
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        temperature: 0.2,
      ),
    );

    final response = await model.generateContent([
      Content.multi([
        TextPart(prompt),
        DataPart('video/mp4', videoBytes),
      ]),
    ]);

    if (response.text == null) {
      session.log('Gemini returned empty response', level: LogLevel.error);
      throw Exception('Failed to analyze behavior');
    }

    return response.text!;
  }

  bool _shouldUseTestResponse(Session session) {
    return session.serverpod.runMode == ServerpodRunMode.test &&
        (session.passwords['geminiApiKey']?.isEmpty ?? true);
  }

  String _buildTestResponse({
    required double durationSeconds,
    required String requestId,
  }) {
    final keyFrames = [
      {
        'timestampSeconds': 1.0,
        'action': 'Perched',
        'bodyLanguage': 'Relaxed',
      },
      {
        'timestampSeconds': (durationSeconds / 2).clamp(0.1, durationSeconds),
        'action': 'Head tilt',
        'bodyLanguage': 'Alert',
      },
      {
        'timestampSeconds': (durationSeconds - 0.5).clamp(0.1, durationSeconds),
        'action': 'Preen',
        'bodyLanguage': 'Calm',
      },
    ];
    final payload = {
      'requestId': requestId,
      'identifiedSpecies': 'Budgerigar',
      'identifiedBreed': 'Unknown',
      'activityLevel': 'Moderate',
      'emotionalState': 'Calm',
      'behaviorPatterns': ['Perching', 'Head tilts', 'Preening'],
      'movementSummary': 'Moves between perches with short hops.',
      'postureSummary': 'Upright posture with relaxed wing positioning.',
      'vocalizationSummary': 'Occasional soft chirps.',
      'movementPatterns': ['Short hops', 'Wing stretch'],
      'vocalizationPatterns': ['Soft chirps'],
      'keyFrames': keyFrames,
      'analysisConfidence': 0.62,
    };
    return jsonEncode(payload);
  }

  String _readGeminiApiKey(Session session) {
    final apiKey = session.passwords['geminiApiKey'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Gemini API key not configured');
    }
    return apiKey;
  }

  Future<String> _sha256Base64(Uint8List bytes) async {
    final digest = await Sha256().hash(bytes);
    return base64Encode(digest.bytes);
  }

  bool _isMp4(Uint8List bytes) {
    if (bytes.length < 12) {
      return false;
    }
    final type = ascii.decode(bytes.sublist(4, 8));
    return type == 'ftyp';
  }

  double? _extractMp4DurationSeconds(Uint8List bytes) {
    int offset = 0;
    while (offset + 8 <= bytes.length) {
      final size = _readUint32(bytes, offset);
      final type = ascii.decode(bytes.sublist(offset + 4, offset + 8));
      int headerSize = 8;
      int boxSize = size;
      if (size == 1) {
        if (offset + 16 > bytes.length) {
          return null;
        }
        boxSize = _readUint64(bytes, offset + 8);
        headerSize = 16;
      } else if (size == 0) {
        boxSize = bytes.length - offset;
      }
      if (boxSize <= 0 || offset + boxSize > bytes.length) {
        return null;
      }
      if (type == 'moov') {
        return _extractMvhdDuration(
          bytes,
          offset + headerSize,
          boxSize - headerSize,
        );
      }
      offset += boxSize;
    }
    return null;
  }

  double? _extractMvhdDuration(Uint8List bytes, int start, int length) {
    int offset = start;
    final end = start + length;
    while (offset + 8 <= end) {
      final size = _readUint32(bytes, offset);
      final type = ascii.decode(bytes.sublist(offset + 4, offset + 8));
      int headerSize = 8;
      int boxSize = size;
      if (size == 1) {
        if (offset + 16 > end) {
          return null;
        }
        boxSize = _readUint64(bytes, offset + 8);
        headerSize = 16;
      } else if (size == 0) {
        boxSize = end - offset;
      }
      if (boxSize <= 0 || offset + boxSize > end) {
        return null;
      }
      if (type == 'mvhd') {
        final versionOffset = offset + headerSize;
        if (versionOffset + 4 > end) {
          return null;
        }
        final version = bytes[versionOffset];
        if (version == 0) {
          final timescaleOffset = offset + headerSize + 12;
          final durationOffset = offset + headerSize + 16;
          if (durationOffset + 4 > end) {
            return null;
          }
          final timescale = _readUint32(bytes, timescaleOffset);
          final duration = _readUint32(bytes, durationOffset);
          if (timescale == 0) {
            return null;
          }
          return duration / timescale;
        } else if (version == 1) {
          final timescaleOffset = offset + headerSize + 20;
          final durationOffset = offset + headerSize + 24;
          if (durationOffset + 8 > end) {
            return null;
          }
          final timescale = _readUint32(bytes, timescaleOffset);
          final duration = _readUint64(bytes, durationOffset);
          if (timescale == 0) {
            return null;
          }
          return duration / timescale;
        } else {
          return null;
        }
      }
      offset += boxSize;
    }
    return null;
  }

  int _readUint32(Uint8List bytes, int offset) {
    return (bytes[offset] << 24) |
        (bytes[offset + 1] << 16) |
        (bytes[offset + 2] << 8) |
        bytes[offset + 3];
  }

  int _readUint64(Uint8List bytes, int offset) {
    final high = _readUint32(bytes, offset);
    final low = _readUint32(bytes, offset + 4);
    return (high << 32) | low;
  }

  String _newRequestId() {
    final random = Random.secure();
    final bytes = List<int>.generate(12, (_) => random.nextInt(256));
    return base64UrlEncode(bytes);
  }

  Future<_EncryptedPayload> _encryptResponse(
    Session session,
    String plaintext,
  ) async {
    final keyBytes = base64Decode(_readBehaviorAnalysisEncryptionKey(session));
    if (keyBytes.length != 32) {
      throw Exception('Behavior analysis encryption key must be 32 bytes');
    }
    final algorithm = AesGcm.with256bits();
    final nonce = _randomBytes(12);
    final secretBox = await algorithm.encrypt(
      utf8.encode(plaintext),
      secretKey: SecretKey(keyBytes),
      nonce: nonce,
    );
    return _EncryptedPayload(
      ciphertext: base64Encode(secretBox.cipherText),
      nonce: base64Encode(secretBox.nonce),
      mac: base64Encode(secretBox.mac.bytes),
    );
  }

  List<int> _randomBytes(int length) {
    final random = Random.secure();
    return List<int>.generate(length, (_) => random.nextInt(256));
  }

  String _readBehaviorAnalysisEncryptionKey(Session session) {
    final keyBase64 = session.passwords['behaviorAnalysisEncryptionKey'];
    if (keyBase64 != null && keyBase64.isNotEmpty) {
      return keyBase64;
    }
    if (session.serverpod.runMode == ServerpodRunMode.test) {
      return base64Encode(List<int>.filled(32, 7));
    }
    throw Exception('Behavior analysis encryption key not configured');
  }
}

class _EncryptedPayload {
  _EncryptedPayload({
    required this.ciphertext,
    required this.nonce,
    required this.mac,
  });

  final String ciphertext;
  final String nonce;
  final String mac;
}
