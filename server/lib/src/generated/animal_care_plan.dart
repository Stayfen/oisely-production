/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'care_plan_task.dart' as _i2;
import 'package:oisely_server/src/generated/protocol.dart' as _i3;

abstract class AnimalCarePlan
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AnimalCarePlan._({
    this.id,
    required this.animalIdentificationRecordId,
    required this.userIdentifier,
    required this.version,
    required this.generatedAt,
    required this.modelName,
    required this.generationConfidence,
    this.summary,
    required this.totalDailyTimeMinutes,
    required this.totalWeeklyTimeMinutes,
    required this.status,
    this.tasks,
  });

  factory AnimalCarePlan({
    int? id,
    required int animalIdentificationRecordId,
    required String userIdentifier,
    required int version,
    required DateTime generatedAt,
    required String modelName,
    required double generationConfidence,
    String? summary,
    required int totalDailyTimeMinutes,
    required int totalWeeklyTimeMinutes,
    required String status,
    List<_i2.CarePlanTask>? tasks,
  }) = _AnimalCarePlanImpl;

  factory AnimalCarePlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnimalCarePlan(
      id: jsonSerialization['id'] as int?,
      animalIdentificationRecordId:
          jsonSerialization['animalIdentificationRecordId'] as int,
      userIdentifier: jsonSerialization['userIdentifier'] as String,
      version: jsonSerialization['version'] as int,
      generatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
      modelName: jsonSerialization['modelName'] as String,
      generationConfidence: (jsonSerialization['generationConfidence'] as num)
          .toDouble(),
      summary: jsonSerialization['summary'] as String?,
      totalDailyTimeMinutes: jsonSerialization['totalDailyTimeMinutes'] as int,
      totalWeeklyTimeMinutes:
          jsonSerialization['totalWeeklyTimeMinutes'] as int,
      status: jsonSerialization['status'] as String,
      tasks: jsonSerialization['tasks'] == null
          ? null
          : _i3.Protocol().deserialize<List<_i2.CarePlanTask>>(
              jsonSerialization['tasks'],
            ),
    );
  }

  static final t = AnimalCarePlanTable();

  static const db = AnimalCarePlanRepository._();

  @override
  int? id;

  int animalIdentificationRecordId;

  String userIdentifier;

  int version;

  DateTime generatedAt;

  String modelName;

  double generationConfidence;

  String? summary;

  int totalDailyTimeMinutes;

  int totalWeeklyTimeMinutes;

  String status;

  List<_i2.CarePlanTask>? tasks;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AnimalCarePlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AnimalCarePlan copyWith({
    int? id,
    int? animalIdentificationRecordId,
    String? userIdentifier,
    int? version,
    DateTime? generatedAt,
    String? modelName,
    double? generationConfidence,
    String? summary,
    int? totalDailyTimeMinutes,
    int? totalWeeklyTimeMinutes,
    String? status,
    List<_i2.CarePlanTask>? tasks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnimalCarePlan',
      if (id != null) 'id': id,
      'animalIdentificationRecordId': animalIdentificationRecordId,
      'userIdentifier': userIdentifier,
      'version': version,
      'generatedAt': generatedAt.toJson(),
      'modelName': modelName,
      'generationConfidence': generationConfidence,
      if (summary != null) 'summary': summary,
      'totalDailyTimeMinutes': totalDailyTimeMinutes,
      'totalWeeklyTimeMinutes': totalWeeklyTimeMinutes,
      'status': status,
      if (tasks != null) 'tasks': tasks?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnimalCarePlan',
      if (id != null) 'id': id,
      'animalIdentificationRecordId': animalIdentificationRecordId,
      'userIdentifier': userIdentifier,
      'version': version,
      'generatedAt': generatedAt.toJson(),
      'modelName': modelName,
      'generationConfidence': generationConfidence,
      if (summary != null) 'summary': summary,
      'totalDailyTimeMinutes': totalDailyTimeMinutes,
      'totalWeeklyTimeMinutes': totalWeeklyTimeMinutes,
      'status': status,
      if (tasks != null)
        'tasks': tasks?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static AnimalCarePlanInclude include({_i2.CarePlanTaskIncludeList? tasks}) {
    return AnimalCarePlanInclude._(tasks: tasks);
  }

  static AnimalCarePlanIncludeList includeList({
    _i1.WhereExpressionBuilder<AnimalCarePlanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AnimalCarePlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnimalCarePlanTable>? orderByList,
    AnimalCarePlanInclude? include,
  }) {
    return AnimalCarePlanIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AnimalCarePlan.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AnimalCarePlan.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnimalCarePlanImpl extends AnimalCarePlan {
  _AnimalCarePlanImpl({
    int? id,
    required int animalIdentificationRecordId,
    required String userIdentifier,
    required int version,
    required DateTime generatedAt,
    required String modelName,
    required double generationConfidence,
    String? summary,
    required int totalDailyTimeMinutes,
    required int totalWeeklyTimeMinutes,
    required String status,
    List<_i2.CarePlanTask>? tasks,
  }) : super._(
         id: id,
         animalIdentificationRecordId: animalIdentificationRecordId,
         userIdentifier: userIdentifier,
         version: version,
         generatedAt: generatedAt,
         modelName: modelName,
         generationConfidence: generationConfidence,
         summary: summary,
         totalDailyTimeMinutes: totalDailyTimeMinutes,
         totalWeeklyTimeMinutes: totalWeeklyTimeMinutes,
         status: status,
         tasks: tasks,
       );

  /// Returns a shallow copy of this [AnimalCarePlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AnimalCarePlan copyWith({
    Object? id = _Undefined,
    int? animalIdentificationRecordId,
    String? userIdentifier,
    int? version,
    DateTime? generatedAt,
    String? modelName,
    double? generationConfidence,
    Object? summary = _Undefined,
    int? totalDailyTimeMinutes,
    int? totalWeeklyTimeMinutes,
    String? status,
    Object? tasks = _Undefined,
  }) {
    return AnimalCarePlan(
      id: id is int? ? id : this.id,
      animalIdentificationRecordId:
          animalIdentificationRecordId ?? this.animalIdentificationRecordId,
      userIdentifier: userIdentifier ?? this.userIdentifier,
      version: version ?? this.version,
      generatedAt: generatedAt ?? this.generatedAt,
      modelName: modelName ?? this.modelName,
      generationConfidence: generationConfidence ?? this.generationConfidence,
      summary: summary is String? ? summary : this.summary,
      totalDailyTimeMinutes:
          totalDailyTimeMinutes ?? this.totalDailyTimeMinutes,
      totalWeeklyTimeMinutes:
          totalWeeklyTimeMinutes ?? this.totalWeeklyTimeMinutes,
      status: status ?? this.status,
      tasks: tasks is List<_i2.CarePlanTask>?
          ? tasks
          : this.tasks?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class AnimalCarePlanUpdateTable extends _i1.UpdateTable<AnimalCarePlanTable> {
  AnimalCarePlanUpdateTable(super.table);

  _i1.ColumnValue<int, int> animalIdentificationRecordId(int value) =>
      _i1.ColumnValue(
        table.animalIdentificationRecordId,
        value,
      );

  _i1.ColumnValue<String, String> userIdentifier(String value) =>
      _i1.ColumnValue(
        table.userIdentifier,
        value,
      );

  _i1.ColumnValue<int, int> version(int value) => _i1.ColumnValue(
    table.version,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> generatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.generatedAt,
        value,
      );

  _i1.ColumnValue<String, String> modelName(String value) => _i1.ColumnValue(
    table.modelName,
    value,
  );

  _i1.ColumnValue<double, double> generationConfidence(double value) =>
      _i1.ColumnValue(
        table.generationConfidence,
        value,
      );

  _i1.ColumnValue<String, String> summary(String? value) => _i1.ColumnValue(
    table.summary,
    value,
  );

  _i1.ColumnValue<int, int> totalDailyTimeMinutes(int value) => _i1.ColumnValue(
    table.totalDailyTimeMinutes,
    value,
  );

  _i1.ColumnValue<int, int> totalWeeklyTimeMinutes(int value) =>
      _i1.ColumnValue(
        table.totalWeeklyTimeMinutes,
        value,
      );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );
}

class AnimalCarePlanTable extends _i1.Table<int?> {
  AnimalCarePlanTable({super.tableRelation})
    : super(tableName: 'animal_care_plan') {
    updateTable = AnimalCarePlanUpdateTable(this);
    animalIdentificationRecordId = _i1.ColumnInt(
      'animalIdentificationRecordId',
      this,
    );
    userIdentifier = _i1.ColumnString(
      'userIdentifier',
      this,
    );
    version = _i1.ColumnInt(
      'version',
      this,
    );
    generatedAt = _i1.ColumnDateTime(
      'generatedAt',
      this,
    );
    modelName = _i1.ColumnString(
      'modelName',
      this,
    );
    generationConfidence = _i1.ColumnDouble(
      'generationConfidence',
      this,
    );
    summary = _i1.ColumnString(
      'summary',
      this,
    );
    totalDailyTimeMinutes = _i1.ColumnInt(
      'totalDailyTimeMinutes',
      this,
    );
    totalWeeklyTimeMinutes = _i1.ColumnInt(
      'totalWeeklyTimeMinutes',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
  }

  late final AnimalCarePlanUpdateTable updateTable;

  late final _i1.ColumnInt animalIdentificationRecordId;

  late final _i1.ColumnString userIdentifier;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime generatedAt;

  late final _i1.ColumnString modelName;

  late final _i1.ColumnDouble generationConfidence;

  late final _i1.ColumnString summary;

  late final _i1.ColumnInt totalDailyTimeMinutes;

  late final _i1.ColumnInt totalWeeklyTimeMinutes;

  late final _i1.ColumnString status;

  _i2.CarePlanTaskTable? ___tasks;

  _i1.ManyRelation<_i2.CarePlanTaskTable>? _tasks;

  _i2.CarePlanTaskTable get __tasks {
    if (___tasks != null) return ___tasks!;
    ___tasks = _i1.createRelationTable(
      relationFieldName: '__tasks',
      field: AnimalCarePlan.t.id,
      foreignField: _i2.CarePlanTask.t.$_animalCarePlanTasksAnimalCarePlanId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CarePlanTaskTable(tableRelation: foreignTableRelation),
    );
    return ___tasks!;
  }

  _i1.ManyRelation<_i2.CarePlanTaskTable> get tasks {
    if (_tasks != null) return _tasks!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'tasks',
      field: AnimalCarePlan.t.id,
      foreignField: _i2.CarePlanTask.t.$_animalCarePlanTasksAnimalCarePlanId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CarePlanTaskTable(tableRelation: foreignTableRelation),
    );
    _tasks = _i1.ManyRelation<_i2.CarePlanTaskTable>(
      tableWithRelations: relationTable,
      table: _i2.CarePlanTaskTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _tasks!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    animalIdentificationRecordId,
    userIdentifier,
    version,
    generatedAt,
    modelName,
    generationConfidence,
    summary,
    totalDailyTimeMinutes,
    totalWeeklyTimeMinutes,
    status,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'tasks') {
      return __tasks;
    }
    return null;
  }
}

class AnimalCarePlanInclude extends _i1.IncludeObject {
  AnimalCarePlanInclude._({_i2.CarePlanTaskIncludeList? tasks}) {
    _tasks = tasks;
  }

  _i2.CarePlanTaskIncludeList? _tasks;

  @override
  Map<String, _i1.Include?> get includes => {'tasks': _tasks};

  @override
  _i1.Table<int?> get table => AnimalCarePlan.t;
}

class AnimalCarePlanIncludeList extends _i1.IncludeList {
  AnimalCarePlanIncludeList._({
    _i1.WhereExpressionBuilder<AnimalCarePlanTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AnimalCarePlan.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AnimalCarePlan.t;
}

class AnimalCarePlanRepository {
  const AnimalCarePlanRepository._();

  final attach = const AnimalCarePlanAttachRepository._();

  final attachRow = const AnimalCarePlanAttachRowRepository._();

  final detach = const AnimalCarePlanDetachRepository._();

  final detachRow = const AnimalCarePlanDetachRowRepository._();

  /// Returns a list of [AnimalCarePlan]s matching the given query parameters.
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
  Future<List<AnimalCarePlan>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AnimalCarePlanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AnimalCarePlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnimalCarePlanTable>? orderByList,
    _i1.Transaction? transaction,
    AnimalCarePlanInclude? include,
  }) async {
    return session.db.find<AnimalCarePlan>(
      where: where?.call(AnimalCarePlan.t),
      orderBy: orderBy?.call(AnimalCarePlan.t),
      orderByList: orderByList?.call(AnimalCarePlan.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [AnimalCarePlan] matching the given query parameters.
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
  Future<AnimalCarePlan?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AnimalCarePlanTable>? where,
    int? offset,
    _i1.OrderByBuilder<AnimalCarePlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnimalCarePlanTable>? orderByList,
    _i1.Transaction? transaction,
    AnimalCarePlanInclude? include,
  }) async {
    return session.db.findFirstRow<AnimalCarePlan>(
      where: where?.call(AnimalCarePlan.t),
      orderBy: orderBy?.call(AnimalCarePlan.t),
      orderByList: orderByList?.call(AnimalCarePlan.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [AnimalCarePlan] by its [id] or null if no such row exists.
  Future<AnimalCarePlan?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    AnimalCarePlanInclude? include,
  }) async {
    return session.db.findById<AnimalCarePlan>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [AnimalCarePlan]s in the list and returns the inserted rows.
  ///
  /// The returned [AnimalCarePlan]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<AnimalCarePlan>> insert(
    _i1.Session session,
    List<AnimalCarePlan> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<AnimalCarePlan>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [AnimalCarePlan] and returns the inserted row.
  ///
  /// The returned [AnimalCarePlan] will have its `id` field set.
  Future<AnimalCarePlan> insertRow(
    _i1.Session session,
    AnimalCarePlan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AnimalCarePlan>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AnimalCarePlan]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AnimalCarePlan>> update(
    _i1.Session session,
    List<AnimalCarePlan> rows, {
    _i1.ColumnSelections<AnimalCarePlanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AnimalCarePlan>(
      rows,
      columns: columns?.call(AnimalCarePlan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AnimalCarePlan]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AnimalCarePlan> updateRow(
    _i1.Session session,
    AnimalCarePlan row, {
    _i1.ColumnSelections<AnimalCarePlanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AnimalCarePlan>(
      row,
      columns: columns?.call(AnimalCarePlan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AnimalCarePlan] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AnimalCarePlan?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<AnimalCarePlanUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AnimalCarePlan>(
      id,
      columnValues: columnValues(AnimalCarePlan.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AnimalCarePlan]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AnimalCarePlan>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<AnimalCarePlanUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AnimalCarePlanTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AnimalCarePlanTable>? orderBy,
    _i1.OrderByListBuilder<AnimalCarePlanTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AnimalCarePlan>(
      columnValues: columnValues(AnimalCarePlan.t.updateTable),
      where: where(AnimalCarePlan.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AnimalCarePlan.t),
      orderByList: orderByList?.call(AnimalCarePlan.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AnimalCarePlan]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AnimalCarePlan>> delete(
    _i1.Session session,
    List<AnimalCarePlan> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AnimalCarePlan>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AnimalCarePlan].
  Future<AnimalCarePlan> deleteRow(
    _i1.Session session,
    AnimalCarePlan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AnimalCarePlan>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AnimalCarePlan>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AnimalCarePlanTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AnimalCarePlan>(
      where: where(AnimalCarePlan.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AnimalCarePlanTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AnimalCarePlan>(
      where: where?.call(AnimalCarePlan.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class AnimalCarePlanAttachRepository {
  const AnimalCarePlanAttachRepository._();

  /// Creates a relation between this [AnimalCarePlan] and the given [CarePlanTask]s
  /// by setting each [CarePlanTask]'s foreign key `_animalCarePlanTasksAnimalCarePlanId` to refer to this [AnimalCarePlan].
  Future<void> tasks(
    _i1.Session session,
    AnimalCarePlan animalCarePlan,
    List<_i2.CarePlanTask> carePlanTask, {
    _i1.Transaction? transaction,
  }) async {
    if (carePlanTask.any((e) => e.id == null)) {
      throw ArgumentError.notNull('carePlanTask.id');
    }
    if (animalCarePlan.id == null) {
      throw ArgumentError.notNull('animalCarePlan.id');
    }

    var $carePlanTask = carePlanTask
        .map(
          (e) => _i2.CarePlanTaskImplicit(
            e,
            $_animalCarePlanTasksAnimalCarePlanId: animalCarePlan.id,
          ),
        )
        .toList();
    await session.db.update<_i2.CarePlanTask>(
      $carePlanTask,
      columns: [_i2.CarePlanTask.t.$_animalCarePlanTasksAnimalCarePlanId],
      transaction: transaction,
    );
  }
}

class AnimalCarePlanAttachRowRepository {
  const AnimalCarePlanAttachRowRepository._();

  /// Creates a relation between this [AnimalCarePlan] and the given [CarePlanTask]
  /// by setting the [CarePlanTask]'s foreign key `_animalCarePlanTasksAnimalCarePlanId` to refer to this [AnimalCarePlan].
  Future<void> tasks(
    _i1.Session session,
    AnimalCarePlan animalCarePlan,
    _i2.CarePlanTask carePlanTask, {
    _i1.Transaction? transaction,
  }) async {
    if (carePlanTask.id == null) {
      throw ArgumentError.notNull('carePlanTask.id');
    }
    if (animalCarePlan.id == null) {
      throw ArgumentError.notNull('animalCarePlan.id');
    }

    var $carePlanTask = _i2.CarePlanTaskImplicit(
      carePlanTask,
      $_animalCarePlanTasksAnimalCarePlanId: animalCarePlan.id,
    );
    await session.db.updateRow<_i2.CarePlanTask>(
      $carePlanTask,
      columns: [_i2.CarePlanTask.t.$_animalCarePlanTasksAnimalCarePlanId],
      transaction: transaction,
    );
  }
}

class AnimalCarePlanDetachRepository {
  const AnimalCarePlanDetachRepository._();

  /// Detaches the relation between this [AnimalCarePlan] and the given [CarePlanTask]
  /// by setting the [CarePlanTask]'s foreign key `_animalCarePlanTasksAnimalCarePlanId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> tasks(
    _i1.Session session,
    List<_i2.CarePlanTask> carePlanTask, {
    _i1.Transaction? transaction,
  }) async {
    if (carePlanTask.any((e) => e.id == null)) {
      throw ArgumentError.notNull('carePlanTask.id');
    }

    var $carePlanTask = carePlanTask
        .map(
          (e) => _i2.CarePlanTaskImplicit(
            e,
            $_animalCarePlanTasksAnimalCarePlanId: null,
          ),
        )
        .toList();
    await session.db.update<_i2.CarePlanTask>(
      $carePlanTask,
      columns: [_i2.CarePlanTask.t.$_animalCarePlanTasksAnimalCarePlanId],
      transaction: transaction,
    );
  }
}

class AnimalCarePlanDetachRowRepository {
  const AnimalCarePlanDetachRowRepository._();

  /// Detaches the relation between this [AnimalCarePlan] and the given [CarePlanTask]
  /// by setting the [CarePlanTask]'s foreign key `_animalCarePlanTasksAnimalCarePlanId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> tasks(
    _i1.Session session,
    _i2.CarePlanTask carePlanTask, {
    _i1.Transaction? transaction,
  }) async {
    if (carePlanTask.id == null) {
      throw ArgumentError.notNull('carePlanTask.id');
    }

    var $carePlanTask = _i2.CarePlanTaskImplicit(
      carePlanTask,
      $_animalCarePlanTasksAnimalCarePlanId: null,
    );
    await session.db.updateRow<_i2.CarePlanTask>(
      $carePlanTask,
      columns: [_i2.CarePlanTask.t.$_animalCarePlanTasksAnimalCarePlanId],
      transaction: transaction,
    );
  }
}
