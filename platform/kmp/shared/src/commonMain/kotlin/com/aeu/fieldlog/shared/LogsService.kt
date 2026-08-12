package com.aeu.fieldlog.shared

import kotlinx.coroutines.delay

/// The shared LogsService — identical responsibilities to its Dart counterpart.
///
/// Six rules of a Service still all apply.
///
/// `suspend` is Kotlin's async marker — Dart's `async` keyword equivalent.
class LogsService(private val repository: LogsRepository) {

    suspend fun loadAll(): Result<List<LogEntry>> = repository.fetchAll()

    suspend fun recordToday(
        title: String,
        body: String,
        category: String = "general"
    ): Result<LogEntry> {
        if (title.trim().isEmpty()) {
            return Result.Failed(Failure.UnknownFailure("Title cannot be blank."))
        }
        return repository.add(title, body, category)
    }
}

interface LogsRepository {
    suspend fun fetchAll(): Result<List<LogEntry>>
    suspend fun add(title: String, body: String, category: String): Result<LogEntry>
}

class FakeLogsRepository : LogsRepository {
    // Seeded, and with fixed timestamps rather than a clock read: the demo has
    // no way to add an entry, so without seed data "Load" succeeds onto an
    // empty screen and proves nothing. Fixed values also keep the screenshots
    // in the book reproducible.
    private val entries = mutableListOf(
        LogEntry(1, "Pump inspection", "Bearing noise on unit 3.", 1_770_000_000_000, "maintenance"),
        LogEntry(2, "Soil moisture", "Plot B at 18%, below target.", 1_770_003_600_000, "survey"),
        LogEntry(3, "Fence repair", "Section 7 posts replaced.", 1_770_007_200_000, "general"),
    )
    private var nextId = entries.size + 1

    override suspend fun fetchAll(): Result<List<LogEntry>> {
        delay(1000)
        return Result.Success(entries.reversed())
    }

    override suspend fun add(title: String, body: String, category: String): Result<LogEntry> {
        delay(300)
        val entry = LogEntry(nextId++, title, body, currentTimeMillis(), category)
        entries.add(entry)
        return Result.Success(entry)
    }
}
