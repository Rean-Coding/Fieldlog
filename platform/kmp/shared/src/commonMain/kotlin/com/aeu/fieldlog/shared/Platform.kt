package com.aeu.fieldlog.shared

/// `expect` declarations have platform-specific `actual` implementations.
///
/// Compare to Dart: there is no direct equivalent. Dart-side platform code
/// goes through MethodChannels (W14). KMP makes the platform split a
/// compile-time concept.
expect class Platform() {
    val name: String
}

expect fun deviceInfoString(): String

/// The smallest possible example of why `expect` exists.
///
/// `System.currentTimeMillis()` is a JVM API. Written in commonMain it compiles
/// happily for Android and fails the iOS build — the kind of mistake that only
/// surfaces on the platform you test last.
expect fun currentTimeMillis(): Long
