/// Tokens issued by the auth server.
///
/// `accessToken` is short-lived (15 min typical). It is sent on every request.
/// `refreshToken` is longer-lived (days/weeks). Used to mint a new access
/// token when the current one expires.
///
/// Refresh tokens NEVER live in normal storage — only `flutter_secure_storage`
/// (Keychain on iOS, EncryptedSharedPreferences on Android).
class AuthTokens {
  const AuthTokens({required this.accessToken, required this.refreshToken});
  final String accessToken;
  final String refreshToken;
}
