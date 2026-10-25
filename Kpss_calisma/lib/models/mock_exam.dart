/// Kullanıcının çözdüğü Genel Yetenek - Genel Kültür KPSS Deneme Sınavı sonuçlarını temsil eden veri modeli
class MockExam {
  final String id; // Deneme kaydının benzersiz kimlik kodu (UUID)
  final String title; // Denemenin adı veya yayıncısı (Örn: 'Pegem TG-1', 'Yediiklim 2026 Deneme 3')
  final DateTime date; // Denemenin çözüldüğü tarih ve saat
  final int gyCorrect; // Genel Yetenek (Türkçe + Matematik) bölümündeki doğru sayısı
  final int gyWrong; // Genel Yetenek bölümündeki yanlış sayısı
  final int gkCorrect; // Genel Kültür (Tarih + Coğrafya + Vatandaşlık) bölümündeki doğru sayısı
  final int gkWrong; // Genel Kültür bölümündeki yanlış sayısı
  final String? note; // Deneme sınavına dair alınan isteğe bağlı özel not

  /// MockExam kurucu metodu (Constructor)
  MockExam({
    required this.id, // Benzersiz kimlik zorunludur
    required this.title, // Deneme başlığı zorunludur
    required this.date, // Çözülme tarihi zorunludur
    required this.gyCorrect, // GY Doğru sayısı zorunludur
    required this.gyWrong, // GY Yanlış sayısı zorunludur
    required this.gkCorrect, // GK Doğru sayısı zorunludur
    required this.gkWrong, // GK Yanlış sayısı zorunludur
    this.note, // Ek not alanı opsiyoneldir
  });

  /// Genel Yetenek netini hesaplayan getter (Doğru - (Yanlış / 4))
  double get gyNet => gyCorrect - (gyWrong / 4.0);

  /// Genel Kültür netini hesaplayan getter (Doğru - (Yanlış / 4))
  double get gkNet => gkCorrect - (gkWrong / 4.0);

  /// Deneme sınavındaki toplam KPSS netini hesaplayan getter (GY Net + GK Net)
  double get totalNet => gyNet + gkNet;

  /// Denemede işaretlenen veya cevaplanan toplam soru sayısını hesaplar
  int get totalQuestions => gyCorrect + gyWrong + gkCorrect + gkWrong;

  /// GY ve GK bölümlerinde yapılan toplam doğru sayısını hesaplar
  int get totalCorrect => gyCorrect + gkCorrect;

  /// GY ve GK bölümlerinde yapılan toplam yanlış sayısını hesaplar
  int get totalWrong => gyWrong + gkWrong;

  /// Hive veritabanından gelen Map yapısını MockExam nesnesine çeviren fabrika metodu
  factory MockExam.fromMap(Map<dynamic, dynamic> map) {
    return MockExam(
      id: map['id']?.toString() ?? '', // Deneme ID
      title: map['title']?.toString() ?? 'KPSS Denemesi', // Deneme başlığı (Varsayılan: 'KPSS Denemesi')
      // Tarih bilgisini DateTime nesnesine çevirir
      date: map['date'] != null
          ? DateTime.tryParse(map['date'].toString()) ?? DateTime.now()
          : DateTime.now(),
      gyCorrect: int.tryParse(map['gyCorrect']?.toString() ?? '0') ?? 0, // GY Doğru sayısı
      gyWrong: int.tryParse(map['gyWrong']?.toString() ?? '0') ?? 0, // GY Yanlış sayısı
      gkCorrect: int.tryParse(map['gkCorrect']?.toString() ?? '0') ?? 0, // GK Doğru sayısı
      gkWrong: int.tryParse(map['gkWrong']?.toString() ?? '0') ?? 0, // GK Yanlış sayısı
      note: map['note']?.toString(), // Deneme sınavı notu
    );
  }

  /// Deneme verisini Hive veritabanına kaydetmek için harita (Map) formatına dönüştürür
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Benzersiz kimlik
      'title': title, // Deneme adı
      'date': date.toIso8601String(), // ISO formatlı tarih metni
      'gyCorrect': gyCorrect, // GY Doğru
      'gyWrong': gyWrong, // GY Yanlış
      'gkCorrect': gkCorrect, // GK Doğru
      'gkWrong': gkWrong, // GK Yanlış
      'note': note, // Not
    };
  }
}
