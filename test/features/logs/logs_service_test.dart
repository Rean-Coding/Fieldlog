import 'package:fieldlog_flutter/src/features/logs/application/logs_service.dart';
import 'package:fieldlog_flutter/src/features/logs/domain/failure.dart';
import 'package:fieldlog_flutter/src/features/logs/domain/log_entry.dart';
import 'package:fieldlog_flutter/src/features/logs/domain/logs_repository.dart';
import 'package:fieldlog_flutter/src/features/logs/domain/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLogsRepository extends Mock implements LogsRepository {}

void main() {
  late MockLogsRepository repo;
  late LogsService service;

  setUp(() {
    repo = MockLogsRepository();
    service = LogsService(repo);
  });

  group('LogsService.loadAll', () {
    test('returns Success when the repo returns Success', () async {
      final entries = [
        LogEntry(
          id: 1,
          title: 't',
          body: 'b',
          createdAt: DateTime(2026, 1, 1),
          category: 'general',
        ),
      ];
      when(() => repo.fetchAll()).thenAnswer((_) async => Success(entries));

      final result = await service.loadAll();

      expect(result, isA<Success<List<LogEntry>>>());
      expect((result as Success<List<LogEntry>>).value, entries);
    });

    test('returns Failed when the repo returns Failed', () async {
      when(() => repo.fetchAll())
          .thenAnswer((_) async => const Failed(NetworkFailure()));

      final result = await service.loadAll();

      expect(result, isA<Failed<List<LogEntry>>>());
      final f = (result as Failed<List<LogEntry>>).failure;
      expect(f, isA<NetworkFailure>());
    });
  });

  group('LogsService.recordToday', () {
    test('rejects blank titles WITHOUT touching the repository', () async {
      final result = await service.recordToday(title: '   ', body: 'b');

      expect(result, isA<Failed<LogEntry>>());
      verifyNever(() => repo.add(
            title: any(named: 'title'),
            body: any(named: 'body'),
            category: any(named: 'category'),
          ));
    });
  });
}
