/// Su tüketim kaydı veri modeli
class WaterEntry {
  final String id;
  final int amountInMl;
  final DateTime timestamp;
  final String? note;

  const WaterEntry({
    required this.id,
    required this.amountInMl,
    required this.timestamp,
    this.note,
  });

  String get formattedTime {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
