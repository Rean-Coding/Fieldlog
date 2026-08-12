import '../domain/profile.dart';
import '../domain/profile_repository.dart';

/// Week 3 fake: keeps a single profile in memory.
/// In Week 7 this gets replaced by a Drift-backed implementation, and the
/// rest of the code (Service, Notifier, screens) won't change a line.
class FakeProfileRepository implements ProfileRepository {
  Profile? _stored;

  @override
  Future<Profile?> load(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return _stored?.id == id ? _stored : null;
  }

  @override
  Future<void> save(Profile profile) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _stored = profile;
  }
}
