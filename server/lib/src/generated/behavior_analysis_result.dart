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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class BehaviorAnalysisResult
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  BehaviorAnalysisResult._({
    this.id,
    required this.userIdentifier,
    required this.createdAt,
    required this.requestId,
    required this.videoSha256,
    required this.videoDurationSeconds,
    this.identifiedSpecies,
    this.identifiedBreed,
    required this.activityLevel,
    required this.emotionalState,
    required this.behaviorPatternsJson,
    required this.movementSummary,
    required this.postureSummary,
    required this.vocalizationSummary,
    required this.movementPatternsJson,
    required this.vocalizationPatternsJson,
    required this.keyFramesJson,
    required this.analysisConfidence,
    required this.modelName,
    required this.modelResponseCiphertext,
    required this.modelResponseNonce,
    required this.modelResponseMac,
  });

  factory BehaviorAnalysisResult({
    int? id,
    required String userIdentifier,
    required DateTime createdAt,
    required String requestId,
    required String videoSha256,
    required double videoDurationSeconds,
    String? identifiedSpecies,
    String? identifiedBreed,
    required String activityLevel,
    required String emotionalState,
    required String behaviorPatternsJson,
    required String movementSummary,
    required String postureSummary,
    required String vocalizationSummary,
    required String movementPatternsJson,
    required String vocalizationPatternsJson,
    required String keyFramesJson,
    required double analysisConfidence,
    required String modelName,
    required String modelResponseCiphertext,
    required String modelResponseNonce,
    required String modelResponseMac,
  }) = _BehaviorAnalysisResultImpl;

  factory BehaviorAnalysisResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return BehaviorAnalysisResult(
      id: jsonSerialization['id'] as int?,
      userIdentifier: jsonSerialization['userIdentifier'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      requestId: jsonSerialization['requestId'] as String,
      videoSha256: jsonSerialization['videoSha256'] as String,
      videoDurationSeconds: (jsonSerialization['videoDurationSeconds'] as num)
          .toDouble(),
      identifiedSpecies: jsonSerialization['identifiedSpecies'] as String?,
      identifiedBreed: jsonSerialization['identifiedBreed'] as String?,
      activityLevel: jsonSerialization['activityLevel'] as String,
      emotionalState: jsonSerialization['emotionalState'] as String,
      behaviorPatternsJson: jsonSerialization['behaviorPatternsJson'] as String,
      movementSummary: jsonSerialization['movementSummary'] as String,
      postureSummary: jsonSerialization['postureSummary'] as String,
      vocalizationSummary: jsonSerialization['vocalizationSummary'] as String,
      movementPatternsJson: jsonSerialization['movementPatternsJson'] as String,
      vocalizationPatternsJson:
          jsonSerialization['vocalizationPatternsJson'] as String,
      keyFramesJson: jsonSerialization['keyFramesJson'] as String,
      analysisConfidence: (jsonSerialization['analysisConfidence'] as num)
          .toDouble(),
      modelName: jsonSerialization['modelName'] as String,
      modelResponseCiphertext:
          jsonSerialization['modelResponseCiphertext'] as String,
      modelResponseNonce: jsonSerialization['modelResponseNonce'] as String,
      modelResponseMac: jsonSerialization['modelResponseMac'] as String,
    );
  }

  static final t = BehaviorAnalysisResultTable();

  static const db = BehaviorAnalysisResultRepository._();

  @override
  int? id;

  String userIdentifier;

  DateTime createdAt;

  String requestId;

  String videoSha256;

  double videoDurationSeconds;

  String? identifiedSpecies;

  String? identifiedBreed;

  String activityLevel;

  String emotionalState;

  String behaviorPatternsJson;

  String movementSummary;

  String postureSummary;

  String vocalizationSummary;

  String movementPatternsJson;

  String vocalizationPatternsJson;

  String keyFramesJson;

  double analysisConfidence;

  String modelName;

  String modelResponseCiphertext;

  String modelResponseNonce;

  String modelResponseMac;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [BehaviorAnalysisResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BehaviorAnalysisResult copyWith({
    int? id,
    String? userIdentifier,
    DateTime? createdAt,
    String? requestId,
    String? videoSha256,
    double? videoDurationSeconds,
    String? identifiedSpecies,
    String? identifiedBreed,
    String? activityLevel,
    String? emotionalState,
    String? behaviorPatternsJson,
    String? movementSummary,
    String? postureSummary,
    String? vocalizationSummary,
    String? movementPatternsJson,
    String? vocalizationPatternsJson,
    String? keyFramesJson,
    double? analysisConfidence,
    String? modelName,
    String? modelResponseCiphertext,
    String? modelResponseNonce,
    String? modelResponseMac,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BehaviorAnalysisResult',
      if (id != null) 'id': id,
      'userIdentifier': userIdentifier,
      'createdAt': createdAt.toJson(),
      'requestId': requestId,
      'videoSha256': videoSha256,
      'videoDurationSeconds': videoDurationSeconds,
      if (identifiedSpecies != null) 'identifiedSpecies': identifiedSpecies,
      if (identifiedBreed != null) 'identifiedBreed': identifiedBreed,
      'activityLevel': activityLevel,
      'emotionalState': emotionalState,
      'behaviorPatternsJson': behaviorPatternsJson,
      'movementSummary': movementSummary,
      'postureSummary': postureSummary,
      'vocalizationSummary': vocalizationSummary,
      'movementPatternsJson': movementPatternsJson,
      'vocalizationPatternsJson': vocalizationPatternsJson,
      'keyFramesJson': keyFramesJson,
      'analysisConfidence': analysisConfidence,
      'modelName': modelName,
      'modelResponseCiphertext': modelResponseCiphertext,
      'modelResponseNonce': modelResponseNonce,
      'modelResponseMac': modelResponseMac,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BehaviorAnalysisResult',
      if (id != null) 'id': id,
      'userIdentifier': userIdentifier,
      'createdAt': createdAt.toJson(),
      'requestId': requestId,
      'videoSha256': videoSha256,
      'videoDurationSeconds': videoDurationSeconds,
      if (identifiedSpecies != null) 'identifiedSpecies': identifiedSpecies,
      if (identifiedBreed != null) 'identifiedBreed': identifiedBreed,
      'activityLevel': activityLevel,
      'emotionalState': emotionalState,
      'behaviorPatternsJson': behaviorPatternsJson,
      'movementSummary': movementSummary,
      'postureSummary': postureSummary,
      'vocalizationSummary': vocalizationSummary,
      'movementPatternsJson': movementPatternsJson,
      'vocalizationPatternsJson': vocalizationPatternsJson,
      'keyFramesJson': keyFramesJson,
      'analysisConfidence': analysisConfidence,
      'modelName': modelName,
      'modelResponseCiphertext': modelResponseCiphertext,
      'modelResponseNonce': modelResponseNonce,
      'modelResponseMac': modelResponseMac,
    };
  }

  static BehaviorAnalysisResultInclude include() {
    return BehaviorAnalysisResultInclude._();
  }

  static BehaviorAnalysisResultIncludeList includeList({
    _i1.WhereExpressionBuilder<BehaviorAnalysisResultTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BehaviorAnalysisResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BehaviorAnalysisResultTable>? orderByList,
    BehaviorAnalysisResultInclude? include,
  }) {
    return BehaviorAnalysisResultIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BehaviorAnalysisResult.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BehaviorAnalysisResult.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BehaviorAnalysisResultImpl extends BehaviorAnalysisResult {
  _BehaviorAnalysisResultImpl({
    int? id,
    required String userIdentifier,
    required DateTime createdAt,
    required String requestId,
    required String videoSha256,
    required double videoDurationSeconds,
    String? identifiedSpecies,
    String? identifiedBreed,
    required String activityLevel,
    required String emotionalState,
    required String behaviorPatternsJson,
    required String movementSummary,
    required String postureSummary,
    required String vocalizationSummary,
    required String movementPatternsJson,
    required String vocalizationPatternsJson,
    required String keyFramesJson,
    required double analysisConfidence,
    required String modelName,
    required String modelResponseCiphertext,
    required String modelResponseNonce,
    required String modelResponseMac,
  }) : super._(
         id: id,
         userIdentifier: userIdentifier,
         createdAt: createdAt,
         requestId: requestId,
         videoSha256: videoSha256,
         videoDurationSeconds: videoDurationSeconds,
         identifiedSpecies: identifiedSpecies,
         identifiedBreed: identifiedBreed,
         activityLevel: activityLevel,
         emotionalState: emotionalState,
         behaviorPatternsJson: behaviorPatternsJson,
         movementSummary: movementSummary,
         postureSummary: postureSummary,
         vocalizationSummary: vocalizationSummary,
         movementPatternsJson: movementPatternsJson,
         vocalizationPatternsJson: vocalizationPatternsJson,
         keyFramesJson: keyFramesJson,
         analysisConfidence: analysisConfidence,
         modelName: modelName,
         modelResponseCiphertext: modelResponseCiphertext,
         modelResponseNonce: modelResponseNonce,
         modelResponseMac: modelResponseMac,
       );

  /// Returns a shallow copy of this [BehaviorAnalysisResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BehaviorAnalysisResult copyWith({
    Object? id = _Undefined,
    String? userIdentifier,
    DateTime? createdAt,
    String? requestId,
    String? videoSha256,
    double? videoDurationSeconds,
    Object? identifiedSpecies = _Undefined,
    Object? identifiedBreed = _Undefined,
    String? activityLevel,
    String? emotionalState,
    String? behaviorPatternsJson,
    String? movementSummary,
    String? postureSummary,
    String? vocalizationSummary,
    String? movementPatternsJson,
    String? vocalizationPatternsJson,
    String? keyFramesJson,
    double? analysisConfidence,
    String? modelName,
    String? modelResponseCiphertext,
    String? modelResponseNonce,
    String? modelResponseMac,
  }) {
    return BehaviorAnalysisResult(
      id: id is int? ? id : this.id,
      userIdentifier: userIdentifier ?? this.userIdentifier,
      createdAt: createdAt ?? this.createdAt,
      requestId: requestId ?? this.requestId,
      videoSha256: videoSha256 ?? this.videoSha256,
      videoDurationSeconds: videoDurationSeconds ?? this.videoDurationSeconds,
      identifiedSpecies: identifiedSpecies is String?
          ? identifiedSpecies
          : this.identifiedSpecies,
      identifiedBreed: identifiedBreed is String?
          ? identifiedBreed
          : this.identifiedBreed,
      activityLevel: activityLevel ?? this.activityLevel,
      emotionalState: emotionalState ?? this.emotionalState,
      behaviorPatternsJson: behaviorPatternsJson ?? this.behaviorPatternsJson,
      movementSummary: movementSummary ?? this.movementSummary,
      postureSummary: postureSummary ?? this.postureSummary,
      vocalizationSummary: vocalizationSummary ?? this.vocalizationSummary,
      movementPatternsJson: movementPatternsJson ?? this.movementPatternsJson,
      vocalizationPatternsJson:
          vocalizationPatternsJson ?? this.vocalizationPatternsJson,
      keyFramesJson: keyFramesJson ?? this.keyFramesJson,
      analysisConfidence: analysisConfidence ?? this.analysisConfidence,
      modelName: modelName ?? this.modelName,
      modelResponseCiphertext:
          modelResponseCiphertext ?? this.modelResponseCiphertext,
      modelResponseNonce: modelResponseNonce ?? this.modelResponseNonce,
      modelResponseMac: modelResponseMac ?? this.modelResponseMac,
    );
  }
}

class BehaviorAnalysisResultUpdateTable
    extends _i1.UpdateTable<BehaviorAnalysisResultTable> {
  BehaviorAnalysisResultUpdateTable(super.table);

  _i1.ColumnValue<String, String> userIdentifier(String value) =>
      _i1.ColumnValue(
        table.userIdentifier,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<String, String> requestId(String value) => _i1.ColumnValue(
    table.requestId,
    value,
  );

  _i1.ColumnValue<String, String> videoSha256(String value) => _i1.ColumnValue(
    table.videoSha256,
    value,
  );

  _i1.ColumnValue<double, double> videoDurationSeconds(double value) =>
      _i1.ColumnValue(
        table.videoDurationSeconds,
        value,
      );

  _i1.ColumnValue<String, String> identifiedSpecies(String? value) =>
      _i1.ColumnValue(
        table.identifiedSpecies,
        value,
      );

  _i1.ColumnValue<String, String> identifiedBreed(String? value) =>
      _i1.ColumnValue(
        table.identifiedBreed,
        value,
      );

  _i1.ColumnValue<String, String> activityLevel(String value) =>
      _i1.ColumnValue(
        table.activityLevel,
        value,
      );

  _i1.ColumnValue<String, String> emotionalState(String value) =>
      _i1.ColumnValue(
        table.emotionalState,
        value,
      );

  _i1.ColumnValue<String, String> behaviorPatternsJson(String value) =>
      _i1.ColumnValue(
        table.behaviorPatternsJson,
        value,
      );

  _i1.ColumnValue<String, String> movementSummary(String value) =>
      _i1.ColumnValue(
        table.movementSummary,
        value,
      );

  _i1.ColumnValue<String, String> postureSummary(String value) =>
      _i1.ColumnValue(
        table.postureSummary,
        value,
      );

  _i1.ColumnValue<String, String> vocalizationSummary(String value) =>
      _i1.ColumnValue(
        table.vocalizationSummary,
        value,
      );

  _i1.ColumnValue<String, String> movementPatternsJson(String value) =>
      _i1.ColumnValue(
        table.movementPatternsJson,
        value,
      );

  _i1.ColumnValue<String, String> vocalizationPatternsJson(String value) =>
      _i1.ColumnValue(
        table.vocalizationPatternsJson,
        value,
      );

  _i1.ColumnValue<String, String> keyFramesJson(String value) =>
      _i1.ColumnValue(
        table.keyFramesJson,
        value,
      );

  _i1.ColumnValue<double, double> analysisConfidence(double value) =>
      _i1.ColumnValue(
        table.analysisConfidence,
        value,
      );

  _i1.ColumnValue<String, String> modelName(String value) => _i1.ColumnValue(
    table.modelName,
    value,
  );

  _i1.ColumnValue<String, String> modelResponseCiphertext(String value) =>
      _i1.ColumnValue(
        table.modelResponseCiphertext,
        value,
      );

  _i1.ColumnValue<String, String> modelResponseNonce(String value) =>
      _i1.ColumnValue(
        table.modelResponseNonce,
        value,
      );

  _i1.ColumnValue<String, String> modelResponseMac(String value) =>
      _i1.ColumnValue(
        table.modelResponseMac,
        value,
      );
}

class BehaviorAnalysisResultTable extends _i1.Table<int?> {
  BehaviorAnalysisResultTable({super.tableRelation})
    : super(tableName: 'behavior_analysis_result') {
    updateTable = BehaviorAnalysisResultUpdateTable(this);
    userIdentifier = _i1.ColumnString(
      'userIdentifier',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    requestId = _i1.ColumnString(
      'requestId',
      this,
    );
    videoSha256 = _i1.ColumnString(
      'videoSha256',
      this,
    );
    videoDurationSeconds = _i1.ColumnDouble(
      'videoDurationSeconds',
      this,
    );
    identifiedSpecies = _i1.ColumnString(
      'identifiedSpecies',
      this,
    );
    identifiedBreed = _i1.ColumnString(
      'identifiedBreed',
      this,
    );
    activityLevel = _i1.ColumnString(
      'activityLevel',
      this,
    );
    emotionalState = _i1.ColumnString(
      'emotionalState',
      this,
    );
    behaviorPatternsJson = _i1.ColumnString(
      'behaviorPatternsJson',
      this,
    );
    movementSummary = _i1.ColumnString(
      'movementSummary',
      this,
    );
    postureSummary = _i1.ColumnString(
      'postureSummary',
      this,
    );
    vocalizationSummary = _i1.ColumnString(
      'vocalizationSummary',
      this,
    );
    movementPatternsJson = _i1.ColumnString(
      'movementPatternsJson',
      this,
    );
    vocalizationPatternsJson = _i1.ColumnString(
      'vocalizationPatternsJson',
      this,
    );
    keyFramesJson = _i1.ColumnString(
      'keyFramesJson',
      this,
    );
    analysisConfidence = _i1.ColumnDouble(
      'analysisConfidence',
      this,
    );
    modelName = _i1.ColumnString(
      'modelName',
      this,
    );
    modelResponseCiphertext = _i1.ColumnString(
      'modelResponseCiphertext',
      this,
    );
    modelResponseNonce = _i1.ColumnString(
      'modelResponseNonce',
      this,
    );
    modelResponseMac = _i1.ColumnString(
      'modelResponseMac',
      this,
    );
  }

  late final BehaviorAnalysisResultUpdateTable updateTable;

  late final _i1.ColumnString userIdentifier;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString requestId;

  late final _i1.ColumnString videoSha256;

  late final _i1.ColumnDouble videoDurationSeconds;

  late final _i1.ColumnString identifiedSpecies;

  late final _i1.ColumnString identifiedBreed;

  late final _i1.ColumnString activityLevel;

  late final _i1.ColumnString emotionalState;

  late final _i1.ColumnString behaviorPatternsJson;

  late final _i1.ColumnString movementSummary;

  late final _i1.ColumnString postureSummary;

  late final _i1.ColumnString vocalizationSummary;

  late final _i1.ColumnString movementPatternsJson;

  late final _i1.ColumnString vocalizationPatternsJson;

  late final _i1.ColumnString keyFramesJson;

  late final _i1.ColumnDouble analysisConfidence;

  late final _i1.ColumnString modelName;

  late final _i1.ColumnString modelResponseCiphertext;

  late final _i1.ColumnString modelResponseNonce;

  late final _i1.ColumnString modelResponseMac;

  @override
  List<_i1.Column> get columns => [
    id,
    userIdentifier,
    createdAt,
    requestId,
    videoSha256,
    videoDurationSeconds,
    identifiedSpecies,
    identifiedBreed,
    activityLevel,
    emotionalState,
    behaviorPatternsJson,
    movementSummary,
    postureSummary,
    vocalizationSummary,
    movementPatternsJson,
    vocalizationPatternsJson,
    keyFramesJson,
    analysisConfidence,
    modelName,
    modelResponseCiphertext,
    modelResponseNonce,
    modelResponseMac,
  ];
}

class BehaviorAnalysisResultInclude extends _i1.IncludeObject {
  BehaviorAnalysisResultInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => BehaviorAnalysisResult.t;
}

class BehaviorAnalysisResultIncludeList extends _i1.IncludeList {
  BehaviorAnalysisResultIncludeList._({
    _i1.WhereExpressionBuilder<BehaviorAnalysisResultTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BehaviorAnalysisResult.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => BehaviorAnalysisResult.t;
}

class BehaviorAnalysisResultRepository {
  const BehaviorAnalysisResultRepository._();

  /// Returns a list of [BehaviorAnalysisResult]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<BehaviorAnalysisResult>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BehaviorAnalysisResultTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BehaviorAnalysisResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BehaviorAnalysisResultTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<BehaviorAnalysisResult>(
      where: where?.call(BehaviorAnalysisResult.t),
      orderBy: orderBy?.call(BehaviorAnalysisResult.t),
      orderByList: orderByList?.call(BehaviorAnalysisResult.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [BehaviorAnalysisResult] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<BehaviorAnalysisResult?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BehaviorAnalysisResultTable>? where,
    int? offset,
    _i1.OrderByBuilder<BehaviorAnalysisResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BehaviorAnalysisResultTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<BehaviorAnalysisResult>(
      where: where?.call(BehaviorAnalysisResult.t),
      orderBy: orderBy?.call(BehaviorAnalysisResult.t),
      orderByList: orderByList?.call(BehaviorAnalysisResult.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [BehaviorAnalysisResult] by its [id] or null if no such row exists.
  Future<BehaviorAnalysisResult?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<BehaviorAnalysisResult>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [BehaviorAnalysisResult]s in the list and returns the inserted rows.
  ///
  /// The returned [BehaviorAnalysisResult]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<BehaviorAnalysisResult>> insert(
    _i1.Session session,
    List<BehaviorAnalysisResult> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<BehaviorAnalysisResult>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [BehaviorAnalysisResult] and returns the inserted row.
  ///
  /// The returned [BehaviorAnalysisResult] will have its `id` field set.
  Future<BehaviorAnalysisResult> insertRow(
    _i1.Session session,
    BehaviorAnalysisResult row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BehaviorAnalysisResult>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BehaviorAnalysisResult]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BehaviorAnalysisResult>> update(
    _i1.Session session,
    List<BehaviorAnalysisResult> rows, {
    _i1.ColumnSelections<BehaviorAnalysisResultTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BehaviorAnalysisResult>(
      rows,
      columns: columns?.call(BehaviorAnalysisResult.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BehaviorAnalysisResult]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BehaviorAnalysisResult> updateRow(
    _i1.Session session,
    BehaviorAnalysisResult row, {
    _i1.ColumnSelections<BehaviorAnalysisResultTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BehaviorAnalysisResult>(
      row,
      columns: columns?.call(BehaviorAnalysisResult.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BehaviorAnalysisResult] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BehaviorAnalysisResult?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<BehaviorAnalysisResultUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BehaviorAnalysisResult>(
      id,
      columnValues: columnValues(BehaviorAnalysisResult.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BehaviorAnalysisResult]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<BehaviorAnalysisResult>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<BehaviorAnalysisResultUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<BehaviorAnalysisResultTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BehaviorAnalysisResultTable>? orderBy,
    _i1.OrderByListBuilder<BehaviorAnalysisResultTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<BehaviorAnalysisResult>(
      columnValues: columnValues(BehaviorAnalysisResult.t.updateTable),
      where: where(BehaviorAnalysisResult.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BehaviorAnalysisResult.t),
      orderByList: orderByList?.call(BehaviorAnalysisResult.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [BehaviorAnalysisResult]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BehaviorAnalysisResult>> delete(
    _i1.Session session,
    List<BehaviorAnalysisResult> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BehaviorAnalysisResult>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BehaviorAnalysisResult].
  Future<BehaviorAnalysisResult> deleteRow(
    _i1.Session session,
    BehaviorAnalysisResult row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BehaviorAnalysisResult>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BehaviorAnalysisResult>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BehaviorAnalysisResultTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BehaviorAnalysisResult>(
      where: where(BehaviorAnalysisResult.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BehaviorAnalysisResultTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BehaviorAnalysisResult>(
      where: where?.call(BehaviorAnalysisResult.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
