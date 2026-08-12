import 'log_entry.dart';

/// Abstract data-source contract for log entries.
///
/// The Service depends on this — never on a concrete implementation. In Week 7
/// we swap [FakeLogsRepository] for `DriftLogsRepository` and nothing in the
/// service or notifier changes. That's Rule S4 (depend on abstractions) paying
/// off.
abstract class LogsRepository {
  /// Returns all log entries, newest first.
  ///
  /// May fail with an exception in Week 5 (we are still throwing).
  /// In Week 6 this becomes `Future<Result<List<LogEntry>>>`.
  Future<List<LogEntry>> fetchAll();

  /// Persists a new log entry.
  Future<LogEntry> add({
    required String title,
    required String body,
    required String category,
  });
}
