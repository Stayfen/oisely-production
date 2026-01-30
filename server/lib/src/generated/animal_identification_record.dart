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

abstract class AnimalIdentificationRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AnimalIdentificationRecord._({
    this.id,
    required this.userIdentifier,
    required this.species,
    this.breed,
    required this.confidence,
    required this.createdAt,
    required this.imageSha256,
    required this.modelName,
  });

  factory AnimalIdentificationRecord({
    int? id,
    required String userIdentifier,
    required String species,
    String? breed,
    required double confidence,
    required DateTime createdAt,
    required String imageSha256,
    required String modelName,
  }) = _AnimalIdentificationRecordImpl;

  factory AnimalIdentificationRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AnimalIdentificationRecord(
      id: jsonSerialization['id'] as int?,
      userIdentifier: jsonSerialization['userIdentifier'] as String,
      species: jsonSerialization['species'] as String,
      breed: jsonSerialization['breed'] as String?,
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      imageSha256: jsonSerialization['imageSha256'] as String,
      modelName: jsonSerialization['modelName'] as String,
    );
  }

  static final t = AnimalIdentificationRecordTable();

  static const db = AnimalIdentificationRecordRepository._();

  @override
  int? id;

  String userIdentifier;

  String species;

  String? breed;

  double confidence;

  DateTime createdAt;

  String imageSha256;

  String modelName;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AnimalIdentificationRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AnimalIdentificationRecord copyWith({
    int? id,
    String? userIdentifier,
    String? species,
    String? breed,
    double? confidence,
    DateTime? createdAt,
    String? imageSha256,
    String? modelName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnimalIdentificationRecord',
      if (id != null) 'id': id,
      'userIdentifier': userIdentifier,
      'species': species,
      if (breed != null) 'breed': breed,
      'confidence': confidence,
      'createdAt': createdAt.toJson(),
      'imageSha256': imageSha256,
      'modelName': modelName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnimalIdentificationRecord',
      if (id != null) 'id': id,
      'userIdentifier': userIdentifier,
      'species': species,
      if (breed != null) 'breed': breed,
      'confidence': confidence,
      'createdAt': createdAt.toJson(),
      'imageSha256': imageSha256,
      'modelName': modelName,
    };
  }

  static AnimalIdentificationRecordInclude include() {
    return AnimalIdentificationRecordInclude._();
  }

  static AnimalIdentificationRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<AnimalIdentificationRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AnimalIdentificationRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnimalIdentificationRecordTable>? orderByList,
    AnimalIdentificationRecordInclude? include,
  }) {
    return AnimalIdentificationRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AnimalIdentificationRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AnimalIdentificationRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnimalIdentificationRecordImpl extends AnimalIdentificationRecord {
  _AnimalIdentificationRecordImpl({
    int? id,
    required String userIdentifier,
    required String species,
    String? breed,
    required double confidence,
    required DateTime createdAt,
    required String imageSha256,
    required String modelName,
  }) : super._(
         id: id,
         userIdentifier: userIdentifier,
         species: species,
         breed: breed,
         confidence: confidence,
         createdAt: createdAt,
         imageSha256: imageSha256,
         modelName: modelName,
       );

  /// Returns a shallow copy of this [AnimalIdentificationRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AnimalIdentificationRecord copyWith({
    Object? id = _Undefined,
    String? userIdentifier,
    String? species,
    Object? breed = _Undefined,
    double? confidence,
    DateTime? createdAt,
    String? imageSha256,
    String? modelName,
  }) {
    return AnimalIdentificationRecord(
      id: id is int? ? id : this.id,
      userIdentifier: userIdentifier ?? this.userIdentifier,
      species: species ?? this.species,
      breed: breed is String? ? breed : this.breed,
      confidence: confidence ?? this.confidence,
      createdAt: createdAt ?? this.createdAt,
      imageSha256: imageSha256 ?? this.imageSha256,
      modelName: modelName ?? this.modelName,
    );
  }
}

class AnimalIdentificationRecordUpdateTable
    extends _i1.UpdateTable<AnimalIdentificationRecordTable> {
  AnimalIdentificationRecordUpdateTable(super.table);

  _i1.ColumnValue<String, String> userIdentifier(String value) =>
      _i1.ColumnValue(
        table.userIdentifier,
        value,
      );

  _i1.ColumnValue<String, String> species(String value) => _i1.ColumnValue(
    table.species,
    value,
  );

  _i1.ColumnValue<String, String> breed(String? value) => _i1.ColumnValue(
    table.breed,
    value,
  );

  _i1.ColumnValue<double, double> confidence(double value) => _i1.ColumnValue(
    table.confidence,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<String, String> imageSha256(String value) => _i1.ColumnValue(
    table.imageSha256,
    value,
  );

  _i1.ColumnValue<String, String> modelName(String value) => _i1.ColumnValue(
    table.modelName,
    value,
  );
}

class AnimalIdentificationRecordTable extends _i1.Table<int?> {
  AnimalIdentificationRecordTable({super.tableRelation})
    : super(tableName: 'animal_identification_record') {
    updateTable = AnimalIdentificationRecordUpdateTable(this);
    userIdentifier = _i1.ColumnString(
      'userIdentifier',
      this,
    );
    species = _i1.ColumnString(
      'species',
      this,
    );
    breed = _i1.ColumnString(
      'breed',
      this,
    );
    confidence = _i1.ColumnDouble(
      'confidence',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    imageSha256 = _i1.ColumnString(
      'imageSha256',
      this,
    );
    modelName = _i1.ColumnString(
      'modelName',
      this,
    );
  }

  late final AnimalIdentificationRecordUpdateTable updateTable;

  late final _i1.ColumnString userIdentifier;

  late final _i1.ColumnString species;

  late final _i1.ColumnString breed;

  late final _i1.ColumnDouble confidence;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString imageSha256;

  late final _i1.ColumnString modelName;

  @override
  List<_i1.Column> get columns => [
    id,
    userIdentifier,
    species,
    breed,
    confidence,
    createdAt,
    imageSha256,
    modelName,
  ];
}

class AnimalIdentificationRecordInclude extends _i1.IncludeObject {
  AnimalIdentificationRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AnimalIdentificationRecord.t;
}

class AnimalIdentificationRecordIncludeList extends _i1.IncludeList {
  AnimalIdentificationRecordIncludeList._({
    _i1.WhereExpressionBuilder<AnimalIdentificationRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AnimalIdentificationRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AnimalIdentificationRecord.t;
}

class AnimalIdentificationRecordRepository {
  const AnimalIdentificationRecordRepository._();

  /// Returns a list of [AnimalIdentificationRecord]s matching the given query parameters.
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
  Future<List<AnimalIdentificationRecord>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AnimalIdentificationRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AnimalIdentificationRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnimalIdentificationRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<AnimalIdentificationRecord>(
      where: where?.call(AnimalIdentificationRecord.t),
      orderBy: orderBy?.call(AnimalIdentificationRecord.t),
      orderByList: orderByList?.call(AnimalIdentificationRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [AnimalIdentificationRecord] matching the given query parameters.
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
  Future<AnimalIdentificationRecord?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AnimalIdentificationRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<AnimalIdentificationRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnimalIdentificationRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<AnimalIdentificationRecord>(
      where: where?.call(AnimalIdentificationRecord.t),
      orderBy: orderBy?.call(AnimalIdentificationRecord.t),
      orderByList: orderByList?.call(AnimalIdentificationRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [AnimalIdentificationRecord] by its [id] or null if no such row exists.
  Future<AnimalIdentificationRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<AnimalIdentificationRecord>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [AnimalIdentificationRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [AnimalIdentificationRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<AnimalIdentificationRecord>> insert(
    _i1.Session session,
    List<AnimalIdentificationRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<AnimalIdentificationRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [AnimalIdentificationRecord] and returns the inserted row.
  ///
  /// The returned [AnimalIdentificationRecord] will have its `id` field set.
  Future<AnimalIdentificationRecord> insertRow(
    _i1.Session session,
    AnimalIdentificationRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AnimalIdentificationRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AnimalIdentificationRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AnimalIdentificationRecord>> update(
    _i1.Session session,
    List<AnimalIdentificationRecord> rows, {
    _i1.ColumnSelections<AnimalIdentificationRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AnimalIdentificationRecord>(
      rows,
      columns: columns?.call(AnimalIdentificationRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AnimalIdentificationRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AnimalIdentificationRecord> updateRow(
    _i1.Session session,
    AnimalIdentificationRecord row, {
    _i1.ColumnSelections<AnimalIdentificationRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AnimalIdentificationRecord>(
      row,
      columns: columns?.call(AnimalIdentificationRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AnimalIdentificationRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AnimalIdentificationRecord?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<AnimalIdentificationRecordUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AnimalIdentificationRecord>(
      id,
      columnValues: columnValues(AnimalIdentificationRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AnimalIdentificationRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AnimalIdentificationRecord>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<AnimalIdentificationRecordUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<AnimalIdentificationRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AnimalIdentificationRecordTable>? orderBy,
    _i1.OrderByListBuilder<AnimalIdentificationRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AnimalIdentificationRecord>(
      columnValues: columnValues(AnimalIdentificationRecord.t.updateTable),
      where: where(AnimalIdentificationRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AnimalIdentificationRecord.t),
      orderByList: orderByList?.call(AnimalIdentificationRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AnimalIdentificationRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AnimalIdentificationRecord>> delete(
    _i1.Session session,
    List<AnimalIdentificationRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AnimalIdentificationRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AnimalIdentificationRecord].
  Future<AnimalIdentificationRecord> deleteRow(
    _i1.Session session,
    AnimalIdentificationRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AnimalIdentificationRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AnimalIdentificationRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AnimalIdentificationRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AnimalIdentificationRecord>(
      where: where(AnimalIdentificationRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AnimalIdentificationRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AnimalIdentificationRecord>(
      where: where?.call(AnimalIdentificationRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
