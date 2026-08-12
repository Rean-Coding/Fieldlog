import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// ─────────────────────────────────────────────────────────────
// Week 7: The application's local SQLite database, managed by Drift.
//
// Why Drift over sqflite:
//   - Type-safe SQL: queries are checked at build time, not runtime.
//   - Reactive streams: watch() lets the UI subscribe to a query and
//     update automatically when the underlying data changes.
//   - Migrations are first-class via MigrationStrategy.
//
// schemaVersion = 1. Every change to a table from now on bumps this number
// and adds an onUpgrade step. Migrations get committed to git — never
// invented at runtime.
// ─────────────────────────────────────────────────────────────

/// Table for FieldLog entries.
///
/// Drift derives the row class (`LogEntryRow`) and a typed query API
/// from this declaration during code generation. The Dart class shape MUST
/// stay decoupled from this: see `LogEntry` in the logs feature's domain
/// folder. We map between the two at the data-layer boundary.
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
}

@DriftDatabase(tables: [LogEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // No migrations yet. When the schema changes, add an
          // `if (from < N)` block here that brings older databases up.
        },
      );
}

QueryExecutor _openConnection() {
  // drift_flutter handles platform-specific paths and native loading.
  return driftDatabase(name: 'fieldlog_db');
}
