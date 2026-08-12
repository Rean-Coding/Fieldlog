package com.aeu.fieldlog.shared

/// Kotlin's sealed class — same idea as Dart's sealed class from W6.
sealed class Result<out T> {
    data class Success<T>(val value: T) : Result<T>()
    data class Failed(val failure: Failure) : Result<Nothing>()
}

sealed class Failure(val message: String) {
    class NetworkFailure(message: String = "Network unavailable") : Failure(message)
    class NotFoundFailure(message: String = "Not found") : Failure(message)
    class UnauthorizedFailure(message: String = "Please sign in") : Failure(message)
    class UnknownFailure(message: String = "Something went wrong") : Failure(message)
}
