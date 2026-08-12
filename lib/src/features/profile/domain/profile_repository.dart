import 'profile.dart';

/// The Profile data contract.
///
/// Lives in `domain/` because the Service depends on this abstraction —
/// never on a concrete implementation. Implementations live in `data/`.
abstract class ProfileRepository {
  Future<Profile?> load(String id);
  Future<void> save(Profile profile);
}
