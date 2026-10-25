import 'package:flutter/material.dart'; // Flutter ChangeNotifier durumu ve UI entegrasyonu için kütüphane
import 'package:uuid/uuid.dart'; // Her deneme sınavına benzersiz rastgele kimlik (UUID) üretmek için kütüphane
import '../core/services/hive_service.dart'; // Deneme verilerini yerel veritabanında saklamak için Hive servisi
import '../models/mock_exam.dart'; // MockExam veri modeli sınıfı

/// KPSS deneme sınavı sonuçlarını yöneten, hesaplayan ve yerel veritabanına kaydeden Provider sınıfı
class MockExamProvider with ChangeNotifier {
  List<MockExam> _exams = []; // Kullanıcının eklediği tüm deneme sınavlarının listesi
  final _uuid = const Uuid(); // Benzersiz ID üretici nesnesi

  /// Kurucu metot: Provider ayağa kalktığında veritabanındaki denemeleri listeye yükler
  MockExamProvider() {
    loadExams(); // Denemeleri yükle
  }

  /// Denemeler listesini dışarıya salt okunur (unmodifiable) olarak sunar
  List<MockExam> get exams => List.unmodifiable(_exams);

  /// Hive veritabanından tüm deneme kayıtlarını okuyan ve tarihe göre azalan sırada sıralayan metot
  void loadExams() {
    final box = HiveService.mockExamsBox; // Deneme sınavları kutusunu alır
    final List<MockExam> loaded = []; // Geçici liste oluşturur
    
    // Veritabanındaki tüm kayıtları döngüyle çeker
    for (final key in box.keys) {
      final raw = box.get(key);
      if (raw is Map) {
        loaded.add(MockExam.fromMap(raw)); // Ham veriyi MockExam nesnesine dönüştürür
      }
    }
    
    // En yeni deneme en üstte görünecek şekilde tarihe göre yeniden eskiye sıralar
    loaded.sort((a, b) => b.date.compareTo(a.date));
    _exams = loaded; // Asıl listeye atar
    notifyListeners(); // Ekranın güncellenmesini sağlar
  }

  /// Yeni bir deneme sınavı sonucunu sisteme ve veritabanına ekleyen metot
  Future<void> addExam({
    required String title, // Deneme sınavının adı
    required DateTime date, // Sınavın yapıldığı tarih
    required int gyCorrect, // Genel Yetenek doğru sayısı
    required int gyWrong, // Genel Yetenek yanlış sayısı
    required int gkCorrect, // Genel Kültür doğru sayısı
    required int gkWrong, // Genel Kültür yanlış sayısı
    String? note, // Denemeye ait isteğe bağlı not
  }) async {
    final id = _uuid.v4(); // Benzersiz v4 UUID üretir
    final exam = MockExam(
      id: id,
      title: title.trim().isEmpty ? 'KPSS Denemesi' : title.trim(), // Başlık boşsa varsayılan isim verir
      date: date,
      gyCorrect: gyCorrect,
      gyWrong: gyWrong,
      gkCorrect: gkCorrect,
      gkWrong: gkWrong,
      note: note,
    );

    await HiveService.mockExamsBox.put(id, exam.toMap()); // Hive veritabanına kaydeder
    _exams.insert(0, exam); // Listenin en başına ekler (en güncel olarak)
    notifyListeners(); // Ekranı bilgilendirir
  }

  /// Belirtilen kimliğe sahip deneme sınavını veritabanından ve listeden siler
  Future<void> deleteExam(String id) async {
    await HiveService.mockExamsBox.delete(id); // Veritabanından siler
    _exams.removeWhere((e) => e.id == id); // Yerel listeden kaldırır
    notifyListeners(); // Arayüzü günceller
  }

  /// Girilen tüm deneme sınavlarının toplam net ortalamasını hesaplar
  double get averageTotalNet {
    if (_exams.isEmpty) return 0.0; // Deneme yoksa 0 döndür
    final sum = _exams.fold(0.0, (acc, e) => acc + e.totalNet); // Tüm netleri toplar
    return sum / _exams.length; // Toplam neti deneme sayısına böler
  }

  /// Girilen deneme sınavları arasındaki en yüksek toplam neti bulur
  double get highestTotalNet {
    if (_exams.isEmpty) return 0.0;
    // Listenin en yüksek nete sahip elemanını döndürür
    return _exams.map((e) => e.totalNet).reduce((a, b) => a > b ? a : b);
  }

  /// Tüm denemelerdeki Genel Yetenek (GY) netlerinin ortalamasını hesaplar
  double get averageGyNet {
    if (_exams.isEmpty) return 0.0;
    final sum = _exams.fold(0.0, (acc, e) => acc + e.gyNet);
    return sum / _exams.length;
  }

  /// Tüm denemelerdeki Genel Kültür (GK) netlerinin ortalamasını hesaplar
  double get averageGkNet {
    if (_exams.isEmpty) return 0.0;
    final sum = _exams.fold(0.0, (acc, e) => acc + e.gkNet);
    return sum / _exams.length;
  }
}
