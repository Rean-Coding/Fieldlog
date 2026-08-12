import 'package:fieldlog_flutter/src/features/logs/application/logs_providers.dart';
import 'package:fieldlog_flutter/src/features/logs/domain/failure.dart';
import 'package:fieldlog_flutter/src/features/logs/domain/log_entry.dart';
import 'package:fieldlog_flutter/src/features/logs/domain/logs_repository.dart';
import 'package:fieldlog_flutter/src/features/logs/domain/result.dart';
import 'package:fieldlog_flutter/src/features/logs/presentation/logs_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _RepoData implements LogsRepository {
  _RepoData(this.entries);
  final List<LogEntry> entries;
  @override
  Future<Result<List<LogEntry>>> fetchAll() async => Success(entries);
  @override
  Future<Result<LogEntry>> add({required title, required body, required category}) async =>
      Success(LogEntry(id: 1, title: title, body: body, createdAt: DateTime(2026), category: category));
}

class _RepoError implements LogsRepository {
  @override
  Future<Result<List<LogEntry>>> fetchAll() async => const Failed(NetworkFailure());
  @override
  Future<Result<LogEntry>> add({required title, required body, required category}) async =>
      const Failed(UnknownFailure());
}

Widget _withRepo(LogsRepository repo) {
  return ProviderScope(
    overrides: [logsRepositoryProvider.overrideWith((ref) => repo)],
    child: const MaterialApp(home: LogsListScreen()),
  );
}

void main() {
  testWidgets('renders the EMPTY state when the repo returns no entries',
      (tester) async {
    await tester.pumpWidget(_withRepo(_RepoData(const [])));
    await tester.pump(); // resolve the AsyncNotifier future
    expect(find.text('No logs yet'), findsOneWidget);
  });

  testWidgets('renders the ERROR state when the repo returns NetworkFailure',
      (tester) async {
    await tester.pumpWidget(_withRepo(_RepoError()));
    await tester.pump();
    expect(find.text('Network unavailable'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('renders the DATA state when the repo returns entries',
      (tester) async {
    await tester.pumpWidget(_withRepo(_RepoData([
      LogEntry(
        id: 1,
        title: 'A test entry',
        body: 'body',
        createdAt: DateTime(2026, 1, 1),
        category: 'general',
      ),
    ])));
    await tester.pump();
    expect(find.text('A test entry'), findsOneWidget);
  });
}
