import 'dart:math';

import '../domain/failure.dart';
import '../domain/log_entry.dart';
import '../domain/logs_repository.dart';
import '../domain/result.dart';

/// In-memory fake of [LogsRepository] used for Week 6.
///
/// W6 change vs W5: instead of throwing exceptions on the 20% failure case,
/// the repository now RETURNS a `Failed<T>` carrying a typed [NetworkFailure].
/// No `throw` from this class. Errors are values now.
///
/// Different failure variants are simulated to demonstrate exhaustive pattern
/// matching at the call site:
///   - 20% NetworkFailure
///   - 5%  UnauthorizedFailure (simulates an expired token)
///   - rest succeed
class FakeLogsRepository implements LogsRepository {
  FakeLogsRepository();

  final List<LogEntry> _entries = [];
  final Random _random = Random();
  int _nextId = 1;

  @override
  Future<Result<List<LogEntry>>> fetchAll() async {
    await Future.delayed(const Duration(seconds: 1));
    final roll = _random.nextInt(100);
    if (roll < 20) {
      return const Failed(NetworkFailure());
    }
    if (roll < 25) {
      return const Failed(UnauthorizedFailure());
    }
    return Success(List.unmodifiable(_entries.reversed));
  }

  @override
  Future<Result<LogEntry>> add({
    required String title,
    required String body,
    required String category,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (title.trim().isEmpty) {
      return const Failed(UnknownFailure(message: 'Title cannot be empty.'));
    }
    final entry = LogEntry(
      id: _nextId++,
      title: title,
      body: body,
      createdAt: DateTime.now(),
      category: category,
    );
    _entries.add(entry);
    return Success(entry);
  }
}
