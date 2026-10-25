/// Kullanıcının çözdüğü soru kayıtlarını (doğru, yanlış, boş ve tarih bilgisiyle) tutan veri modeli
class QuestionLog {
  final String id; // Soru kaydının benzersiz kimliği (Genellikle UUID ile üretilir)
  final String courseId; // Soruların çözüldüğü dersin kimlik kodu (Örn: 'turkce', 'matematik')
  final int correct; // Çözülen doğru soru sayısı
  final int wrong; // Çözülen yanlış soru sayısı
  final int empty; // Boş bırakılan soru sayısı
  final DateTime date; // Soruların çözüldüğü gün ve saat
  final String? note; // Kullanıcının bu soru çözümüne eklediği isteğe bağlı not

  /// QuestionLog sınıfı kurucu metodu (Constructor)
  QuestionLog({
    required this.id, // Benzersiz kayıt kimliği zorunlu
    required this.courseId, // Ders kimliği zorunlu
    required this.correct, // Doğru sayısı zorunlu
    required this.wrong, // Yanlış sayısı zorunlu
    required this.empty, // Boş sayısı zorunlu
    required this.date, // Tarih zorunlu
    this.note, // Ek açıklama notu opsiyonel
  });

  /// Toplam çözülen/işaretlenen soru sayısını hesaplayan getter
  /// Formül: Doğru + Yanlış + Boş
  int get totalQuestions => correct + wrong + empty;

  /// Bu soru kaydına ait KPSS net sayısını hesaplayan getter
  /// 4 yanlış 1 doğruyu götürür kuralı uygulanır
  double get netScore => correct - (wrong / 4.0);

  /// Çözülen toplam sorular içindeki başarı (doğruluk) oranını yüzde cinsinden döndüren getter
  double get accuracyRate {
    // Eğer toplam soru 0 ise sıfıra bölünme hatasını engellemek için %0 döndürür
    if (totalQuestions == 0) return 0.0;
    // Yüzdelik hesaplama: (Doğru / Toplam) * 100
    return (correct / totalQuestions) * 100.0;
  }

  /// Veritabanından (Hive) okunan Map yapısını QuestionLog nesnesine dönüştüren fabrika metodu
  factory QuestionLog.fromMap(Map<dynamic, dynamic> map) {
    return QuestionLog(
      id: map['id']?.toString() ?? '', // Kayıt ID'sini stringe çevirir
      courseId: map['courseId']?.toString() ?? '', // Ders ID'sini alır
      correct: int.tryParse(map['correct']?.toString() ?? '0') ?? 0, // Doğru sayısını ayrıştırır
      wrong: int.tryParse(map['wrong']?.toString() ?? '0') ?? 0, // Yanlış sayısını ayrıştırır
      empty: int.tryParse(map['empty']?.toString() ?? '0') ?? 0, // Boş sayısını ayrıştırır
      // Tarih değerini ISO-8601 formatından DateTime nesnesine dönüştürür, hata varsa şimdiki zamanı alır
      date: map['date'] != null
          ? DateTime.tryParse(map['date'].toString()) ?? DateTime.now()
          : DateTime.now(),
      note: map['note']?.toString(), // Varsa notu metin olarak alır
    );
  }

  /// QuestionLog nesnesini Hive veritabanına kaydedilebilmesi için Map formatına dönüştürür
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Benzersiz kimlik
      'courseId': courseId, // Ders kimliği
      'correct': correct, // Doğru sayısı
      'wrong': wrong, // Yanlış sayısı
      'empty': empty, // Boş sayısı
      'date': date.toIso8601String(), // Tarihi standart ISO metin formatına çevirir
      'note': note, // Varsa not metni
    };
  }
}
