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

abstract class CarePlanTask
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CarePlanTask._({
    this.id,
    required this.carePlanId,
    required this.taskType,
    required this.title,
    required this.description,
    required this.estimatedDurationMinutes,
    required this.priority,
    this.suggestedTimeOfDay,
    this.aiReasoning,
    required this.createdAt,
  }) : _animalCarePlanTasksAnimalCarePlanId = null;

  factory CarePlanTask({
    int? id,
    required int carePlanId,
    required String taskType,
    required String title,
    required String description,
    required int estimatedDurationMinutes,
    required String priority,
    String? suggestedTimeOfDay,
    String? aiReasoning,
    required DateTime createdAt,
  }) = _CarePlanTaskImpl;

  factory CarePlanTask.fromJson(Map<String, dynamic> jsonSerialization) {
    return CarePlanTaskImplicit._(
      id: jsonSerialization['id'] as int?,
      carePlanId: jsonSerialization['carePlanId'] as int,
      taskType: jsonSerialization['taskType'] as String,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      estimatedDurationMinutes:
          jsonSerialization['estimatedDurationMinutes'] as int,
      priority: jsonSerialization['priority'] as String,
      suggestedTimeOfDay: jsonSerialization['suggestedTimeOfDay'] as String?,
      aiReasoning: jsonSerialization['aiReasoning'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      $_animalCarePlanTasksAnimalCarePlanId:
          jsonSerialization['_animalCarePlanTasksAnimalCarePlanId'] as int?,
    );
  }

  static final t = CarePlanTaskTable();

  static const db = CarePlanTaskRepository._();

  @override
  int? id;

  int carePlanId;

  String taskType;

  String title;

  String description;

  int estimatedDurationMinutes;

  String priority;

  String? suggestedTimeOfDay;

  String? aiReasoning;

  DateTime createdAt;

  final int? _animalCarePlanTasksAnimalCarePlanId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CarePlanTask]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CarePlanTask copyWith({
    int? id,
    int? carePlanId,
    String? taskType,
    String? title,
    String? description,
    int? estimatedDurationMinutes,
    String? priority,
    String? suggestedTimeOfDay,
    String? aiReasoning,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CarePlanTask',
      if (id != null) 'id': id,
      'carePlanId': carePlanId,
      'taskType': taskType,
      'title': title,
      'description': description,
      'estimatedDurationMinutes': estimatedDurationMinutes,
      'priority': priority,
      if (suggestedTimeOfDay != null) 'suggestedTimeOfDay': suggestedTimeOfDay,
      if (aiReasoning != null) 'aiReasoning': aiReasoning,
      'createdAt': createdAt.toJson(),
      if (_animalCarePlanTasksAnimalCarePlanId != null)
        '_animalCarePlanTasksAnimalCarePlanId':
            _animalCarePlanTasksAnimalCarePlanId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CarePlanTask',
      if (id != null) 'id': id,
      'carePlanId': carePlanId,
      'taskType': taskType,
      'title': title,
      'description': description,
      'estimatedDurationMinutes': estimatedDurationMinutes,
      'priority': priority,
      if (suggestedTimeOfDay != null) 'suggestedTimeOfDay': suggestedTimeOfDay,
      if (aiReasoning != null) 'aiReasoning': aiReasoning,
      'createdAt': createdAt.toJson(),
    };
  }

  static CarePlanTaskInclude include() {
    return CarePlanTaskInclude._();
  }

  static CarePlanTaskIncludeList includeList({
    _i1.WhereExpressionBuilder<CarePlanTaskTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CarePlanTaskTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CarePlanTaskTable>? orderByList,
    CarePlanTaskInclude? include,
  }) {
    return CarePlanTaskIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CarePlanTask.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CarePlanTask.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CarePlanTaskImpl extends CarePlanTask {
  _CarePlanTaskImpl({
    int? id,
    required int carePlanId,
    required String taskType,
    required String title,
    required String description,
    required int estimatedDurationMinutes,
    required String priority,
    String? suggestedTimeOfDay,
    String? aiReasoning,
    required DateTime createdAt,
  }) : super._(
         id: id,
         carePlanId: carePlanId,
         taskType: taskType,
         title: title,
         description: description,
         estimatedDurationMinutes: estimatedDurationMinutes,
         priority: priority,
         suggestedTimeOfDay: suggestedTimeOfDay,
         aiReasoning: aiReasoning,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CarePlanTask]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CarePlanTask copyWith({
    Object? id = _Undefined,
    int? carePlanId,
    String? taskType,
    String? title,
    String? description,
    int? estimatedDurationMinutes,
    String? priority,
    Object? suggestedTimeOfDay = _Undefined,
    Object? aiReasoning = _Undefined,
    DateTime? createdAt,
  }) {
    return CarePlanTaskImplicit._(
      id: id is int? ? id : this.id,
      carePlanId: carePlanId ?? this.carePlanId,
      taskType: taskType ?? this.taskType,
      title: title ?? this.title,
      description: description ?? this.description,
      estimatedDurationMinutes:
          estimatedDurationMinutes ?? this.estimatedDurationMinutes,
      priority: priority ?? this.priority,
      suggestedTimeOfDay: suggestedTimeOfDay is String?
          ? suggestedTimeOfDay
          : this.suggestedTimeOfDay,
      aiReasoning: aiReasoning is String? ? aiReasoning : this.aiReasoning,
      createdAt: createdAt ?? this.createdAt,
      $_animalCarePlanTasksAnimalCarePlanId:
          this._animalCarePlanTasksAnimalCarePlanId,
    );
  }
}

class CarePlanTaskImplicit extends _CarePlanTaskImpl {
  CarePlanTaskImplicit._({
    int? id,
    required int carePlanId,
    required String taskType,
    required String title,
    required String description,
    required int estimatedDurationMinutes,
    required String priority,
    String? suggestedTimeOfDay,
    String? aiReasoning,
    required DateTime createdAt,
    int? $_animalCarePlanTasksAnimalCarePlanId,
  }) : _animalCarePlanTasksAnimalCarePlanId =
           $_animalCarePlanTasksAnimalCarePlanId,
       super(
         id: id,
         carePlanId: carePlanId,
         taskType: taskType,
         title: title,
         description: description,
         estimatedDurationMinutes: estimatedDurationMinutes,
         priority: priority,
         suggestedTimeOfDay: suggestedTimeOfDay,
         aiReasoning: aiReasoning,
         createdAt: createdAt,
       );

  factory CarePlanTaskImplicit(
    CarePlanTask carePlanTask, {
    int? $_animalCarePlanTasksAnimalCarePlanId,
  }) {
    return CarePlanTaskImplicit._(
      id: carePlanTask.id,
      carePlanId: carePlanTask.carePlanId,
      taskType: carePlanTask.taskType,
      title: carePlanTask.title,
      description: carePlanTask.description,
      estimatedDurationMinutes: carePlanTask.estimatedDurationMinutes,
      priority: carePlanTask.priority,
      suggestedTimeOfDay: carePlanTask.suggestedTimeOfDay,
      aiReasoning: carePlanTask.aiReasoning,
      createdAt: carePlanTask.createdAt,
      $_animalCarePlanTasksAnimalCarePlanId:
          $_animalCarePlanTasksAnimalCarePlanId,
    );
  }

  @override
  final int? _animalCarePlanTasksAnimalCarePlanId;
}

class CarePlanTaskUpdateTable extends _i1.UpdateTable<CarePlanTaskTable> {
  CarePlanTaskUpdateTable(super.table);

  _i1.ColumnValue<int, int> carePlanId(int value) => _i1.ColumnValue(
    table.carePlanId,
    value,
  );

  _i1.ColumnValue<String, String> taskType(String value) => _i1.ColumnValue(
    table.taskType,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> description(String value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<int, int> estimatedDurationMinutes(int value) =>
      _i1.ColumnValue(
        table.estimatedDurationMinutes,
        value,
      );

  _i1.ColumnValue<String, String> priority(String value) => _i1.ColumnValue(
    table.priority,
    value,
  );

  _i1.ColumnValue<String, String> suggestedTimeOfDay(String? value) =>
      _i1.ColumnValue(
        table.suggestedTimeOfDay,
        value,
      );

  _i1.ColumnValue<String, String> aiReasoning(String? value) => _i1.ColumnValue(
    table.aiReasoning,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<int, int> $_animalCarePlanTasksAnimalCarePlanId(int? value) =>
      _i1.ColumnValue(
        table.$_animalCarePlanTasksAnimalCarePlanId,
        value,
      );
}

class CarePlanTaskTable extends _i1.Table<int?> {
  CarePlanTaskTable({super.tableRelation})
    : super(tableName: 'care_plan_task') {
    updateTable = CarePlanTaskUpdateTable(this);
    carePlanId = _i1.ColumnInt(
      'carePlanId',
      this,
    );
    taskType = _i1.ColumnString(
      'taskType',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    estimatedDurationMinutes = _i1.ColumnInt(
      'estimatedDurationMinutes',
      this,
    );
    priority = _i1.ColumnString(
      'priority',
      this,
    );
    suggestedTimeOfDay = _i1.ColumnString(
      'suggestedTimeOfDay',
      this,
    );
    aiReasoning = _i1.ColumnString(
      'aiReasoning',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    $_animalCarePlanTasksAnimalCarePlanId = _i1.ColumnInt(
      '_animalCarePlanTasksAnimalCarePlanId',
      this,
    );
  }

  late final CarePlanTaskUpdateTable updateTable;

  late final _i1.ColumnInt carePlanId;

  late final _i1.ColumnString taskType;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt estimatedDurationMinutes;

  late final _i1.ColumnString priority;

  late final _i1.ColumnString suggestedTimeOfDay;

  late final _i1.ColumnString aiReasoning;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnInt $_animalCarePlanTasksAnimalCarePlanId;

  @override
  List<_i1.Column> get columns => [
    id,
    carePlanId,
    taskType,
    title,
    description,
    estimatedDurationMinutes,
    priority,
    suggestedTimeOfDay,
    aiReasoning,
    createdAt,
    $_animalCarePlanTasksAnimalCarePlanId,
  ];

  @override
  List<_i1.Column> get managedColumns => [
    id,
    carePlanId,
    taskType,
    title,
    description,
    estimatedDurationMinutes,
    priority,
    suggestedTimeOfDay,
    aiReasoning,
    createdAt,
  ];
}

class CarePlanTaskInclude extends _i1.IncludeObject {
  CarePlanTaskInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CarePlanTask.t;
}

class CarePlanTaskIncludeList extends _i1.IncludeList {
  CarePlanTaskIncludeList._({
    _i1.WhereExpressionBuilder<CarePlanTaskTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CarePlanTask.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CarePlanTask.t;
}

class CarePlanTaskRepository {
  const CarePlanTaskRepository._();

  /// Returns a list of [CarePlanTask]s matching the given query parameters.
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
  Future<List<CarePlanTask>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CarePlanTaskTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CarePlanTaskTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CarePlanTaskTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<CarePlanTask>(
      where: where?.call(CarePlanTask.t),
      orderBy: orderBy?.call(CarePlanTask.t),
      orderByList: orderByList?.call(CarePlanTask.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [CarePlanTask] matching the given query parameters.
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
  Future<CarePlanTask?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CarePlanTaskTable>? where,
    int? offset,
    _i1.OrderByBuilder<CarePlanTaskTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CarePlanTaskTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<CarePlanTask>(
      where: where?.call(CarePlanTask.t),
      orderBy: orderBy?.call(CarePlanTask.t),
      orderByList: orderByList?.call(CarePlanTask.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [CarePlanTask] by its [id] or null if no such row exists.
  Future<CarePlanTask?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<CarePlanTask>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [CarePlanTask]s in the list and returns the inserted rows.
  ///
  /// The returned [CarePlanTask]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CarePlanTask>> insert(
    _i1.Session session,
    List<CarePlanTask> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CarePlanTask>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CarePlanTask] and returns the inserted row.
  ///
  /// The returned [CarePlanTask] will have its `id` field set.
  Future<CarePlanTask> insertRow(
    _i1.Session session,
    CarePlanTask row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CarePlanTask>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CarePlanTask]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CarePlanTask>> update(
    _i1.Session session,
    List<CarePlanTask> rows, {
    _i1.ColumnSelections<CarePlanTaskTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CarePlanTask>(
      rows,
      columns: columns?.call(CarePlanTask.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CarePlanTask]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CarePlanTask> updateRow(
    _i1.Session session,
    CarePlanTask row, {
    _i1.ColumnSelections<CarePlanTaskTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CarePlanTask>(
      row,
      columns: columns?.call(CarePlanTask.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CarePlanTask] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CarePlanTask?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<CarePlanTaskUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CarePlanTask>(
      id,
      columnValues: columnValues(CarePlanTask.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CarePlanTask]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CarePlanTask>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<CarePlanTaskUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CarePlanTaskTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CarePlanTaskTable>? orderBy,
    _i1.OrderByListBuilder<CarePlanTaskTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CarePlanTask>(
      columnValues: columnValues(CarePlanTask.t.updateTable),
      where: where(CarePlanTask.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CarePlanTask.t),
      orderByList: orderByList?.call(CarePlanTask.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CarePlanTask]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CarePlanTask>> delete(
    _i1.Session session,
    List<CarePlanTask> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CarePlanTask>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CarePlanTask].
  Future<CarePlanTask> deleteRow(
    _i1.Session session,
    CarePlanTask row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CarePlanTask>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CarePlanTask>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CarePlanTaskTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CarePlanTask>(
      where: where(CarePlanTask.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CarePlanTaskTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CarePlanTask>(
      where: where?.call(CarePlanTask.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
