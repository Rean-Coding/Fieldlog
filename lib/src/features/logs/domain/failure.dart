/// Domain failure type — a sealed union of error variants.
///
/// Week 6 introduces "errors as values" — instead of throwing exceptions, the
/// data layer returns a [Result] containing either a value or a [Failure].
/// Pattern matching on [Failure] is exhaustive: the compiler complains if you
/// miss a variant.
///
/// We hand-roll this union as a `sealed class` rather than using the `freezed`
/// package, to keep the sample project lightweight. In production code you may
/// prefer freezed for the generated `copyWith`, `==`, and `hashCode`. The
/// behavior is identical.
sealed class Failure {
  const Failure({required this.message});

  final String message;
}

/// The network is unreachable, the request timed out, or DNS failed.
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Network unavailable. Check your connection.'});
}

/// The server returned 404 / a record could not be found locally.
class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = 'Not found.'});
}

/// The user is not authenticated, or their token has expired.
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message = 'Please sign in to continue.'});
}

/// Any other failure — programmer error, unexpected server response, etc.
/// Used as the catch-all in `Failure.fromException`.
class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'Something went wrong.'});
}

extension FailureMapping on Failure {
  /// Maps a Failure to a short, user-facing message.
  /// Used by the presentation layer — never by Services or Repositories.
  static String userMessage(Failure f) => switch (f) {
        NetworkFailure() => f.message,
        NotFoundFailure() => f.message,
        UnauthorizedFailure() => f.message,
        UnknownFailure() => f.message,
      };
}
