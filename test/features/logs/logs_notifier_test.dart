import 'package:fieldlog_flutter/src/features/logs/application/logs_providers.dart';
import 'package:fieldlog_flutter/src/features/logs/application/logs_service.dart';
import 'package:fieldlog_flutter/src/features/logs/domain/failure.dart';
import 'package:fieldlog_flutter/src/features/logs/domain/log_entry.dart';
import 'package:fieldlog_flutter/src/features/logs/domain/logs_repository.dart';
import 'package:fieldlog_flutter/src/features/logs/domain/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FakeLogsRepository implements LogsRepository {
  FakeLogsRepository(this._result);
  final Result<List<LogEntry>> _result;

  @override
  Future<Result<List<LogEntry>>> fetchAll() async => _result;

  @override
  Future<Result<LogEntry>> add({
    required String title,
    required String body,
    required String category,
  }) async =>
      Success(LogEntry(
        id: 99,
        title: title,
        body: body,
        createdAt: DateTime(2026, 1, 1),
        category: category,
      ));
}

void main() {
  test('LogsNotifier exposes AsyncData when the service returns Success',
      () async {
    final container = ProviderContainer(
      overrides: [
        logsRepositoryProvider.overrideWith(
          (ref) => FakeLogsRepository(Success([
            LogEntry(
              id: 1,
              title: 't',
              body: 'b',
              createdAt: DateTime(2026, 1, 1),
              category: 'general',
            ),
          ])),
        ),
      ],
    );
    addTearDown(container.dispose);

    final result = await container.read(logsNotifierProvider.future);
    expect(result, hasLength(1));
    expect(result.first.title, 't');
  });

  test('LogsNotifier exposes AsyncError when the service returns Failed',
      () async {
    final container = ProviderContainer(
      overrides: [
        logsRepositoryProvider.overrideWith(
          (ref) => FakeLogsRepository(const Failed(NetworkFailure())),
        ),
      ],
    );
    addTearDown(container.dispose);

    await expectLater(
      container.read(logsNotifierProvider.future),
      throwsA(isA<NetworkFailure>()),
    );
  });
}
