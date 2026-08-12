package com.aeu.fieldlog.shared

import kotlinx.serialization.Serializable

/// Shared LogEntry data class — common to Android, iOS, JVM, JS, native.
///
/// `kotlinx.serialization` gives us JSON for free on every platform.
/// Compared to the Dart `LogEntry` (final fields, `==`/hashCode hand-rolled),
/// Kotlin's `data class` modifier generates `equals`, `hashCode`, `copy`,
/// `toString`, and component functions automatically.
@Serializable
data class LogEntry(
    val id: Int,
    val title: String,
    val body: String,
    val createdAtMs: Long,
    val category: String = "general"
)
