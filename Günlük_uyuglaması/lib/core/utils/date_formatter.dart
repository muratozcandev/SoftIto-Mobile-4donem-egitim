/// [DateFormatter], tarih ve saat işlemlerini üçüncü parti paketlere
/// ihtiyaç duymadan saf Dart ile Türkçe olarak biçimlendiren yardımcı sınıftır.
abstract final class DateFormatter {
  static const List<String> turkishMonths = <String>[
    'Ocak',
    'Şubat',
    'Mart',
    'Nisan',
    'Mayıs',
    'Haziran',
    'Temmuz',
    'Ağustos',
    'Eylül',
    'Ekim',
    'Kasım',
    'Aralık',
  ];

  static const List<String> turkishDaysShort = <String>[
    'Pzt',
    'Sal',
    'Çar',
    'Per',
    'Cum',
    'Cmt',
    'Paz',
  ];

  static const List<String> turkishDaysFull = <String>[
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar',
  ];

  /// Ay ve Yıl biçimi: Örn: "Ekim 2026"
  static String formatMonthYear(DateTime date) {
    final String monthName = turkishMonths[date.month - 1];
    return '$monthName ${date.year}';
  }

  /// Gün adı kısaltması: Örn: "Pzt"
  static String formatDayShort(DateTime date) {
    return turkishDaysShort[date.weekday - 1];
  }

  /// Gün adı tam: Örn: "Pazartesi"
  static String formatDayFull(DateTime date) {
    return turkishDaysFull[date.weekday - 1];
  }

  /// Tam tarih: Örn: "19 Ekim 2026, Pazartesi"
  static String formatFullDate(DateTime date) {
    final String monthName = turkishMonths[date.month - 1];
    final String dayName = formatDayFull(date);
    return '${date.day} $monthName ${date.year}, $dayName';
  }

  /// Saat biçimi (2 haneli): Örn: "23:45"
  static String formatTime(DateTime date) {
    final String hour = date.hour.toString().padLeft(2, '0');
    final String minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// Karşılaştırma ve Map anahtarı için benzersiz gün anahtarı: "2026-10-19"
  static String toDateKey(DateTime date) {
    final String month = date.month.toString().padLeft(2, '0');
    final String day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}
