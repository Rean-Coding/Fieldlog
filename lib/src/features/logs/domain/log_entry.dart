/// A single FieldLog entry — the core domain object.
///
/// W9: gains `isPending` flag — true if the entry has been written locally
/// but not yet confirmed by the sync engine.
class LogEntry {
  const LogEntry({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.category,
    this.isPending = false,
  });

  final int id;
  final String title;
  final String body;
  final DateTime createdAt;
  final String category;
  final bool isPending;

  LogEntry copyWith({
    int? id,
    String? title,
    String? body,
    DateTime? createdAt,
    String? category,
    bool? isPending,
  }) {
    return LogEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
      isPending: isPending ?? this.isPending,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogEntry &&
          other.id == id &&
          other.title == title &&
          other.body == body &&
          other.createdAt == createdAt &&
          other.category == category &&
          other.isPending == isPending;

  @override
  int get hashCode => Object.hash(id, title, body, createdAt, category, isPending);
}
