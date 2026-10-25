import 'dart:async'; // Periyodik zamanlayıcı (Timer) işlemleri için Dart asenkron kütüphanesi
import 'package:flutter/material.dart'; // ChangeNotifier ve UI entegrasyonu için Flutter kütüphanesi
import '../core/constants/app_constants.dart'; // Varsayılan süre sabitleri (25 dk pomodoro vb.)

/// Çalışma sayacının bulunabileceği çalışma modlarını tanımlayan numaralandırma (Enum)
enum StudyTimerMode {
  pomodoro, // 25 dakikalık odaklanmış ders çalışma modu
  shortBreak, // 5 dakikalık dinlenme/mola modu
  stopwatch, // 0'dan yukarı doğru sınırsız sayan serbest kronometre modu
}

/// Pomodoro ve Kronometre sayacının durumunu, süresini ve akışını yöneten Provider sınıfı
class TimerProvider with ChangeNotifier {
  StudyTimerMode _mode = StudyTimerMode.pomodoro; // Varsayılan olarak Pomodoro modu seçili başlar
  Timer? _timer; // Saniye bazında çalışan Dart Timer referansı

  // --- Süre Değişkenleri (Saniye Cinsinden) ---
  int _pomodoroDuration = AppConstants.defaultPomodoroMinutes * 60; // Pomodoro süresi (25 * 60 = 1500 saniye)
  final int _shortBreakDuration = AppConstants.defaultShortBreakMinutes * 60; // Kısa mola süresi (5 * 60 = 300 saniye)
  int _remainingSeconds = AppConstants.defaultPomodoroMinutes * 60; // Geri sayım için kalan saniye miktarı

  int _stopwatchElapsedSeconds = 0; // Kronometre modu için geçen toplam saniye miktarı

  bool _isRunning = false; // Sayacın şu anda çalışıp çalışmadığını belirten bayrak
  bool _isFinished = false; // Geri sayımın sıfıra ulaşıp bitip bitmediğini belirten bayrak

  // --- Dışarıya Açık Getter Değerleri ---
  StudyTimerMode get mode => _mode; // Mevcut modu döndürür
  bool get isRunning => _isRunning; // Sayaç aktif mi bilgisini döndürür
  bool get isFinished => _isFinished; // Süre bitti mi bilgisini döndürür
  int get remainingSeconds => _remainingSeconds; // Kalan saniyeyi döndürür
  int get stopwatchElapsedSeconds => _stopwatchElapsedSeconds; // Kronometrede geçen saniyeyi döndürür

  /// Ekranda gösterilecek olan saniye değerini aktif moda göre seçip döndürür
  int get currentDisplaySeconds {
    if (_mode == StudyTimerMode.stopwatch) {
      return _stopwatchElapsedSeconds; // Kronometrede geçen süreyi göster
    }
    return _remainingSeconds; // Pomodoro veya Molada kalan süreyi göster
  }

  /// Dairesel ilerleme çubuğu (CircularProgressIndicator) için 0.0 ile 1.0 arasında değer üretir
  double get progress {
    if (_mode == StudyTimerMode.stopwatch) return 1.0; // Kronometrede sabit dolu göster
    final total = _mode == StudyTimerMode.pomodoro ? _pomodoroDuration : _shortBreakDuration;
    if (total == 0) return 0.0;
    // Kalan sürenin toplam süreye oranını hesaplar ve 0 ile 1 arasına sınırlar
    return (_remainingSeconds / total).clamp(0.0, 1.0);
  }

  /// Saniye cinsinden süreyi "dakika:saniye" (Örn: 24:05 veya 08:30) metin formatına çevirir
  String get formattedTime {
    final secs = currentDisplaySeconds;
    final minutes = secs ~/ 60; // Tam dakikayı bulur
    final seconds = secs % 60; // Kalan saniyeyi bulur
    // İki basamaklı olacak şekilde başlarına 0 ekler (padLeft)
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Seans tamamlandığında kaydedilecek olan çalışma süresini dakika cinsinden hesaplar
  int get elapsedStudyMinutes {
    if (_mode == StudyTimerMode.stopwatch) {
      // Kronometre modunda geçen saniyeyi dakikaya yuvarlar (en az 1 dakika sayılır)
      final mins = (_stopwatchElapsedSeconds / 60).round();
      return mins < 1 ? 1 : mins;
    } else {
      // Pomodoro modunda toplam süreden kalan süreyi çıkararak çalışılan süreyi bulur
      final total = _mode == StudyTimerMode.pomodoro ? _pomodoroDuration : _shortBreakDuration;
      final elapsed = total - _remainingSeconds;
      final mins = (elapsed / 60).round();
      return mins < 1 ? 1 : mins;
    }
  }

  /// Sayacın modunu değiştirir (Örn: Pomodoro'dan Molaya veya Kronometreye geçiş)
  void switchMode(StudyTimerMode newMode) {
    if (_mode == newMode) return; // Zaten aynı moddaysa işlem yapma
    _stopTimer(); // Sayacı durdur
    _mode = newMode; // Yeni modu ata
    _isFinished = false; // Bitiş durumunu sıfırla
    _resetCurrentMode(); // Yeni modun süresini sıfırla/yeniden başlat
    notifyListeners(); // Ekranı güncelle
  }

  /// Sayacı başlatır veya duraklatılmış durumdan devam ettirir
  void startTimer() {
    if (_isRunning) return; // Zaten çalışıyorsa tekrar başlatma
    _isRunning = true;
    _isFinished = false;
    notifyListeners();

    // Her 1 saniyede bir tetiklenen periyodik döngü başlatılır
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_mode == StudyTimerMode.stopwatch) {
        _stopwatchElapsedSeconds++; // Kronometre modunda saniyeyi artır
        notifyListeners();
      } else {
        if (_remainingSeconds > 0) {
          _remainingSeconds--; // Geri sayım modunda saniyeyi azalt
          notifyListeners();
        } else {
          // Süre bittiğinde
          _stopTimer(); // Zamanlayıcıyı durdur
          _isFinished = true; // Bitti bayrağını kaldır
          notifyListeners(); // Arayüze süre bitti uyarısı vermek için dinleyicileri uyar
        }
      }
    });
  }

  /// Sayacı duraklatır (Geçen/kalan süre korunur)
  void pauseTimer() {
    _stopTimer(); // Zamanlayıcıyı durdur
    notifyListeners(); // Arayüzde butonun 'Başlat'a dönmesi için uyar
  }

  /// Sayacı durdurur ve mevcut modun başlangıç süresine sıfırlar
  void resetTimer() {
    _stopTimer(); // Zamanlayıcıyı durdur
    _isFinished = false;
    _resetCurrentMode(); // Başlangıç sürelerine dön
    notifyListeners(); // Ekranı güncelle
  }

  /// Pomodoro süresini kullanıcı tercihine göre dakika cinsinden ayarlar
  void setPomodoroMinutes(int minutes) {
    _pomodoroDuration = minutes * 60; // Saniyeye çevirip kaydeder
    if (_mode == StudyTimerMode.pomodoro && !_isRunning) {
      _remainingSeconds = _pomodoroDuration; // Sayaç çalışmıyorsa kalan süreyi de günceller
      notifyListeners();
    }
  }

  /// Aktif modun süresini başlangıç ayarlarına getiren iç yardımcı fonksiyon
  void _resetCurrentMode() {
    if (_mode == StudyTimerMode.pomodoro) {
      _remainingSeconds = _pomodoroDuration;
    } else if (_mode == StudyTimerMode.shortBreak) {
      _remainingSeconds = _shortBreakDuration;
    } else {
      _stopwatchElapsedSeconds = 0;
    }
  }

  /// Çalışan Timer nesnesini hafızadan temizler ve sayacı durdurur
  void _stopTimer() {
    _timer?.cancel(); // Aktif sayacı iptal et
    _timer = null; // Referansı temizle
    _isRunning = false; // Çalışma bayrağını false yap
  }

  /// Provider bellekten atılırken (dispose) sayacın arka planda sızmasını önlemek için iptal eder
  @override
  void dispose() {
    _timer?.cancel(); // Bellek sızıntısını önlemek için zamanlayıcıyı kapat
    super.dispose();
  }
}
