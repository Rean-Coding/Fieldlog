import 'package:drift/drift.dart';

import '../../../data/app_database.dart';

part 'logs_dao.g.dart';

// ─────────────────────────────────────────────────────────────
// Week 7: The Data Access Object for log entries.
//
// The DAO completes the data-layer chain:
//   Widget → Notifier → Service → Repository (abstract) → DAO → SQLite
//
// Why DAO + Repository instead of just Repository:
//   - The Repository is the abstract contract the Service depends on.
//   - The DAO is the concrete SQL layer. Drift generates much of it.
//   - Keeping them separate means the Repository can use multiple DAOs
//     in W9 when we add a SyncEngine + pending_sync table.
// ─────────────────────────────────────────────────────────────

@DriftAccessor(tables: [LogEntries])
class LogsDao extends DatabaseAccessor<AppDatabase> with _$LogsDaoMixin {
  LogsDao(super.db);

  /// Streaming query — the UI subscribes via Riverpod's StreamProvider and
  /// updates automatically on every insert / update / delete.
  Stream<List<LogEntryRow>> watchAll() {
    return (select(logEntries)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  Future<List<LogEntryRow>> fetchAll() {
    return (select(logEntries)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<int> insert({
    required String title,
    required String body,
    required String category,
  }) {
    return into(logEntries).insert(
      LogEntriesCompanion.insert(
        title: title,
        body: body,
        createdAt: DateTime.now(),
        category: Value(category),
      ),
    );
  }

  Future<int> deleteById(int id) {
    return (delete(logEntries)..where((t) => t.id.equals(id))).go();
  }
}
