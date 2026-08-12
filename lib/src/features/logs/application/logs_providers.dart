import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/fake_logs_repository.dart';
import '../domain/failure.dart';
import '../domain/log_entry.dart';
import '../domain/logs_repository.dart';
import '../domain/result.dart';
import 'logs_service.dart';

part 'logs_providers.g.dart';

// ─────────────────────────────────────────────────────────────
// Week 6: The Notifier unpacks Result<T> into AsyncData / AsyncError.
//
// The Service now returns Result<T>. The Notifier converts:
//   Success<T>  → AsyncData<T>
//   Failed<T>   → AsyncError carrying the Failure
//
// The UI never sees Result. It still pattern-matches on AsyncValue.
// ─────────────────────────────────────────────────────────────

@Riverpod(keepAlive: true)
LogsRepository logsRepository(LogsRepositoryRef ref) {
  return FakeLogsRepository();
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
      // Surface the failure to the UI via AsyncError.
      state = AsyncError(result.failure, StackTrace.current);
      return;
    }
    ref.invalidateSelf();
  }
}
