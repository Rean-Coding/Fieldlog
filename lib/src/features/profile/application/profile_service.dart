import '../domain/profile.dart';
import '../domain/profile_repository.dart';

/// The Profile Service — the application-layer building block for this feature.
///
/// Six rules of a Service (from Week 3):
///   S1 One per feature
///   S2 Stateless (no instance fields holding UI state)
///   S3 Returns domain types
///   S4 Depends on abstractions only (note `final ProfileRepository`, not the concrete)
///   S5 No Flutter import in this file
///   S6 Orchestrates, doesn't render
///
/// A Service exposes DOMAIN OPERATIONS, not CRUD. We say `enrol`, not `insert`.
class ProfileService {
  const ProfileService(this._repository);

  final ProfileRepository _repository;

  /// Find an existing profile by id, or null.
  Future<Profile?> find(String id) => _repository.load(id);

  /// Create-or-update the user's profile.
  /// (Single domain operation — the Repository is a storage detail.)
  Future<Profile> enrol({
    required String id,
    required String name,
    String role = 'Member',
  }) async {
    final profile = Profile(id: id, name: name, role: role);
    await _repository.save(profile);
    return profile;
  }
}
