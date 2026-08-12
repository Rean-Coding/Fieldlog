import 'package:drift/drift.dart';
import '../../../data/app_database.dart';
import 'package:sqlite3/common.dart';

import '../domain/failure.dart';
import '../domain/log_entry.dart';
import '../domain/logs_repository.dart';
import '../domain/result.dart';
import 'logs_dao.dart';

/// Real (Drift-backed) implementation of [LogsRepository].
///
/// Week 7 swap: replaces [FakeLogsRepository] in production. The Service,
/// Notifier, and UI do not change — that is Rule S4 (depend on abstractions)
/// paying off again.
///
/// This is also where the Failure mapping lives — SQL exceptions get
/// translated to domain `Failure` variants at this boundary. The Service
/// never sees a `SqliteException`.
class DriftLogsRepository implements LogsRepository {
  DriftLogsRepository(this._dao);

  final LogsDao _dao;

  @override
  Future<Result<List<LogEntry>>> fetchAll() async {
    try {
      final rows = await _dao.fetchAll();
      return Success(rows.map(_toDomain).toList(growable: false));
    } on SqliteException catch (e) {
      return Failed(_mapSqliteException(e));
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
      final id = await _dao.insert(
        title: title,
        body: body,
        category: category,
      );
      return Success(LogEntry(
        id: id,
        title: title,
        body: body,
        createdAt: DateTime.now(),
        category: category,
      ));
    } on SqliteException catch (e) {
      return Failed(_mapSqliteException(e));
    } catch (_) {
      return const Failed(UnknownFailure());
    }
  }

  /// Maps a Drift row to our domain entity. This keeps `LogEntry` free of
  /// Drift annotations — the domain layer has no idea SQLite exists.
  LogEntry _toDomain(LogEntryRow row) {
    return LogEntry(
      id: row.id,
      title: row.title,
      body: row.body,
      createdAt: row.createdAt,
      category: row.category,
    );
  }

  /// SqliteException → Failure. Specific codes get specific variants.
  Failure _mapSqliteException(SqliteException e) {
    // Code 19 is SQLITE_CONSTRAINT
    if (e.extendedResultCode >= 2067 && e.extendedResultCode <= 2099) {
      return UnknownFailure(message: 'Database constraint: ${e.message}');
    }
    return UnknownFailure(message: e.message);
  }
}
