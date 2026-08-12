import 'failure.dart';
import 'log_entry.dart';
import 'result.dart';

/// Abstract data-source contract for log entries.
///
/// Week 6 change: methods return `Future<Result<T>>` instead of `Future<T>`.
/// Failures are now first-class values flowing up the call chain.
///
/// In Week 7 we swap [FakeLogsRepository] for `DriftLogsRepository` and the
/// Service / Notifier / UI does not change.
abstract class LogsRepository {
  /// Returns all log entries, newest first.
  Future<Result<List<LogEntry>>> fetchAll();

  /// Persists a new log entry.
  Future<Result<LogEntry>> add({
    required String title,
    required String body,
    required String category,
  });
}
