import '../../logs/domain/failure.dart';
import '../../logs/domain/result.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_tokens.dart';

/// AuthService — the documented S2 exception.
///
/// AuthService is long-lived and stateful: it holds the current AuthTokens
/// (when signed in) so the interceptor can read them synchronously on every
/// outgoing request.
///
/// All other Service rules still apply:
///   S1 ✓ one per feature (auth)
///   S3 ✓ returns domain types
///   S4 ✓ depends on the abstract AuthRepository
///   S5 ✓ no Flutter import
///   S6 ✓ orchestrates, doesn't render
class AuthService {
  AuthService(this._repository);

  final AuthRepository _repository;
  AuthTokens? _current;

  AuthTokens? get current => _current;
  bool get isSignedIn => _current != null;

  /// Loads tokens from secure storage at app startup.
  Future<void> restore() async {
    _current = await _repository.loadStoredTokens();
  }

  Future<Result<void>> signIn({
    required String email,
    required String password,
  }) async {
    final r = await _repository.signIn(email: email, password: password);
    return switch (r) {
      Success<AuthTokens>(:final value) => () {
          _current = value;
          return const Success<void>(null);
        }(),
      Failed<AuthTokens>(:final failure) => Failed<void>(failure),
    };
  }

  /// Called by the auth interceptor when a 401 indicates the access token
  /// has expired. Returns the new tokens, or a failure if refresh failed
  /// (in which case the user should be signed out).
  Future<Result<AuthTokens>> refresh() async {
    final stored = _current;
    if (stored == null) return const Failed(UnauthorizedFailure());
    final r = await _repository.refresh(refreshToken: stored.refreshToken);
    if (r is Success<AuthTokens>) _current = r.value;
    return r;
  }

  Future<void> signOut() async {
    await _repository.signOut();
    _current = null;
  }
}
