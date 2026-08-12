import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../logs/domain/failure.dart';
import '../../logs/domain/result.dart';
import '../../../networking/dio_failure_mapper.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_tokens.dart';

/// AuthRepository that stores tokens in flutter_secure_storage and talks to
/// the backend via Dio.
class SecureAuthRepository implements AuthRepository {
  SecureAuthRepository(this._dio, [FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  final Dio _dio;
  final FlutterSecureStorage _storage;

  static const _accessKey = 'auth.access_token';
  static const _refreshKey = 'auth.refresh_token';

  @override
  Future<Result<AuthTokens>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final r = await _dio.post<Map<String, dynamic>>(
        '/auth/sign-in',
        data: {'email': email, 'password': password},
      );
      final tokens = AuthTokens(
        accessToken: r.data!['access_token'] as String,
        refreshToken: r.data!['refresh_token'] as String,
      );
      await storeTokens(tokens);
      return Success(tokens);
    } on DioException catch (e) {
      return Failed(mapDioException(e));
    } catch (_) {
      return const Failed(UnknownFailure());
    }
  }

  @override
  Future<Result<AuthTokens>> refresh({required String refreshToken}) async {
    try {
      final r = await _dio.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );
      final tokens = AuthTokens(
        accessToken: r.data!['access_token'] as String,
        refreshToken: r.data!['refresh_token'] as String,
      );
      await storeTokens(tokens);
      return Success(tokens);
    } on DioException catch (e) {
      return Failed(mapDioException(e));
    } catch (_) {
      return const Failed(UnknownFailure());
    }
  }

  @override
  Future<Result<void>> signOut() async {
    await clearTokens();
    return const Success(null);
  }

  @override
  Future<AuthTokens?> loadStoredTokens() async {
    final access = await _storage.read(key: _accessKey);
    final refresh = await _storage.read(key: _refreshKey);
    if (access == null || refresh == null) return null;
    return AuthTokens(accessToken: access, refreshToken: refresh);
  }

  @override
  Future<void> storeTokens(AuthTokens tokens) async {
    await _storage.write(key: _accessKey, value: tokens.accessToken);
    await _storage.write(key: _refreshKey, value: tokens.refreshToken);
  }

  @override
  Future<void> clearTokens() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
  }
}
