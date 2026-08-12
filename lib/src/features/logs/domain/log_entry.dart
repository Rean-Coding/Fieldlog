/// A single FieldLog entry — the core domain object for the logs feature.
///
/// Immutable by design (Week 1 rule: immutability by default). All fields are
/// final; equality is value-based via `==` and `hashCode` so two entries with
/// the same data compare equal regardless of identity.
class LogEntry {
  const LogEntry({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.category,
  });

  final int id;
  final String title;
  final String body;
  final DateTime createdAt;
  final String category;

  LogEntry copyWith({
    int? id,
    String? title,
    String? body,
    DateTime? createdAt,
    String? category,
  }) {
    return LogEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
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
          other.category == category;

  @override
  int get hashCode => Object.hash(id, title, body, createdAt, category);

  @override
  String toString() =>
      'LogEntry(id: $id, title: $title, category: $category)';
}
