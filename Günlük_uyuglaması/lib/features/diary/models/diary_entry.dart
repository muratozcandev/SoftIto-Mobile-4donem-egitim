/// [DiaryEntry], bir güne ait günlük kaydının verilerini temsil eden
/// değişmez (immutable) model sınıfıdır.
class DiaryEntry {
  const DiaryEntry({
    required this.id,
    required this.date,
    required this.time,
    required this.title,
    required this.content,
    this.mood = '😊',
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final DateTime date;
  final String time;
  final String title;
  final String content;
  final String mood;
  final DateTime createdAt;
  final DateTime updatedAt;

  DiaryEntry copyWith({
    String? id,
    DateTime? date,
    String? time,
    String? title,
    String? content,
    String? mood,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DiaryEntry(
      id: id ?? this.id,
      date: date ?? this.date,
      time: time ?? this.time,
      title: title ?? this.title,
      content: content ?? this.content,
      mood: mood ?? this.mood,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
