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

abstract class MagicLinkToken
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = MagicLinkTokenTable();

  static const db = MagicLinkTokenRepository._();

  @override
  int? id;

  String token;

  String email;

  DateTime requestedAt;

  DateTime expiration;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MagicLinkToken',
      if (id != null) 'id': id,
      'token': token,
      'email': email,
      'requestedAt': requestedAt.toJson(),
      'expiration': expiration.toJson(),
    };
  }

  static MagicLinkTokenInclude include() {
    return MagicLinkTokenInclude._();
  }

  static MagicLinkTokenIncludeList includeList({
    _i1.WhereExpressionBuilder<MagicLinkTokenTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MagicLinkTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MagicLinkTokenTable>? orderByList,
    MagicLinkTokenInclude? include,
  }) {
    return MagicLinkTokenIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MagicLinkToken.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MagicLinkToken.t),
      include: include,
    );
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

class MagicLinkTokenUpdateTable extends _i1.UpdateTable<MagicLinkTokenTable> {
  MagicLinkTokenUpdateTable(super.table);

  _i1.ColumnValue<String, String> token(String value) => _i1.ColumnValue(
    table.token,
    value,
  );

  _i1.ColumnValue<String, String> email(String value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> requestedAt(DateTime value) =>
      _i1.ColumnValue(
        table.requestedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiration(DateTime value) =>
      _i1.ColumnValue(
        table.expiration,
        value,
      );
}

class MagicLinkTokenTable extends _i1.Table<int?> {
  MagicLinkTokenTable({super.tableRelation})
    : super(tableName: 'magic_link_token') {
    updateTable = MagicLinkTokenUpdateTable(this);
    token = _i1.ColumnString(
      'token',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    requestedAt = _i1.ColumnDateTime(
      'requestedAt',
      this,
    );
    expiration = _i1.ColumnDateTime(
      'expiration',
      this,
    );
  }

  late final MagicLinkTokenUpdateTable updateTable;

  late final _i1.ColumnString token;

  late final _i1.ColumnString email;

  late final _i1.ColumnDateTime requestedAt;

  late final _i1.ColumnDateTime expiration;

  @override
  List<_i1.Column> get columns => [
    id,
    token,
    email,
    requestedAt,
    expiration,
  ];
}

class MagicLinkTokenInclude extends _i1.IncludeObject {
  MagicLinkTokenInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => MagicLinkToken.t;
}

class MagicLinkTokenIncludeList extends _i1.IncludeList {
  MagicLinkTokenIncludeList._({
    _i1.WhereExpressionBuilder<MagicLinkTokenTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MagicLinkToken.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MagicLinkToken.t;
}

class MagicLinkTokenRepository {
  const MagicLinkTokenRepository._();

  /// Returns a list of [MagicLinkToken]s matching the given query parameters.
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
  Future<List<MagicLinkToken>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MagicLinkTokenTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MagicLinkTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MagicLinkTokenTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<MagicLinkToken>(
      where: where?.call(MagicLinkToken.t),
      orderBy: orderBy?.call(MagicLinkToken.t),
      orderByList: orderByList?.call(MagicLinkToken.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [MagicLinkToken] matching the given query parameters.
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
  Future<MagicLinkToken?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MagicLinkTokenTable>? where,
    int? offset,
    _i1.OrderByBuilder<MagicLinkTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MagicLinkTokenTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<MagicLinkToken>(
      where: where?.call(MagicLinkToken.t),
      orderBy: orderBy?.call(MagicLinkToken.t),
      orderByList: orderByList?.call(MagicLinkToken.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [MagicLinkToken] by its [id] or null if no such row exists.
  Future<MagicLinkToken?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<MagicLinkToken>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [MagicLinkToken]s in the list and returns the inserted rows.
  ///
  /// The returned [MagicLinkToken]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<MagicLinkToken>> insert(
    _i1.Session session,
    List<MagicLinkToken> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MagicLinkToken>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [MagicLinkToken] and returns the inserted row.
  ///
  /// The returned [MagicLinkToken] will have its `id` field set.
  Future<MagicLinkToken> insertRow(
    _i1.Session session,
    MagicLinkToken row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MagicLinkToken>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MagicLinkToken]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MagicLinkToken>> update(
    _i1.Session session,
    List<MagicLinkToken> rows, {
    _i1.ColumnSelections<MagicLinkTokenTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MagicLinkToken>(
      rows,
      columns: columns?.call(MagicLinkToken.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MagicLinkToken]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MagicLinkToken> updateRow(
    _i1.Session session,
    MagicLinkToken row, {
    _i1.ColumnSelections<MagicLinkTokenTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MagicLinkToken>(
      row,
      columns: columns?.call(MagicLinkToken.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MagicLinkToken] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MagicLinkToken?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<MagicLinkTokenUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MagicLinkToken>(
      id,
      columnValues: columnValues(MagicLinkToken.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MagicLinkToken]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MagicLinkToken>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<MagicLinkTokenUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MagicLinkTokenTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MagicLinkTokenTable>? orderBy,
    _i1.OrderByListBuilder<MagicLinkTokenTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MagicLinkToken>(
      columnValues: columnValues(MagicLinkToken.t.updateTable),
      where: where(MagicLinkToken.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MagicLinkToken.t),
      orderByList: orderByList?.call(MagicLinkToken.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MagicLinkToken]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MagicLinkToken>> delete(
    _i1.Session session,
    List<MagicLinkToken> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MagicLinkToken>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MagicLinkToken].
  Future<MagicLinkToken> deleteRow(
    _i1.Session session,
    MagicLinkToken row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MagicLinkToken>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MagicLinkToken>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MagicLinkTokenTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MagicLinkToken>(
      where: where(MagicLinkToken.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MagicLinkTokenTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MagicLinkToken>(
      where: where?.call(MagicLinkToken.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
