import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// ─────────────────────────────────────────────────────────────
// Week 9: Schema v2 — adds the pending_sync table.
//
// Offline-first writes go to LogEntries (immediately visible to the user)
// and a row is added to PendingSync (the queue for the sync engine).
// When connectivity returns, SyncService drains the queue.
// ─────────────────────────────────────────────────────────────

// The generated row class is named explicitly so it cannot be
// confused with the domain entity of the same name. A row is what
// the database stores; LogEntry is what the app reasons about.
@DataClassName('LogEntryRow')
class LogEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get body => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get category => text().withDefault(const Constant('general'))();
  // W9: a write is pending until the sync engine confirms it.
  BoolColumn get isPending => boolean().withDefault(const Constant(true))();
}

class PendingSync extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get logEntryId => integer().references(LogEntries, #id)();
  // What kind of operation is queued: 'create', 'update', 'delete'.
  TextColumn get operation => text()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
  DateTimeColumn get queuedAt => dateTime()();
}

@DriftDatabase(tables: [LogEntries, PendingSync])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            // W8 → W9 migration: add isPending column + create PendingSync.
            await m.addColumn(logEntries, logEntries.isPending);
            await m.createTable(pendingSync);
          }
        },
      );
}

QueryExecutor _openConnection() => driftDatabase(name: 'fieldlog_db');
