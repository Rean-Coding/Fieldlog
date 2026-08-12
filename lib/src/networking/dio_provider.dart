import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

// ─────────────────────────────────────────────────────────────
// Week 10: A single configured Dio instance for the whole app.
//
// Interceptors are the Chain of Responsibility pattern. Each link
// either handles the request/response or passes to the next.
// In W11 we add an Auth interceptor to this same chain.
// ─────────────────────────────────────────────────────────────

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://fieldlog-api.example.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  // Logging — debug builds only. Never log request/response bodies in
  // production: they may contain tokens or PII.
  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (msg) => debugPrint('[Dio] $msg'),
    ));
  }

  return dio;
}
