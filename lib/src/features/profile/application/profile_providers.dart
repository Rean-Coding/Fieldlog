import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/fake_profile_repository.dart';
import '../domain/profile.dart';
import '../domain/profile_repository.dart';
import 'profile_service.dart';

part 'profile_providers.g.dart';

// ─────────────────────────────────────────────────────────────
// Week 4: Riverpod-managed dependency injection.
//
// Every dependency in the application layer is exposed as a provider.
// In tests we override the providers; in production they return the real
// implementations. The widget never constructs a service or repository.
// ─────────────────────────────────────────────────────────────

/// The Repository — for now a fake. In W7 this returns a DriftProfileRepository
/// (and nothing else in the app changes).
@Riverpod(keepAlive: true)
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  return FakeProfileRepository();
}

/// The Service. Depends on the abstract Repository — never on the concrete.
@Riverpod(keepAlive: true)
ProfileService profileService(ProfileServiceRef ref) {
  return ProfileService(ref.watch(profileRepositoryProvider));
}

/// Notifier — the application-layer holder of UI state for the profile feature.
/// `Notifier` returns the *current* state synchronously; AsyncNotifier (W5)
/// handles loading/error/data states.
///
/// This notifier exposes the user's enrolment result. It calls into the
/// Service for actual work — the Notifier does no business logic.
@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  Profile? build() => null;

  Future<void> enrol({required String id, required String name}) async {
    final service = ref.read(profileServiceProvider);
    final profile = await service.enrol(id: id, name: name);
    state = profile;
  }
}
