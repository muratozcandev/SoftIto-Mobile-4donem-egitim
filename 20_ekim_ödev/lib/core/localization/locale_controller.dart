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
    }
  }
}
