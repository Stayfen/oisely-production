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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i3;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i4;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i5;
import 'adoption_info.dart' as _i6;
import 'animal_care_plan.dart' as _i7;
import 'animal_identification_record.dart' as _i8;
import 'behavior_analysis_insight.dart' as _i9;
import 'behavior_analysis_result.dart' as _i10;
import 'behavior_frame_insight.dart' as _i11;
import 'care_plan_generation_result.dart' as _i12;
import 'care_plan_response.dart' as _i13;
import 'care_plan_task.dart' as _i14;
import 'greetings/greeting.dart' as _i15;
import 'magic_link_token.dart' as _i16;
import 'rate_limit_counter.dart' as _i17;
import 'package:oisely_server/src/generated/animal_care_plan.dart' as _i18;
export 'adoption_info.dart';
export 'animal_care_plan.dart';
export 'animal_identification_record.dart';
export 'behavior_analysis_insight.dart';
export 'behavior_analysis_result.dart';
export 'behavior_frame_insight.dart';
export 'care_plan_generation_result.dart';
export 'care_plan_response.dart';
export 'care_plan_task.dart';
export 'greetings/greeting.dart';
export 'magic_link_token.dart';
export 'rate_limit_counter.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'animal_care_plan',
      dartName: 'AnimalCarePlan',
      schema: 'public',
      module: 'oisely',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'animal_care_plan_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'animalIdentificationRecordId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userIdentifier',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'generatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'modelName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'generationConfidence',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'summary',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'totalDailyTimeMinutes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'totalWeeklyTimeMinutes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'animal_care_plan_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'animal_care_plan_animal_id_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'animalIdentificationRecordId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'animal_care_plan_user_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userIdentifier',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'animal_care_plan_version_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'animalIdentificationRecordId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'version',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'animal_care_plan_status_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'animal_care_plan_generated_at_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userIdentifier',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'generatedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'animal_identification_record',
      dartName: 'AnimalIdentificationRecord',
      schema: 'public',
      module: 'oisely',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'animal_identification_record_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userIdentifier',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'species',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'breed',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'confidence',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'imageSha256',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'modelName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'animal_identification_record_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'animal_identification_user_created_at_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userIdentifier',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'animal_identification_species_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'species',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'behavior_analysis_result',
      dartName: 'BehaviorAnalysisResult',
      schema: 'public',
      module: 'oisely',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'behavior_analysis_result_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userIdentifier',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'requestId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'videoSha256',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'videoDurationSeconds',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'identifiedSpecies',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'identifiedBreed',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'activityLevel',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'emotionalState',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'behaviorPatternsJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'movementSummary',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'postureSummary',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'vocalizationSummary',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'movementPatternsJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'vocalizationPatternsJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'keyFramesJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'analysisConfidence',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'modelName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'modelResponseCiphertext',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'modelResponseNonce',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'modelResponseMac',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'behavior_analysis_result_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'behavior_analysis_user_created_at_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userIdentifier',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'behavior_analysis_species_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'identifiedSpecies',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'care_plan_task',
      dartName: 'CarePlanTask',
      schema: 'public',
      module: 'oisely',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'care_plan_task_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'carePlanId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'taskType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'estimatedDurationMinutes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'priority',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'suggestedTimeOfDay',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'aiReasoning',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: '_animalCarePlanTasksAnimalCarePlanId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'care_plan_task_fk_0',
          columns: ['carePlanId'],
          referenceTable: 'animal_care_plan',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'care_plan_task_fk_1',
          columns: ['_animalCarePlanTasksAnimalCarePlanId'],
          referenceTable: 'animal_care_plan',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'care_plan_task_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'care_plan_task_plan_id_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'carePlanId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'care_plan_task_type_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'carePlanId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'taskType',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'care_plan_task_priority_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'priority',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'magic_link_token',
      dartName: 'MagicLinkToken',
      schema: 'public',
      module: 'oisely',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'magic_link_token_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'token',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'requestedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'expiration',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'magic_link_token_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'email_index',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'email',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i5.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i6.AdoptionInfo) {
      return _i6.AdoptionInfo.fromJson(data) as T;
    }
    if (t == _i7.AnimalCarePlan) {
      return _i7.AnimalCarePlan.fromJson(data) as T;
    }
    if (t == _i8.AnimalIdentificationRecord) {
      return _i8.AnimalIdentificationRecord.fromJson(data) as T;
    }
    if (t == _i9.BehaviorAnalysisInsight) {
      return _i9.BehaviorAnalysisInsight.fromJson(data) as T;
    }
    if (t == _i10.BehaviorAnalysisResult) {
      return _i10.BehaviorAnalysisResult.fromJson(data) as T;
    }
    if (t == _i11.BehaviorFrameInsight) {
      return _i11.BehaviorFrameInsight.fromJson(data) as T;
    }
    if (t == _i12.CarePlanGenerationResult) {
      return _i12.CarePlanGenerationResult.fromJson(data) as T;
    }
    if (t == _i13.CarePlanTaskResponse) {
      return _i13.CarePlanTaskResponse.fromJson(data) as T;
    }
    if (t == _i14.CarePlanTask) {
      return _i14.CarePlanTask.fromJson(data) as T;
    }
    if (t == _i15.Greeting) {
      return _i15.Greeting.fromJson(data) as T;
    }
    if (t == _i16.MagicLinkToken) {
      return _i16.MagicLinkToken.fromJson(data) as T;
    }
    if (t == _i17.RateLimitCounter) {
      return _i17.RateLimitCounter.fromJson(data) as T;
    }
    if (t == _i1.getType<_i6.AdoptionInfo?>()) {
      return (data != null ? _i6.AdoptionInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AnimalCarePlan?>()) {
      return (data != null ? _i7.AnimalCarePlan.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AnimalIdentificationRecord?>()) {
      return (data != null
              ? _i8.AnimalIdentificationRecord.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i9.BehaviorAnalysisInsight?>()) {
      return (data != null ? _i9.BehaviorAnalysisInsight.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.BehaviorAnalysisResult?>()) {
      return (data != null ? _i10.BehaviorAnalysisResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.BehaviorFrameInsight?>()) {
      return (data != null ? _i11.BehaviorFrameInsight.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.CarePlanGenerationResult?>()) {
      return (data != null
              ? _i12.CarePlanGenerationResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i13.CarePlanTaskResponse?>()) {
      return (data != null ? _i13.CarePlanTaskResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.CarePlanTask?>()) {
      return (data != null ? _i14.CarePlanTask.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Greeting?>()) {
      return (data != null ? _i15.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.MagicLinkToken?>()) {
      return (data != null ? _i16.MagicLinkToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.RateLimitCounter?>()) {
      return (data != null ? _i17.RateLimitCounter.fromJson(data) : null) as T;
    }
    if (t == List<_i14.CarePlanTask>) {
      return (data as List)
              .map((e) => deserialize<_i14.CarePlanTask>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i14.CarePlanTask>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i14.CarePlanTask>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i11.BehaviorFrameInsight>) {
      return (data as List)
              .map((e) => deserialize<_i11.BehaviorFrameInsight>(e))
              .toList()
          as T;
    }
    if (t == List<_i13.CarePlanTaskResponse>) {
      return (data as List)
              .map((e) => deserialize<_i13.CarePlanTaskResponse>(e))
              .toList()
          as T;
    }
    if (t == List<_i18.AnimalCarePlan>) {
      return (data as List)
              .map((e) => deserialize<_i18.AnimalCarePlan>(e))
              .toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i5.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i6.AdoptionInfo => 'AdoptionInfo',
      _i7.AnimalCarePlan => 'AnimalCarePlan',
      _i8.AnimalIdentificationRecord => 'AnimalIdentificationRecord',
      _i9.BehaviorAnalysisInsight => 'BehaviorAnalysisInsight',
      _i10.BehaviorAnalysisResult => 'BehaviorAnalysisResult',
      _i11.BehaviorFrameInsight => 'BehaviorFrameInsight',
      _i12.CarePlanGenerationResult => 'CarePlanGenerationResult',
      _i13.CarePlanTaskResponse => 'CarePlanTaskResponse',
      _i14.CarePlanTask => 'CarePlanTask',
      _i15.Greeting => 'Greeting',
      _i16.MagicLinkToken => 'MagicLinkToken',
      _i17.RateLimitCounter => 'RateLimitCounter',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('oisely.', '');
    }

    switch (data) {
      case _i6.AdoptionInfo():
        return 'AdoptionInfo';
      case _i7.AnimalCarePlan():
        return 'AnimalCarePlan';
      case _i8.AnimalIdentificationRecord():
        return 'AnimalIdentificationRecord';
      case _i9.BehaviorAnalysisInsight():
        return 'BehaviorAnalysisInsight';
      case _i10.BehaviorAnalysisResult():
        return 'BehaviorAnalysisResult';
      case _i11.BehaviorFrameInsight():
        return 'BehaviorFrameInsight';
      case _i12.CarePlanGenerationResult():
        return 'CarePlanGenerationResult';
      case _i13.CarePlanTaskResponse():
        return 'CarePlanTaskResponse';
      case _i14.CarePlanTask():
        return 'CarePlanTask';
      case _i15.Greeting():
        return 'Greeting';
      case _i16.MagicLinkToken():
        return 'MagicLinkToken';
      case _i17.RateLimitCounter():
        return 'RateLimitCounter';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i5.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AdoptionInfo') {
      return deserialize<_i6.AdoptionInfo>(data['data']);
    }
    if (dataClassName == 'AnimalCarePlan') {
      return deserialize<_i7.AnimalCarePlan>(data['data']);
    }
    if (dataClassName == 'AnimalIdentificationRecord') {
      return deserialize<_i8.AnimalIdentificationRecord>(data['data']);
    }
    if (dataClassName == 'BehaviorAnalysisInsight') {
      return deserialize<_i9.BehaviorAnalysisInsight>(data['data']);
    }
    if (dataClassName == 'BehaviorAnalysisResult') {
      return deserialize<_i10.BehaviorAnalysisResult>(data['data']);
    }
    if (dataClassName == 'BehaviorFrameInsight') {
      return deserialize<_i11.BehaviorFrameInsight>(data['data']);
    }
    if (dataClassName == 'CarePlanGenerationResult') {
      return deserialize<_i12.CarePlanGenerationResult>(data['data']);
    }
    if (dataClassName == 'CarePlanTaskResponse') {
      return deserialize<_i13.CarePlanTaskResponse>(data['data']);
    }
    if (dataClassName == 'CarePlanTask') {
      return deserialize<_i14.CarePlanTask>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i15.Greeting>(data['data']);
    }
    if (dataClassName == 'MagicLinkToken') {
      return deserialize<_i16.MagicLinkToken>(data['data']);
    }
    if (dataClassName == 'RateLimitCounter') {
      return deserialize<_i17.RateLimitCounter>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i4.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i5.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i5.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i7.AnimalCarePlan:
        return _i7.AnimalCarePlan.t;
      case _i8.AnimalIdentificationRecord:
        return _i8.AnimalIdentificationRecord.t;
      case _i10.BehaviorAnalysisResult:
        return _i10.BehaviorAnalysisResult.t;
      case _i14.CarePlanTask:
        return _i14.CarePlanTask.t;
      case _i16.MagicLinkToken:
        return _i16.MagicLinkToken.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'oisely';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i5.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
