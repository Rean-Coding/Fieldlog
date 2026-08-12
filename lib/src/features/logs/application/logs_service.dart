import '../domain/log_entry.dart';
import '../domain/logs_repository.dart';

/// Application-layer service for the logs feature.
///
/// Six rules of a Service (from Week 3):
///   S1 — one per feature                       ✓ LogsService
///   S2 — stateless (no instance fields holding UI state)  ✓
///   S3 — returns domain types                  ✓ List<LogEntry>
///   S4 — depends on abstractions               ✓ LogsRepository (abstract)
///   S5 — no Flutter import                     ✓ Pure Dart
///   S6 — orchestrates, doesn't render          ✓ No widgets here
///
/// Note: this Service does NOT know about `AsyncValue`. AsyncValue is a
/// presentation/Notifier concept — wrapping the eventual result in
/// loading/data/error states. The Service just returns plain Dart values and
/// throws on failure (until Week 6 when we move to Result types).
class LogsService {
  const LogsService(this._repository);

  final LogsRepository _repository;

  /// Loads the user's logs, newest first.
  Future<List<LogEntry>> loadAll() => _repository.fetchAll();

  /// Records a new log entry. The domain operation — not "insert".
  Future<LogEntry> recordToday({
    required String title,
    required String body,
    String category = 'general',
  }) {
    return _repository.add(title: title, body: body, category: category);
  }
}
