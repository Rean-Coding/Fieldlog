import 'package:dio/dio.dart';

import '../features/logs/domain/failure.dart';

/// Maps a [DioException] to a domain [Failure].
///
/// This mapping is the platform-to-domain translation that lives in the
/// data layer. The Service and UI never see a `DioException` — they see
/// a typed Failure variant.
Failure mapDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
      return const TimeoutFailure();
    case DioExceptionType.connectionError:
      return const NetworkFailure();
    case DioExceptionType.badResponse:
      final code = e.response?.statusCode ?? 0;
      if (code == 401) return const UnauthorizedFailure();
      if (code == 404) return const NotFoundFailure();
      if (code >= 500) return const ServerFailure();
      return UnknownFailure(message: 'HTTP $code: ${e.message ?? ''}');
    case DioExceptionType.cancel:
      return const UnknownFailure(message: 'Request cancelled.');
    case DioExceptionType.unknown:
    case DioExceptionType.badCertificate:
      return UnknownFailure(message: e.message ?? 'Unknown error.');
  }
}
