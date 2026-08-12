import 'package:drift/drift.dart';
import '../../../data/app_database.dart';
import 'package:sqlite3/common.dart';

import '../domain/failure.dart';
import '../domain/log_entry.dart';
import '../domain/logs_repository.dart';
import '../domain/result.dart';
import 'logs_dao.dart';

/// Drift-backed Repository with offline-first writes.
///
/// W9 change: `add()` calls `insertWithPendingSync()` — the entry is visible
/// immediately AND a row is queued for the sync engine. The user does not
/// wait for network.
class DriftLogsRepository implements LogsRepository {
  DriftLogsRepository(this._dao);

  final LogsDao _dao;

  @override
  Future<Result<List<LogEntry>>> fetchAll() async {
    try {
      final rows = await _dao.fetchAll();
      return Success(rows.map(_toDomain).toList(growable: false));
    } on SqliteException catch (e) {
      return Failed(UnknownFailure(message: e.message));
    } catch (_) {
      return const Failed(UnknownFailure());
    }
  }

  @override
  Future<Result<LogEntry>> add({
    required String title,
    required String body,
    required String category,
  }) async {
    try {
      final id = await _dao.insertWithPendingSync(
        title: title,
        body: body,
        category: category,
      );
      // Optimistic — return the entry immediately with isPending = true.
      return Success(LogEntry(
        id: id,
        title: title,
        body: body,
        createdAt: DateTime.now(),
        category: category,
        isPending: true,
      ));
    } on SqliteException catch (e) {
      return Failed(UnknownFailure(message: e.message));
    } catch (_) {
      return const Failed(UnknownFailure());
    }
  }

  LogEntry _toDomain(LogEntryRow row) => LogEntry(
        id: row.id,
        title: row.title,
        body: row.body,
        createdAt: row.createdAt,
        category: row.category,
        isPending: row.isPending,
      );
}
