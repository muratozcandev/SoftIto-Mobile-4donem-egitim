<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: locale_controller.dart
// Görev: Uygulama dilinin (Türkçe / İngilizce) dinamik yönetimini sağlar.
// Açıklama: Harici bir paket gerektirmeden, Flutter'ın çekirdek ValueNotifier yapısı
// kullanılarak anlık dil değişimini tüm ekranda tetikler.
// ==============================================================================

import 'package:flutter/material.dart';

/// [LocaleController] sınıfı, uygulamanın aktif dilini [Locale] nesnesi olarak tutar
/// ve dil değiştiğinde dinleyen tüm widget'ları yeniden derler.
class LocaleController {
  // ---------------------------------------------------------------------------
  // Tekil Örnek (Singleton Deseni)
  // ---------------------------------------------------------------------------
  /// Tüm uygulama genelinde tek bir dil yöneticisi örneği kullanılmasını sağlar.
  static final LocaleController instance = LocaleController._internal();

  /// Özel kurucu (private constructor).
  LocaleController._internal();

  // ---------------------------------------------------------------------------
  // Reaktif Durum Değişkeni
  // ---------------------------------------------------------------------------
  /// Aktif dili dinlenebilir şekilde saklayan [ValueNotifier].
  /// Varsayılan dil Türkçe ('tr') olarak ayarlanmıştır.
  final ValueNotifier<Locale> localeNotifier =
      ValueNotifier<Locale>(const Locale('tr', 'TR'));

  /// Kolaylık sağlayan yardımcı özellik: Aktif dilin İngilizce olup olmadığını döner.
  bool get isEnglish => localeNotifier.value.languageCode == 'en';

  // ---------------------------------------------------------------------------
  // Durum Değiştirme Metotları
  // ---------------------------------------------------------------------------
  /// Dili Türkçe ve İngilizce arasında iki yönlü değiştirir (Toggle).
  void toggleLocale() {
    if (localeNotifier.value.languageCode == 'tr') {
      localeNotifier.value = const Locale('en', 'US');
    } else {
      localeNotifier.value = const Locale('tr', 'TR');
    }
  }

  /// Dili doğrudan parametre ile belirler ('tr' veya 'en').
  void setLocale(String languageCode) {
    if (languageCode == 'en') {
      localeNotifier.value = const Locale('en', 'US');
    } else {
      localeNotifier.value = const Locale('tr', 'TR');
=======
>>>>>>> Stashed changes
import 'package:flutter/material.dart';

/// [LocaleController] sınıfı, uygulamanın aktif dilini (Türkçe veya İngilizce)
/// reaktif biçimde yönetir ve dil değişiminde arayüzü anında günceller.
class LocaleController {
  // Singleton deseni: Tek bir dil yöneticisi üzerinden işlem yapılır
  LocaleController._internal();
  static final LocaleController instance = LocaleController._internal();

  /// Aktif dili tutan reaktif ValueNotifier nesnesi (Varsayılan: 'tr' - Türkçe)
  final ValueNotifier<String> localeNotifier = ValueNotifier<String>('tr');

  /// Aktif dilin Türkçe olup olmadığını bildiren yardımcı getter
  bool get isTurkish => localeNotifier.value == 'tr';

  /// Dili Türkçe ve İngilizce arasında değiştiren metod
  void toggleLocale() {
    localeNotifier.value = isTurkish ? 'en' : 'tr';
  }

  /// İstenen dili doğrudan ayarlayan metod ('tr' veya 'en')
  void setLocale(String langCode) {
    if (langCode == 'tr' || langCode == 'en') {
      localeNotifier.value = langCode;
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
    }
  }
}
