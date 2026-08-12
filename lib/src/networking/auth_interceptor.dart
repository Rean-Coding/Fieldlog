import 'dart:async';

import 'package:dio/dio.dart';

import '../features/auth/application/auth_service.dart';
import '../features/logs/domain/result.dart';

/// Auth interceptor — the new top link in the W11 chain.
///
/// Responsibilities:
///   1. Attach `Authorization: Bearer <accessToken>` to every outgoing request
///   2. On a 401 response, attempt one refresh; on success, retry the
///      original request once with the new token; on failure, surface the
///      401 and let the app sign the user out
///
/// Concurrency: if many requests fire simultaneously and all get 401, we
/// must NOT refresh multiple times. The `_refreshCompleter` queue ensures
/// only one refresh is in flight; other 401s wait for the same Future.
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor(this._authService, this._dio);

  final AuthService _authService;
  final Dio _dio;

  Completer<void>? _refreshCompleter;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _authService.current?.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final response = err.response;
    if (response == null || response.statusCode != 401) {
      return handler.next(err);
    }

    // If another 401 is already in flight refreshing, wait for it.
    if (_refreshCompleter != null) {
      await _refreshCompleter!.future;
    } else {
      _refreshCompleter = Completer<void>();
      try {
        final result = await _authService.refresh();
        if (result is! Success) {
          // Refresh failed — sign out and propagate the original 401.
          await _authService.signOut();
          _refreshCompleter!.complete();
          _refreshCompleter = null;
          return handler.next(err);
        }
      } finally {
        _refreshCompleter?.complete();
        _refreshCompleter = null;
      }
    }

    // Retry the original request once with the new token.
    final newToken = _authService.current?.accessToken;
    if (newToken == null) return handler.next(err);
    final options = err.requestOptions;
    options.headers['Authorization'] = 'Bearer $newToken';
    try {
      final retried = await _dio.fetch<dynamic>(options);
      return handler.resolve(retried);
    } on DioException catch (e) {
      return handler.next(e);
    }
  }
}
