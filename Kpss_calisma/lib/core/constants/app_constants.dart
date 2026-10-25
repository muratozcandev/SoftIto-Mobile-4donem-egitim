/// Uygulama genelinde kullanılan genel sabitleri, veritabanı tablo isimlerini ve varsayılan ayarları tutan sınıf
class AppConstants {
  // --- Uygulama Temel Bilgileri ---
  static const String appName = 'KPSS'; // Uygulamanın adı
  static const String appSubtitle = 'Çalışma Koçu'; // Uygulamanın alt başlığı / sloganı
  static const String appVersion = '1.0.0'; // Uygulamanın mevcut sürüm numarası

  // --- Hive Veritabanı Kutu (Box / Tablo) İsimleri ---
  static const String settingsBox = 'settings_box'; // Kullanıcı ayarlarının (hedef, tema vb.) saklandığı Hive kutusu
  static const String topicStatusBox = 'topic_status_box'; // Ders konularının tamamlanma durumlarının saklandığı Hive kutusu
  static const String questionLogsBox = 'question_logs_box'; // Çözülen soru kayıtlarının tutulduğu Hive kutusu
  static const String studySessionsBox = 'study_sessions_box'; // Kronometre ile yapılan ders çalışma seanslarının saklandığı kutu
  static const String mockExamsBox = 'mock_exams_box'; // Girilen deneme sınavı sonuçlarının saklandığı kutu

  // --- Ayarlar Kutusu Anahtarları (Key İsimleri) ---
  static const String keyDailyGoal = 'dailyGoal'; // Günlük çözülmesi hedeflenen soru sayısının anahtarı
  static const String keyIsDarkTheme = 'isDark'; // Koyu tema modunun açık/kapalı olma durumunun anahtarı
  static const String keyFirstRun = 'firstRun'; // Uygulamanın ilk kez başlatılıp başlatılmadığını kontrol eden anahtar

  // --- Varsayılan Başlangıç Değerleri ---
  static const int defaultDailyGoal = 100; // Kullanıcı ilk başladığında atanan varsayılan günlük soru hedefi (100 soru)
  static const int defaultPomodoroMinutes = 25; // Standart Pomodoro çalışma süresi (25 dakika)
  static const int defaultShortBreakMinutes = 5; // Pomodoro sonrası verilecek kısa mola süresi (5 dakika)

  // --- Konu Çalışma Durumu Kodları ---
  static const int statusNotStarted = 0; // Henüz çalışılmamış konu durum kodu (0 = Başlanmadı)
  static const int statusNeedsReview = 1; // Tekrar edilmesi gereken konu durum kodu (1 = Tekrar Edilmeli)
  static const int statusCompleted = 2; // Tamamen bitirilmiş konu durum kodu (2 = Tamamlandı)

  // --- Sabit Varlık (Asset) Dosya Yolları ---
  static const String assetTopicsJson = 'assets/kpss_topics.json'; // KPSS müfredat ve konularını içeren JSON veri dosyası
  static const String assetLogo = 'assets/images/kpss_logo.jpg'; // Uygulama giriş ve arayüz logosu
  static const String assetIcon = 'assets/icons/app_icon.png'; // Uygulama simgesi görseli
}
