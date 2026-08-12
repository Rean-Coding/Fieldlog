import '../../logs/domain/result.dart';
import 'auth_tokens.dart';

/// Auth contract. The Service depends on this — never on the concrete
/// HTTP-backed implementation.
abstract class AuthRepository {
  Future<Result<AuthTokens>> signIn({required String email, required String password});
  Future<Result<AuthTokens>> refresh({required String refreshToken});
  Future<Result<void>> signOut();
  Future<AuthTokens?> loadStoredTokens();
  Future<void> storeTokens(AuthTokens tokens);
  Future<void> clearTokens();
}
