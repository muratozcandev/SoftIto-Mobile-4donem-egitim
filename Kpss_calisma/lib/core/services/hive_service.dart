import 'package:hive_flutter/hive_flutter.dart'; // Flutter için Hive yerel NoSQL veritabanı paketini içeri aktarır
import '../constants/app_constants.dart'; // Kutu (box) isimlerini almak için sabitler sınıfını içeri aktarır

/// Hive NoSQL yerel veritabanı işlemlerini başlatan ve kutulara (tablolara) erişim sağlayan servis sınıfı
class HiveService {
  /// Hive veritabanını ve gerekli tüm kutuları (tabloları) asenkron olarak başlatan metot
  static Future<void> init() async {
    await Hive.initFlutter(); // Hive veritabanını cihazın yerel depolama dizininde başlatır
    
    // Gerekli tüm kutuları aynı anda paralel olarak açarak zamandan tasarruf eder
    await Future.wait([
      Hive.openBox(AppConstants.settingsBox), // Ayarlar veritabanı kutusunu açar
      Hive.openBox(AppConstants.topicStatusBox), // Konu tamamlama durumları kutusunu açar
      Hive.openBox(AppConstants.questionLogsBox), // Çözülen soru kayıtları kutusunu açar
      Hive.openBox(AppConstants.studySessionsBox), // Çalışma seansları kutusunu açar
      Hive.openBox(AppConstants.mockExamsBox), // Deneme sınavları kutusunu açar
    ]);
  }

  // --- Açılmış Olan Veritabanı Kutularına Hızlı Erişim Getter'ları ---
  static Box get settingsBox => Hive.box(AppConstants.settingsBox); // Ayarlar kutusunu döndürür
  static Box get topicStatusBox => Hive.box(AppConstants.topicStatusBox); // Konu durumları kutusunu döndürür
  static Box get questionLogsBox => Hive.box(AppConstants.questionLogsBox); // Soru kayıtları kutusunu döndürür
  static Box get studySessionsBox => Hive.box(AppConstants.studySessionsBox); // Çalışma süreleri kutusunu döndürür
  static Box get mockExamsBox => Hive.box(AppConstants.mockExamsBox); // Deneme sınavları kutusunu döndürür
}
