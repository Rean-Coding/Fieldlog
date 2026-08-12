/// Build-time configuration injected via --dart-define on the build command.
///
/// Used by dio_provider, AuthRepository, and anything else that depends on the
/// environment. Compiled away on tree-shaking — values become string constants.
class AppConfig {
  AppConfig._();

  /// 'dev' | 'staging' | 'prod'
  static const env = String.fromEnvironment('ENV', defaultValue: 'dev');

  /// The base URL for the backend.
  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://fieldlog-api-dev.example.com',
  );

  static bool get isProd => env == 'prod';
  static bool get isStaging => env == 'staging';
  static bool get isDev => env == 'dev';
}
