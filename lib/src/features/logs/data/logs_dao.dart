import 'package:drift/drift.dart';

import '../../../data/app_database.dart';

part 'logs_dao.g.dart';

// Week 9: DAO gains an offline-first insert that writes to LogEntries AND
// enqueues a PendingSync row in the same transaction. Either both succeed or
// neither does.

@DriftAccessor(tables: [LogEntries, PendingSync])
class LogsDao extends DatabaseAccessor<AppDatabase> with _$LogsDaoMixin {
  LogsDao(super.db);

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

  /// Week 9 offline-first insert: write locally + enqueue for sync.
  /// Both writes happen in one Drift transaction.
  Future<int> insertWithPendingSync({
    required String title,
    required String body,
    required String category,
  }) async {
    return transaction(() async {
      final id = await into(logEntries).insert(
        LogEntriesCompanion.insert(
          title: title,
          body: body,
          createdAt: DateTime.now(),
          category: Value(category),
          isPending: const Value(true),
        ),
      );
      await into(pendingSync).insert(
        PendingSyncCompanion.insert(
          logEntryId: id,
          operation: 'create',
          queuedAt: DateTime.now(),
        ),
      );
      return id;
    });
  }
}
