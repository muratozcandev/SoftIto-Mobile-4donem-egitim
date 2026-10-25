/// Kronometre veya Pomodoro sayacı ile yapılan ders çalışma seanslarını temsil eden veri modeli
class StudySession {
  final String id; // Seansın benzersiz kimlik kodu (UUID)
  final String courseId; // Çalışılan dersin kimlik kodu (Örn: 'tarih', 'cografya')
  final int durationInMinutes; // Çalışılan toplam süre (Dakika cinsinden)
  final DateTime date; // Çalışmanın yapıldığı tarih ve saat
  final String type; // Çalışma sayacının türü: 'pomodoro' (Pomodoro Tekniği) veya 'stopwatch' (Kronometre)
  final String? note; // Bu çalışma seansı için kullanıcının eklediği isteğe bağlı not

  /// StudySession kurucu metodu (Constructor)
  StudySession({
    required this.id, // Benzersiz kimlik zorunludur
    required this.courseId, // Ders kimliği zorunludur
    required this.durationInMinutes, // Süre (dakika) zorunludur
    required this.date, // Tarih bilgisi zorunludur
    required this.type, // Sayaç türü zorunludur
    this.note, // Seans notu opsiyoneldir
  });

  /// Veritabanından (Hive) okunan Map yapısını StudySession nesnesine dönüştüren fabrika metodu
  factory StudySession.fromMap(Map<dynamic, dynamic> map) {
    return StudySession(
      id: map['id']?.toString() ?? '', // Kayıt kimliğini alır
      courseId: map['courseId']?.toString() ?? '', // Çalışılan dersin ID'sini alır
      durationInMinutes: int.tryParse(map['durationInMinutes']?.toString() ?? '0') ?? 0, // Süreyi tamsayıya çevirir
      // ISO formatındaki tarih bilgisini ayrıştırır, yoksa o anki zamanı varsayılan yapar
      date: map['date'] != null
          ? DateTime.tryParse(map['date'].toString()) ?? DateTime.now()
          : DateTime.now(),
      type: map['type']?.toString() ?? 'pomodoro', // Sayaç türünü alır (Varsayılan: 'pomodoro')
      note: map['note']?.toString(), // Varsa not metnini alır
    );
  }

  /// Nesneyi Hive veritabanında saklamak üzere anahtar-değer (Map) haritasına dönüştürür
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Seans kimliği
      'courseId': courseId, // Ders kimliği
      'durationInMinutes': durationInMinutes, // Seans süresi (dk)
      'date': date.toIso8601String(), // Standart ISO-8601 tarih metni
      'type': type, // Seans türü ('pomodoro' veya 'stopwatch')
      'note': note, // Açıklama notu
    };
  }
}
