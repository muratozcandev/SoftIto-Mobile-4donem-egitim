import 'package:flutter/material.dart'; // UI bildirimleri ve ChangeNotifier sınıfı için kütüphane
import 'package:uuid/uuid.dart'; // Benzersiz kayıt kimlikleri (UUID) oluşturmak için
import '../core/services/hive_service.dart'; // Soru ve seans kayıtlarını yerel veritabanında saklamak için Hive
import '../core/utils/kpss_calculator.dart'; // KPSS net ve doğruluk hesaplama formülleri
import '../models/question_log.dart'; // Soru çözümü kayıt modeli
import '../models/study_session.dart'; // Çalışma seansı kayıt modeli

/// Belirli bir derse ait kümülatif istatistikleri (toplam doğru, yanlış, boş, net ve başarı yüzdesi) tutan yardımcı model sınıfı
class CourseStats {
  final String courseId; // İlgili dersin kimlik kodu (Örn: 'turkce', 'tarih')
  int totalCorrect = 0; // Bu derste çözülen toplam doğru soru sayısı
  int totalWrong = 0; // Bu derste çözülen toplam yanlış soru sayısı
  int totalEmpty = 0; // Bu derste boş bırakılan toplam soru sayısı

  /// Kurucu metot: Ders kimliğini zorunlu olarak alır
  CourseStats({required this.courseId});

  /// Bu ders için çözülen toplam soru sayısını hesaplar
  int get totalQuestions => totalCorrect + totalWrong + totalEmpty;
  
  /// Bu dersin genel KPSS netini hesaplar (Doğru - (Yanlış / 4))
  double get netScore => KpssCalculator.calculateNet(totalCorrect, totalWrong);
  
  /// Bu dersteki başarı yüzdesini hesaplar ((Doğru / Toplam) * 100)
  double get accuracyRate => KpssCalculator.calculateAccuracy(totalCorrect, totalQuestions);
}

/// Soru çözümlerini, çalışma sürelerini ve genel istatistikleri yöneten ana Provider sınıfı
class QuestionProvider with ChangeNotifier {
  List<QuestionLog> _logs = []; // Kullanıcının girdiği tüm soru kayıtlarının listesi
  List<StudySession> _sessions = []; // Kullanıcının kronometre/pomodoro ile kaydettiği seansların listesi
  final _uuid = const Uuid(); // Benzersiz ID üretici nesnesi

  /// Kurucu metot: Provider başlatıldığında veritabanındaki tüm soru ve seans kayıtlarını çeker
  QuestionProvider() {
    loadData(); // Verileri yerel veritabanından yükle
  }

  // --- Dışarıya Sunulan Salt Okunur Listeler ---
  List<QuestionLog> get logs => List.unmodifiable(_logs); // Soru kayıtları listesini dışarıya açar
  List<StudySession> get sessions => List.unmodifiable(_sessions); // Çalışma seansları listesini dışarıya açar

  /// Hive veritabanından soru kayıtlarını ve çalışma seanslarını okuyup tarihe göre azalan sırada yükler
  void loadData() {
    // 1. Soru Kayıtlarını Yükle
    final questionBox = HiveService.questionLogsBox;
    final List<QuestionLog> loadedLogs = [];
    for (final key in questionBox.keys) {
      final raw = questionBox.get(key);
      if (raw is Map) {
        loadedLogs.add(QuestionLog.fromMap(raw)); // Ham veriyi modele dönüştür
      }
    }
    // Tarihe göre yeniden eskiye (azalan sırada) sıralar
    loadedLogs.sort((a, b) => b.date.compareTo(a.date));
    _logs = loadedLogs;

    // 2. Çalışma Seanslarını Yükle
    final sessionBox = HiveService.studySessionsBox;
    final List<StudySession> loadedSessions = [];
    for (final key in sessionBox.keys) {
      final raw = sessionBox.get(key);
      if (raw is Map) {
        loadedSessions.add(StudySession.fromMap(raw)); // Ham veriyi modele dönüştür
      }
    }
    // Tarihe göre yeniden eskiye sıralar
    loadedSessions.sort((a, b) => b.date.compareTo(a.date));
    _sessions = loadedSessions;

    notifyListeners(); // Ekranların güncel verilerle çizilmesini sağlar
  }

  // --- SORU KAYDI İŞLEMLERİ (QUESTION LOGS) ---

  /// Yeni bir soru çözüm kaydı ekler ve veritabanına kaydeder
  Future<void> addQuestionLog({
    required String courseId, // Çözülen dersin ID'si
    required int correct, // Doğru sayısı
    required int wrong, // Yanlış sayısı
    required int empty, // Boş sayısı
    required DateTime date, // Çözüm tarihi
    String? note, // İsteğe bağlı açıklama notu
  }) async {
    final id = _uuid.v4(); // Benzersiz kayıt ID'si üret
    final log = QuestionLog(
      id: id,
      courseId: courseId,
      correct: correct,
      wrong: wrong,
      empty: empty,
      date: date,
      note: note,
    );

    await HiveService.questionLogsBox.put(id, log.toMap()); // Hive'a yaz
    _logs.insert(0, log); // Listenin en başına ekle (en güncel kayıt olarak)
    notifyListeners(); // Ana sayfadaki günlük hedefi ve istatistikleri güncelle
  }

  /// Belirtilen kimliğe sahip soru kaydını hem yerel bellekten hem de veritabanından siler
  Future<void> deleteQuestionLog(String id) async {
    await HiveService.questionLogsBox.delete(id); // Veritabanından sil
    _logs.removeWhere((l) => l.id == id); // Listeden sil
    notifyListeners(); // Ekranı güncelle
  }

  // --- ÇALIŞMA SEANSI İŞLEMLERİ (STUDY SESSIONS) ---

  /// Kronometre veya Pomodoro ile tamamlanan yeni bir çalışma seansını kaydeder
  Future<void> addStudySession({
    required String courseId, // Çalışılan dersin ID'si
    required int durationInMinutes, // Çalışılan dakika
    required DateTime date, // Çalışma tarihi
    required String type, // Sayaç tipi ('pomodoro' veya 'stopwatch')
    String? note, // Seans notu
  }) async {
    final id = _uuid.v4(); // Benzersiz kimlik
    final session = StudySession(
      id: id,
      courseId: courseId,
      durationInMinutes: durationInMinutes,
      date: date,
      type: type,
      note: note,
    );

    await HiveService.studySessionsBox.put(id, session.toMap()); // Veritabanına kaydet
    _sessions.insert(0, session); // En başa ekle
    notifyListeners(); // Ekranı güncelle
  }

  // --- BUGÜNÜN İSTATİSTİKLERİ (TODAY'S STATS) ---

  /// Sadece bugün çözülen soru kayıtlarını filtreleyip döndüren liste
  List<QuestionLog> get todayLogs {
    final now = DateTime.now();
    // Tarihlerin aynı gün olup olmadığını KpssCalculator.isSameDay ile kontrol eder
    return _logs.where((l) => KpssCalculator.isSameDay(l.date, now)).toList();
  }

  /// Bugün çözülen toplam soru sayısı (Doğru + Yanlış + Boş toplamı)
  int get todayTotalQuestions {
    return todayLogs.fold(0, (sum, l) => sum + l.totalQuestions);
  }

  /// Bugün çözülen toplam doğru soru sayısı
  int get todayTotalCorrect {
    return todayLogs.fold(0, (sum, l) => sum + l.correct);
  }

  /// Bugün çözülen toplam yanlış soru sayısı
  int get todayTotalWrong {
    return todayLogs.fold(0, (sum, l) => sum + l.wrong);
  }

  /// Bugün boş bırakılan toplam soru sayısı
  int get todayTotalEmpty {
    return todayLogs.fold(0, (sum, l) => sum + l.empty);
  }

  /// Bugünün KPSS net puanı (Bugünkü Doğru - (Bugünkü Yanlış / 4))
  double get todayNetScore {
    return KpssCalculator.calculateNet(todayTotalCorrect, todayTotalWrong);
  }

  /// Bugün ders çalışarak geçirilen toplam süre (Dakika cinsinden)
  int get todayStudyDurationMinutes {
    final now = DateTime.now();
    // Bugünkü seansları filtrele
    final todaySessions = _sessions.where((s) => KpssCalculator.isSameDay(s.date, now));
    // Dakikaları topla
    return todaySessions.fold(0, (sum, s) => sum + s.durationInMinutes);
  }

  // --- GENEL TOPLAMLAR VE KÜMÜLATİF İSTATİSTİKLER ---

  /// Uygulama kurulduğundan beri çözülmüş olan tüm soruların toplamı
  int get totalAllQuestions {
    return _logs.fold(0, (sum, l) => sum + l.totalQuestions);
  }

  /// Çözülmüş olan tüm sorular içindeki toplam doğru sayısı
  int get totalAllCorrect {
    return _logs.fold(0, (sum, l) => sum + l.correct);
  }

  /// Çözülmüş olan tüm sorular içindeki toplam yanlış sayısı
  int get totalAllWrong {
    return _logs.fold(0, (sum, l) => sum + l.wrong);
  }

  /// Tüm soru kayıtlarının genel KPSS net ortalaması/toplamı
  double get totalAllNetScore {
    return KpssCalculator.calculateNet(totalAllCorrect, totalAllWrong);
  }

  /// Çözülen tüm sorular arasındaki genel başarı oranı (Yüzde)
  double get overallAccuracyRate {
    return KpssCalculator.calculateAccuracy(totalAllCorrect, totalAllQuestions);
  }

  /// Uygulama genelinde ders çalışarak geçirilen tüm dakikaların toplamı
  int get totalAllStudyMinutes {
    return _sessions.fold(0, (sum, s) => sum + s.durationInMinutes);
  }

  /// Son 7 günün soru çözme sayılarını gün bazında (Tarih -> Sayı) haritalayan fonksiyon (Haftalık çubuk grafik için)
  Map<DateTime, int> getLast7DaysQuestionCounts() {
    final result = <DateTime, int>{};
    final now = DateTime.now();
    
    // Son 7 günü geriye doğru döngüyle oluştur ve başlangıçta 0 ata
    for (int i = 6; i >= 0; i--) {
      final day = KpssCalculator.normalizeDate(now.subtract(Duration(days: i)));
      result[day] = 0;
    }

    // Mevcut soru kayıtlarını döngüye alıp ilgili günlerin sayacına ekle
    for (final log in _logs) {
      final normalized = KpssCalculator.normalizeDate(log.date);
      if (result.containsKey(normalized)) {
        result[normalized] = (result[normalized] ?? 0) + log.totalQuestions;
      }
    }
    return result; // Hazır 7 günlük haritayı döndür
  }

  /// Çözülen soruları derslerine göre gruplayarak her dersin toplam doğru/yanlış/net istatistiğini çıkaran fonksiyon (Pasta grafik için)
  Map<String, CourseStats> getCourseStats() {
    final stats = <String, CourseStats>{};
    for (final log in _logs) {
      final courseId = log.courseId;
      // İlgili ders haritada yoksa oluştur, varsa mevcut nesneyi getir
      final stat = stats.putIfAbsent(courseId, () => CourseStats(courseId: courseId));
      stat.totalCorrect += log.correct; // Doğruları topla
      stat.totalWrong += log.wrong; // Yanlışları topla
      stat.totalEmpty += log.empty; // Boşları topla
    }
    return stats; // Ders bazlı istatistik haritasını döndür
  }
}
