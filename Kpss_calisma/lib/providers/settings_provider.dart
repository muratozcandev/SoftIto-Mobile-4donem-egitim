import 'package:flutter/material.dart'; // Flutter durum yönetimi (ChangeNotifier) için temel kütüphane
import '../core/constants/app_constants.dart'; // Sabit anahtarlar ve varsayılan değerler için sabitler sınıfı
import '../core/services/hive_service.dart'; // Ayarları kalıcı olarak yerel belleğe yazmak/okumak için Hive servisi

/// Uygulama ayarlarını (karanlık mod, günlük soru hedefi vb.) yöneten ve arayüzü güncelleyen Provider sınıfı
class SettingsProvider with ChangeNotifier {
  late int _dailyGoal; // Günlük çözülmesi hedeflenen soru sayısını tutan özel değişken
  late bool _isDarkTheme; // Koyu temanın aktif olup olmadığını tutan özel değişken

  /// Kurucu metot: Provider ayağa kalktığında kaydedilmiş ayarları diskten yükler
  SettingsProvider() {
    _loadSettings(); // Hafızadaki ayarları yükle
  }

  // --- Dışarıya Açık Okuma Değerleri (Getters) ---
  int get dailyGoal => _dailyGoal; // Günlük hedef sayısını döndürür
  bool get isDarkTheme => _isDarkTheme; // Tema durumunu (true: koyu, false: açık) döndürür

  /// Hive veritabanından mevcut kullanıcı tercihlerini okuyan metot
  void _loadSettings() {
    final box = HiveService.settingsBox; // Ayarlar tablosuna erişim sağlar
    // Günlük hedefi veritabanından çeker, henüz kayıt yoksa varsayılan değeri (100) atar
    _dailyGoal = box.get(AppConstants.keyDailyGoal, defaultValue: AppConstants.defaultDailyGoal) as int;
    // Tema tercihini çeker, kayıt yoksa varsayılan olarak açık temayı (false) atar
    _isDarkTheme = box.get(AppConstants.keyIsDarkTheme, defaultValue: false) as bool;
  }

  /// Yeni günlük soru hedefi belirler ve veritabanına kaydeder
  Future<void> setDailyGoal(int newGoal) async {
    if (newGoal <= 0) return; // 0 veya negatif geçersiz hedefleri kabul etmez
    _dailyGoal = newGoal; // Yerel değişkeni günceller
    await HiveService.settingsBox.put(AppConstants.keyDailyGoal, newGoal); // Kalıcı hafızaya yazar
    notifyListeners(); // Ekranların (UI) yeni hedefle güncellenmesini tetikler
  }

  /// Temayı açık ve koyu mod arasında tersine çevirir (Açıksa koyu, koyuysa açık yapar)
  Future<void> toggleTheme() async {
    _isDarkTheme = !_isDarkTheme; // Durumu tersine çevirir
    await HiveService.settingsBox.put(AppConstants.keyIsDarkTheme, _isDarkTheme); // Yeni tema tercihini kaydeder
    notifyListeners(); // Tüm uygulamanın renginin anında değişmesini sağlar
  }

  /// Temayı doğrudan istenilen değere (true/false) ayarlar
  Future<void> setTheme(bool isDark) async {
    _isDarkTheme = isDark; // Verilen boolean değeri atar
    await HiveService.settingsBox.put(AppConstants.keyIsDarkTheme, _isDarkTheme); // Veritabanına kaydeder
    notifyListeners(); // Arayüzü bilgilendirir
  }
}
