import '../../domain/log_entry.dart';

/// Wire format for log entries — matches the server JSON shape exactly.
///
/// Keeping DTO separate from domain `LogEntry` is the Data Mapper pattern.
/// The wire shape can evolve (new server fields, renames) without touching
/// the domain layer.
///
/// In production, generate this from json_serializable. The sample is
/// hand-written to keep the dep tree small.
class LogEntryDto {
  const LogEntryDto({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.category,
  });

  final int id;
  final String title;
  final String body;
  final String createdAt;
  final String category;

  factory LogEntryDto.fromJson(Map<String, dynamic> json) => LogEntryDto(
        id: json['id'] as int,
        title: json['title'] as String,
        body: json['body'] as String,
        createdAt: json['created_at'] as String,
        category: json['category'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'created_at': createdAt,
        'category': category,
      };

  /// Mapper to the domain entity. Note: it's a method on the DTO, not on
  /// `LogEntry`. The domain class has no idea the DTO exists.
  LogEntry toEntity() => LogEntry(
        id: id,
        title: title,
        body: body,
        createdAt: DateTime.parse(createdAt),
        category: category,
        isPending: false,
      );
}
