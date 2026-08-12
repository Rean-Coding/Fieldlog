import '../domain/failure.dart';
import '../domain/log_entry.dart';
import '../domain/logs_repository.dart';
import '../domain/result.dart';

/// Application-layer service for the logs feature — Week 6 version.
///
/// W6 change vs W5: signatures now return `Future<Result<T>>`. The Service
/// passes failures up the chain unchanged. Failures are first-class values,
/// not invisible exceptions.
///
/// The Six Rules of a Service (W3) still all apply:
///   S1 ✓ one per feature
///   S2 ✓ stateless
///   S3 ✓ returns domain types (Result<List<LogEntry>>)
///   S4 ✓ depends on abstractions
///   S5 ✓ no Flutter import
///   S6 ✓ orchestrates, doesn't render
class LogsService {
  const LogsService(this._repository);

  final LogsRepository _repository;

  /// Loads the user's logs, newest first.
  Future<Result<List<LogEntry>>> loadAll() => _repository.fetchAll();

  /// Records a new log entry. Validation is the Service's responsibility —
  /// not the Repository's. A blank title returns a domain failure.
  Future<Result<LogEntry>> recordToday({
    required String title,
    required String body,
    String category = 'general',
  }) async {
    if (title.trim().isEmpty) {
      return const Failed(UnknownFailure(message: 'Title cannot be blank.'));
    }
    return _repository.add(title: title, body: body, category: category);
  }
}
