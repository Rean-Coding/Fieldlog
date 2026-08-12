import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/fake_logs_repository.dart';
import '../domain/log_entry.dart';
import '../domain/logs_repository.dart';
import 'logs_service.dart';

part 'logs_providers.g.dart';

// ─────────────────────────────────────────────────────────────
// Week 5: AsyncNotifier — handling loading, data, error, and empty.
//
// The chain is identical to Week 4: Widget → Notifier → Service → Repository.
// The only new piece is that the Notifier returns an AsyncValue<T> instead of
// a synchronous T, because the Service call is asynchronous and may fail.
// ─────────────────────────────────────────────────────────────

/// The Repository — fake in W5, will become DriftLogsRepository in W7.
@Riverpod(keepAlive: true)
LogsRepository logsRepository(LogsRepositoryRef ref) {
  return FakeLogsRepository();
}

/// The Service — depends on the abstract Repository.
@Riverpod(keepAlive: true)
LogsService logsService(LogsServiceRef ref) {
  return LogsService(ref.watch(logsRepositoryProvider));
}

/// AsyncNotifier exposing the user's logs.
///
/// The `build` method returns `Future<List<LogEntry>>`. Riverpod wraps this in
/// `AsyncValue<List<LogEntry>>` for us — the UI uses `.when(...)` to render
/// the four states:
///   - AsyncLoading  → skeleton
///   - AsyncData     → list (or empty state if list.isEmpty)
///   - AsyncError    → error UI with retry
///
/// Pull-to-refresh is implemented via `ref.refresh(logsNotifierProvider)`.
@riverpod
class LogsNotifier extends _$LogsNotifier {
  @override
  Future<List<LogEntry>> build() async {
    final service = ref.read(logsServiceProvider);
    return service.loadAll();
  }

  /// Add a new entry, then refetch.
  ///
  /// Note: in W9 we replace this with offline-first behavior (write to local
  /// DB first, sync in the background). For now, a simple round-trip.
  Future<void> addEntry({
    required String title,
    required String body,
    String category = 'general',
  }) async {
    final service = ref.read(logsServiceProvider);
    await service.recordToday(title: title, body: body, category: category);
    // Trigger a rebuild so the list refreshes.
    ref.invalidateSelf();
  }
}
