sealed class Failure {
  const Failure({required this.message});
  final String message;
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Network unavailable. Check your connection.'});
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({super.message = 'The request took too long.'});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = 'Not found.'});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message = 'Please sign in to continue.'});
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = 'The server had a problem. Try again.'});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'Something went wrong.'});
}
