import 'dart:math';

import '../domain/log_entry.dart';
import '../domain/logs_repository.dart';

/// In-memory fake of [LogsRepository] used for Week 5.
///
/// Simulates real-world conditions:
/// - 1-second network latency on every operation
/// - 20% random failure rate on [fetchAll] so students see the error state
///
/// In Week 7 this is replaced by `DriftLogsRepository` (real local database).
class FakeLogsRepository implements LogsRepository {
  FakeLogsRepository();

  final List<LogEntry> _entries = [];
  final Random _random = Random();
  int _nextId = 1;

  @override
  Future<List<LogEntry>> fetchAll() async {
    await Future.delayed(const Duration(seconds: 1));
    // 20% failure rate — surfaces the error state in the UI
    if (_random.nextInt(5) == 0) {
      throw Exception('Network unavailable. Please try again.');
    }
    return List.unmodifiable(_entries.reversed);
  }

  @override
  Future<LogEntry> add({
    required String title,
    required String body,
    required String category,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final entry = LogEntry(
      id: _nextId++,
      title: title,
      body: body,
      createdAt: DateTime.now(),
      category: category,
    );
    _entries.add(entry);
    return entry;
  }
}
