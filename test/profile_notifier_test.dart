import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fieldlog_flutter/src/features/profile/application/profile_providers.dart';
import 'package:fieldlog_flutter/src/features/profile/data/fake_profile_repository.dart';
import 'package:fieldlog_flutter/src/features/profile/domain/profile.dart';
import 'package:fieldlog_flutter/src/features/profile/domain/profile_repository.dart';

/// A test-only fake repository that lets us assert what was saved.
class _RecordingRepository implements ProfileRepository {
  Profile? saved;

  @override
  Future<Profile?> load(String id) async => saved?.id == id ? saved : null;

  @override
  Future<void> save(Profile profile) async => saved = profile;
}

void main() {
  group('ProfileNotifier (Week 4 — Riverpod DI)', () {
    test('initially has no profile', () {
      final container = ProviderContainer(overrides: [
        profileRepositoryProvider.overrideWithValue(FakeProfileRepository()),
      ]);
      addTearDown(container.dispose);

      expect(container.read(profileNotifierProvider), isNull);
    });

    test('enrol() persists via repository and updates state', () async {
      final recordingRepo = _RecordingRepository();
      final container = ProviderContainer(overrides: [
        profileRepositoryProvider.overrideWithValue(recordingRepo),
      ]);
      addTearDown(container.dispose);

      await container
          .read(profileNotifierProvider.notifier)
          .enrol(id: 'metrey', name: 'Metrey');

      // State updated
      final state = container.read(profileNotifierProvider);
      expect(state, isNotNull);
      expect(state!.id, 'metrey');
      expect(state.name, 'Metrey');
      expect(state.role, 'Member');

      // Repository received the save
      expect(recordingRepo.saved, isNotNull);
      expect(recordingRepo.saved!.id, 'metrey');
    });
  });
}
