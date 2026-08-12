// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LogEntriesTable extends LogEntries
    with TableInfo<$LogEntriesTable, LogEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('general'));
  static const VerificationMeta _isPendingMeta =
      const VerificationMeta('isPending');
  @override
  late final GeneratedColumn<bool> isPending = GeneratedColumn<bool>(
      'is_pending', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_pending" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, body, createdAt, category, isPending];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'log_entries';
  @override
  VerificationContext validateIntegrity(Insertable<LogEntryRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('is_pending')) {
      context.handle(_isPendingMeta,
          isPending.isAcceptableOrUnknown(data['is_pending']!, _isPendingMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogEntryRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      isPending: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_pending'])!,
    );
  }

  @override
  $LogEntriesTable createAlias(String alias) {
    return $LogEntriesTable(attachedDatabase, alias);
  }
}

class LogEntryRow extends DataClass implements Insertable<LogEntryRow> {
  final int id;
  final String title;
  final String body;
  final DateTime createdAt;
  final String category;
  final bool isPending;
  const LogEntryRow(
      {required this.id,
      required this.title,
      required this.body,
      required this.createdAt,
      required this.category,
      required this.isPending});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['category'] = Variable<String>(category);
    map['is_pending'] = Variable<bool>(isPending);
    return map;
  }

  LogEntriesCompanion toCompanion(bool nullToAbsent) {
    return LogEntriesCompanion(
      id: Value(id),
      title: Value(title),
      body: Value(body),
      createdAt: Value(createdAt),
      category: Value(category),
      isPending: Value(isPending),
    );
  }

  factory LogEntryRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogEntryRow(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      category: serializer.fromJson<String>(json['category']),
      isPending: serializer.fromJson<bool>(json['isPending']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'category': serializer.toJson<String>(category),
      'isPending': serializer.toJson<bool>(isPending),
    };
  }

  LogEntryRow copyWith(
          {int? id,
          String? title,
          String? body,
          DateTime? createdAt,
          String? category,
          bool? isPending}) =>
      LogEntryRow(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        createdAt: createdAt ?? this.createdAt,
        category: category ?? this.category,
        isPending: isPending ?? this.isPending,
      );
  LogEntryRow copyWithCompanion(LogEntriesCompanion data) {
    return LogEntryRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      category: data.category.present ? data.category.value : this.category,
      isPending: data.isPending.present ? data.isPending.value : this.isPending,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LogEntryRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('category: $category, ')
          ..write('isPending: $isPending')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, body, createdAt, category, isPending);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogEntryRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.body == this.body &&
          other.createdAt == this.createdAt &&
          other.category == this.category &&
          other.isPending == this.isPending);
}

class LogEntriesCompanion extends UpdateCompanion<LogEntryRow> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> body;
  final Value<DateTime> createdAt;
  final Value<String> category;
  final Value<bool> isPending;
  const LogEntriesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.category = const Value.absent(),
    this.isPending = const Value.absent(),
  });
  LogEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String body,
    required DateTime createdAt,
    this.category = const Value.absent(),
    this.isPending = const Value.absent(),
  })  : title = Value(title),
        body = Value(body),
        createdAt = Value(createdAt);
  static Insertable<LogEntryRow> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? body,
    Expression<DateTime>? createdAt,
    Expression<String>? category,
    Expression<bool>? isPending,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (createdAt != null) 'created_at': createdAt,
      if (category != null) 'category': category,
      if (isPending != null) 'is_pending': isPending,
    });
  }

  LogEntriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? body,
      Value<DateTime>? createdAt,
      Value<String>? category,
      Value<bool>? isPending}) {
    return LogEntriesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
      isPending: isPending ?? this.isPending,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isPending.present) {
      map['is_pending'] = Variable<bool>(isPending.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogEntriesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('category: $category, ')
          ..write('isPending: $isPending')
          ..write(')'))
        .toString();
  }
}

class $PendingSyncTable extends PendingSync
    with TableInfo<$PendingSyncTable, PendingSyncData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingSyncTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _logEntryIdMeta =
      const VerificationMeta('logEntryId');
  @override
  late final GeneratedColumn<int> logEntryId = GeneratedColumn<int>(
      'log_entry_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES log_entries (id)'));
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _retryCountMeta =
      const VerificationMeta('retryCount');
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
      'retry_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastAttemptAtMeta =
      const VerificationMeta('lastAttemptAt');
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>('last_attempt_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _queuedAtMeta =
      const VerificationMeta('queuedAt');
  @override
  late final GeneratedColumn<DateTime> queuedAt = GeneratedColumn<DateTime>(
      'queued_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, logEntryId, operation, retryCount, lastAttemptAt, queuedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_sync';
  @override
  VerificationContext validateIntegrity(Insertable<PendingSyncData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('log_entry_id')) {
      context.handle(
          _logEntryIdMeta,
          logEntryId.isAcceptableOrUnknown(
              data['log_entry_id']!, _logEntryIdMeta));
    } else if (isInserting) {
      context.missing(_logEntryIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
          _retryCountMeta,
          retryCount.isAcceptableOrUnknown(
              data['retry_count']!, _retryCountMeta));
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
          _lastAttemptAtMeta,
          lastAttemptAt.isAcceptableOrUnknown(
              data['last_attempt_at']!, _lastAttemptAtMeta));
    }
    if (data.containsKey('queued_at')) {
      context.handle(_queuedAtMeta,
          queuedAt.isAcceptableOrUnknown(data['queued_at']!, _queuedAtMeta));
    } else if (isInserting) {
      context.missing(_queuedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PendingSyncData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingSyncData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      logEntryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}log_entry_id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      retryCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retry_count'])!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_attempt_at']),
      queuedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}queued_at'])!,
    );
  }

  @override
  $PendingSyncTable createAlias(String alias) {
    return $PendingSyncTable(attachedDatabase, alias);
  }
}

class PendingSyncData extends DataClass implements Insertable<PendingSyncData> {
  final int id;
  final int logEntryId;
  final String operation;
  final int retryCount;
  final DateTime? lastAttemptAt;
  final DateTime queuedAt;
  const PendingSyncData(
      {required this.id,
      required this.logEntryId,
      required this.operation,
      required this.retryCount,
      this.lastAttemptAt,
      required this.queuedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['log_entry_id'] = Variable<int>(logEntryId);
    map['operation'] = Variable<String>(operation);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    map['queued_at'] = Variable<DateTime>(queuedAt);
    return map;
  }

  PendingSyncCompanion toCompanion(bool nullToAbsent) {
    return PendingSyncCompanion(
      id: Value(id),
      logEntryId: Value(logEntryId),
      operation: Value(operation),
      retryCount: Value(retryCount),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      queuedAt: Value(queuedAt),
    );
  }

  factory PendingSyncData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingSyncData(
      id: serializer.fromJson<int>(json['id']),
      logEntryId: serializer.fromJson<int>(json['logEntryId']),
      operation: serializer.fromJson<String>(json['operation']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      queuedAt: serializer.fromJson<DateTime>(json['queuedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'logEntryId': serializer.toJson<int>(logEntryId),
      'operation': serializer.toJson<String>(operation),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'queuedAt': serializer.toJson<DateTime>(queuedAt),
    };
  }

  PendingSyncData copyWith(
          {int? id,
          int? logEntryId,
          String? operation,
          int? retryCount,
          Value<DateTime?> lastAttemptAt = const Value.absent(),
          DateTime? queuedAt}) =>
      PendingSyncData(
        id: id ?? this.id,
        logEntryId: logEntryId ?? this.logEntryId,
        operation: operation ?? this.operation,
        retryCount: retryCount ?? this.retryCount,
        lastAttemptAt:
            lastAttemptAt.present ? lastAttemptAt.value : this.lastAttemptAt,
        queuedAt: queuedAt ?? this.queuedAt,
      );
  PendingSyncData copyWithCompanion(PendingSyncCompanion data) {
    return PendingSyncData(
      id: data.id.present ? data.id.value : this.id,
      logEntryId:
          data.logEntryId.present ? data.logEntryId.value : this.logEntryId,
      operation: data.operation.present ? data.operation.value : this.operation,
      retryCount:
          data.retryCount.present ? data.retryCount.value : this.retryCount,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      queuedAt: data.queuedAt.present ? data.queuedAt.value : this.queuedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingSyncData(')
          ..write('id: $id, ')
          ..write('logEntryId: $logEntryId, ')
          ..write('operation: $operation, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('queuedAt: $queuedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, logEntryId, operation, retryCount, lastAttemptAt, queuedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingSyncData &&
          other.id == this.id &&
          other.logEntryId == this.logEntryId &&
          other.operation == this.operation &&
          other.retryCount == this.retryCount &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.queuedAt == this.queuedAt);
}

class PendingSyncCompanion extends UpdateCompanion<PendingSyncData> {
  final Value<int> id;
  final Value<int> logEntryId;
  final Value<String> operation;
  final Value<int> retryCount;
  final Value<DateTime?> lastAttemptAt;
  final Value<DateTime> queuedAt;
  const PendingSyncCompanion({
    this.id = const Value.absent(),
    this.logEntryId = const Value.absent(),
    this.operation = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.queuedAt = const Value.absent(),
  });
  PendingSyncCompanion.insert({
    this.id = const Value.absent(),
    required int logEntryId,
    required String operation,
    this.retryCount = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    required DateTime queuedAt,
  })  : logEntryId = Value(logEntryId),
        operation = Value(operation),
        queuedAt = Value(queuedAt);
  static Insertable<PendingSyncData> custom({
    Expression<int>? id,
    Expression<int>? logEntryId,
    Expression<String>? operation,
    Expression<int>? retryCount,
    Expression<DateTime>? lastAttemptAt,
    Expression<DateTime>? queuedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (logEntryId != null) 'log_entry_id': logEntryId,
      if (operation != null) 'operation': operation,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (queuedAt != null) 'queued_at': queuedAt,
    });
  }

  PendingSyncCompanion copyWith(
      {Value<int>? id,
      Value<int>? logEntryId,
      Value<String>? operation,
      Value<int>? retryCount,
      Value<DateTime?>? lastAttemptAt,
      Value<DateTime>? queuedAt}) {
    return PendingSyncCompanion(
      id: id ?? this.id,
      logEntryId: logEntryId ?? this.logEntryId,
      operation: operation ?? this.operation,
      retryCount: retryCount ?? this.retryCount,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      queuedAt: queuedAt ?? this.queuedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (logEntryId.present) {
      map['log_entry_id'] = Variable<int>(logEntryId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (queuedAt.present) {
      map['queued_at'] = Variable<DateTime>(queuedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingSyncCompanion(')
          ..write('id: $id, ')
          ..write('logEntryId: $logEntryId, ')
          ..write('operation: $operation, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('queuedAt: $queuedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LogEntriesTable logEntries = $LogEntriesTable(this);
  late final $PendingSyncTable pendingSync = $PendingSyncTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [logEntries, pendingSync];
}

typedef $$LogEntriesTableCreateCompanionBuilder = LogEntriesCompanion Function({
  Value<int> id,
  required String title,
  required String body,
  required DateTime createdAt,
  Value<String> category,
  Value<bool> isPending,
});
typedef $$LogEntriesTableUpdateCompanionBuilder = LogEntriesCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> body,
  Value<DateTime> createdAt,
  Value<String> category,
  Value<bool> isPending,
});

final class $$LogEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $LogEntriesTable, LogEntryRow> {
  $$LogEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PendingSyncTable, List<PendingSyncData>>
      _pendingSyncRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.pendingSync,
              aliasName: $_aliasNameGenerator(
                  db.logEntries.id, db.pendingSync.logEntryId));

  $$PendingSyncTableProcessedTableManager get pendingSyncRefs {
    final manager = $$PendingSyncTableTableManager($_db, $_db.pendingSync)
        .filter((f) => f.logEntryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pendingSyncRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LogEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPending => $composableBuilder(
      column: $table.isPending, builder: (column) => ColumnFilters(column));

  Expression<bool> pendingSyncRefs(
      Expression<bool> Function($$PendingSyncTableFilterComposer f) f) {
    final $$PendingSyncTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pendingSync,
        getReferencedColumn: (t) => t.logEntryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PendingSyncTableFilterComposer(
              $db: $db,
              $table: $db.pendingSync,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LogEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPending => $composableBuilder(
      column: $table.isPending, builder: (column) => ColumnOrderings(column));
}

class $$LogEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isPending =>
      $composableBuilder(column: $table.isPending, builder: (column) => column);

  Expression<T> pendingSyncRefs<T extends Object>(
      Expression<T> Function($$PendingSyncTableAnnotationComposer a) f) {
    final $$PendingSyncTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pendingSync,
        getReferencedColumn: (t) => t.logEntryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PendingSyncTableAnnotationComposer(
              $db: $db,
              $table: $db.pendingSync,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LogEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LogEntriesTable,
    LogEntryRow,
    $$LogEntriesTableFilterComposer,
    $$LogEntriesTableOrderingComposer,
    $$LogEntriesTableAnnotationComposer,
    $$LogEntriesTableCreateCompanionBuilder,
    $$LogEntriesTableUpdateCompanionBuilder,
    (LogEntryRow, $$LogEntriesTableReferences),
    LogEntryRow,
    PrefetchHooks Function({bool pendingSyncRefs})> {
  $$LogEntriesTableTableManager(_$AppDatabase db, $LogEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> body = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<bool> isPending = const Value.absent(),
          }) =>
              LogEntriesCompanion(
            id: id,
            title: title,
            body: body,
            createdAt: createdAt,
            category: category,
            isPending: isPending,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String body,
            required DateTime createdAt,
            Value<String> category = const Value.absent(),
            Value<bool> isPending = const Value.absent(),
          }) =>
              LogEntriesCompanion.insert(
            id: id,
            title: title,
            body: body,
            createdAt: createdAt,
            category: category,
            isPending: isPending,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LogEntriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({pendingSyncRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (pendingSyncRefs) db.pendingSync],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pendingSyncRefs)
                    await $_getPrefetchedData<LogEntryRow, $LogEntriesTable,
                            PendingSyncData>(
                        currentTable: table,
                        referencedTable: $$LogEntriesTableReferences
                            ._pendingSyncRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LogEntriesTableReferences(db, table, p0)
                                .pendingSyncRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.logEntryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LogEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LogEntriesTable,
    LogEntryRow,
    $$LogEntriesTableFilterComposer,
    $$LogEntriesTableOrderingComposer,
    $$LogEntriesTableAnnotationComposer,
    $$LogEntriesTableCreateCompanionBuilder,
    $$LogEntriesTableUpdateCompanionBuilder,
    (LogEntryRow, $$LogEntriesTableReferences),
    LogEntryRow,
    PrefetchHooks Function({bool pendingSyncRefs})>;
typedef $$PendingSyncTableCreateCompanionBuilder = PendingSyncCompanion
    Function({
  Value<int> id,
  required int logEntryId,
  required String operation,
  Value<int> retryCount,
  Value<DateTime?> lastAttemptAt,
  required DateTime queuedAt,
});
typedef $$PendingSyncTableUpdateCompanionBuilder = PendingSyncCompanion
    Function({
  Value<int> id,
  Value<int> logEntryId,
  Value<String> operation,
  Value<int> retryCount,
  Value<DateTime?> lastAttemptAt,
  Value<DateTime> queuedAt,
});

final class $$PendingSyncTableReferences
    extends BaseReferences<_$AppDatabase, $PendingSyncTable, PendingSyncData> {
  $$PendingSyncTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LogEntriesTable _logEntryIdTable(_$AppDatabase db) =>
      db.logEntries.createAlias(
          $_aliasNameGenerator(db.pendingSync.logEntryId, db.logEntries.id));

  $$LogEntriesTableProcessedTableManager get logEntryId {
    final $_column = $_itemColumn<int>('log_entry_id')!;

    final manager = $$LogEntriesTableTableManager($_db, $_db.logEntries)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_logEntryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PendingSyncTableFilterComposer
    extends Composer<_$AppDatabase, $PendingSyncTable> {
  $$PendingSyncTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get queuedAt => $composableBuilder(
      column: $table.queuedAt, builder: (column) => ColumnFilters(column));

  $$LogEntriesTableFilterComposer get logEntryId {
    final $$LogEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.logEntryId,
        referencedTable: $db.logEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LogEntriesTableFilterComposer(
              $db: $db,
              $table: $db.logEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PendingSyncTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingSyncTable> {
  $$PendingSyncTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get queuedAt => $composableBuilder(
      column: $table.queuedAt, builder: (column) => ColumnOrderings(column));

  $$LogEntriesTableOrderingComposer get logEntryId {
    final $$LogEntriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.logEntryId,
        referencedTable: $db.logEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LogEntriesTableOrderingComposer(
              $db: $db,
              $table: $db.logEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PendingSyncTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingSyncTable> {
  $$PendingSyncTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
      column: $table.lastAttemptAt, builder: (column) => column);

  GeneratedColumn<DateTime> get queuedAt =>
      $composableBuilder(column: $table.queuedAt, builder: (column) => column);

  $$LogEntriesTableAnnotationComposer get logEntryId {
    final $$LogEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.logEntryId,
        referencedTable: $db.logEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LogEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.logEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PendingSyncTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PendingSyncTable,
    PendingSyncData,
    $$PendingSyncTableFilterComposer,
    $$PendingSyncTableOrderingComposer,
    $$PendingSyncTableAnnotationComposer,
    $$PendingSyncTableCreateCompanionBuilder,
    $$PendingSyncTableUpdateCompanionBuilder,
    (PendingSyncData, $$PendingSyncTableReferences),
    PendingSyncData,
    PrefetchHooks Function({bool logEntryId})> {
  $$PendingSyncTableTableManager(_$AppDatabase db, $PendingSyncTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingSyncTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PendingSyncTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PendingSyncTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> logEntryId = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
            Value<DateTime> queuedAt = const Value.absent(),
          }) =>
              PendingSyncCompanion(
            id: id,
            logEntryId: logEntryId,
            operation: operation,
            retryCount: retryCount,
            lastAttemptAt: lastAttemptAt,
            queuedAt: queuedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int logEntryId,
            required String operation,
            Value<int> retryCount = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
            required DateTime queuedAt,
          }) =>
              PendingSyncCompanion.insert(
            id: id,
            logEntryId: logEntryId,
            operation: operation,
            retryCount: retryCount,
            lastAttemptAt: lastAttemptAt,
            queuedAt: queuedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PendingSyncTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({logEntryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (logEntryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.logEntryId,
                    referencedTable:
                        $$PendingSyncTableReferences._logEntryIdTable(db),
                    referencedColumn:
                        $$PendingSyncTableReferences._logEntryIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PendingSyncTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PendingSyncTable,
    PendingSyncData,
    $$PendingSyncTableFilterComposer,
    $$PendingSyncTableOrderingComposer,
    $$PendingSyncTableAnnotationComposer,
    $$PendingSyncTableCreateCompanionBuilder,
    $$PendingSyncTableUpdateCompanionBuilder,
    (PendingSyncData, $$PendingSyncTableReferences),
    PendingSyncData,
    PrefetchHooks Function({bool logEntryId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LogEntriesTableTableManager get logEntries =>
      $$LogEntriesTableTableManager(_db, _db.logEntries);
  $$PendingSyncTableTableManager get pendingSync =>
      $$PendingSyncTableTableManager(_db, _db.pendingSync);
}
