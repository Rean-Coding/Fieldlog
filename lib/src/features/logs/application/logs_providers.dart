import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/app_database.dart';
import '../../../sync/sync_service.dart';
import '../data/drift_logs_repository.dart';
import '../data/logs_dao.dart';
import '../domain/failure.dart';
import '../domain/log_entry.dart';
import '../domain/logs_repository.dart';
import '../domain/result.dart';
import 'logs_service.dart';

part 'logs_providers.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}

@Riverpod(keepAlive: true)
LogsDao logsDao(LogsDaoRef ref) => LogsDao(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
LogsRepository logsRepository(LogsRepositoryRef ref) =>
    DriftLogsRepository(ref.watch(logsDaoProvider));

@Riverpod(keepAlive: true)
LogsService logsService(LogsServiceRef ref) =>
    LogsService(ref.watch(logsRepositoryProvider));

/// W9: the SyncService is a long-lived Service. KeepAlive ensures it lives
/// for the lifetime of the app — the documented S2 exception.
@Riverpod(keepAlive: true)
SyncService syncService(SyncServiceRef ref) =>
    SyncService(ref.watch(appDatabaseProvider));

@riverpod
class LogsNotifier extends _$LogsNotifier {
  @override
  Future<List<LogEntry>> build() async {
    final result = await ref.read(logsServiceProvider).loadAll();
    return switch (result) {
      Success<List<LogEntry>>(:final value) => value,
      Failed<List<LogEntry>>(:final failure) => throw failure,
    };
  }

  Future<void> addEntry({
    required String title,
    required String body,
    String category = 'general',
  }) async {
    final result = await ref.read(logsServiceProvider).recordToday(
          title: title,
          body: body,
          category: category,
        );
    if (result is Failed<LogEntry>) {
      state = AsyncError(result.failure, StackTrace.current);
      return;
    }
    ref.invalidateSelf();
    // Fire-and-forget: try syncing in the background.
    // ignore: unawaited_futures
    ref.read(syncServiceProvider).triggerSync().then((_) {
      ref.invalidateSelf();
    });
  }

  /// Manual "drain queue" trigger from the UI (e.g. a sync button).
  Future<void> sync() async {
    await ref.read(syncServiceProvider).triggerSync();
    ref.invalidateSelf();
  }
}
