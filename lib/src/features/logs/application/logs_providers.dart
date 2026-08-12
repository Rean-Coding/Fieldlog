import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/app_database.dart';
import '../data/drift_logs_repository.dart';
import '../data/logs_dao.dart';
import '../domain/failure.dart';
import '../domain/log_entry.dart';
import '../domain/logs_repository.dart';
import '../domain/result.dart';
import 'logs_service.dart';

part 'logs_providers.g.dart';

// ─────────────────────────────────────────────────────────────
// Week 7: The Service / Notifier code did not change vs Week 6.
// Only the Repository provider returns a Drift-backed implementation now.
//
// This is Rule S4 (depend on abstractions) earning its keep:
//   - Service ✓ unchanged
//   - Notifier ✓ unchanged
//   - UI ✓ unchanged
//   - One line of provider wiring → real persistence end to end.
// ─────────────────────────────────────────────────────────────

@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}

@Riverpod(keepAlive: true)
LogsDao logsDao(LogsDaoRef ref) {
  return LogsDao(ref.watch(appDatabaseProvider));
}

@Riverpod(keepAlive: true)
LogsRepository logsRepository(LogsRepositoryRef ref) {
  return DriftLogsRepository(ref.watch(logsDaoProvider));
}

@Riverpod(keepAlive: true)
LogsService logsService(LogsServiceRef ref) {
  return LogsService(ref.watch(logsRepositoryProvider));
}

@riverpod
class LogsNotifier extends _$LogsNotifier {
  @override
  Future<List<LogEntry>> build() async {
    final service = ref.read(logsServiceProvider);
    final result = await service.loadAll();
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
    final service = ref.read(logsServiceProvider);
    final result = await service.recordToday(
      title: title,
      body: body,
      category: category,
    );
    if (result is Failed<LogEntry>) {
      state = AsyncError(result.failure, StackTrace.current);
      return;
    }
    ref.invalidateSelf();
  }
}
