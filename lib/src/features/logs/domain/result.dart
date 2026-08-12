import 'failure.dart';

/// A `Result<T>` is either a [Success] holding a value of type T, or a
/// [Failed] holding a [Failure].
///
/// We use this instead of `Either<Failure, T>` from `fpdart` to keep the
/// sample project dependency-free. Pattern matching is identical:
///
///   switch (result) {
///     case Success(:final value):  // use value
///     case Failed(:final failure): // use failure
///   }
sealed class Result<T> {
  const Result();

  /// Convenience: maps the successful value through [fn]. Failures pass
  /// through unchanged.
  Result<R> map<R>(R Function(T value) fn) => switch (this) {
        Success<T>(:final value) => Success<R>(fn(value)),
        Failed<T>(:final failure) => Failed<R>(failure),
      };
}

class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;
}

class Failed<T> extends Result<T> {
  const Failed(this.failure);
  final Failure failure;
}
