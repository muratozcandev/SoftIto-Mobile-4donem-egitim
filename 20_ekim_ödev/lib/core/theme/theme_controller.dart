<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: theme_controller.dart
// Görev: Uygulamanın açık (light) ve koyu (dark) tema durumunu reaktif yönetir.
// Açıklama: ValueNotifier kullanarak tüm widget ağacına anlık tema değişimini
// iletir ve harici paket bağımlılığını ortadan kaldırır.
// ==============================================================================

import 'package:flutter/material.dart';

/// [ThemeController] sınıfı, uygulamanın [ThemeMode] durumunu yöneten tekil sınıftır.
class ThemeController {
  // ---------------------------------------------------------------------------
  // Singleton Yapı
  // ---------------------------------------------------------------------------
  /// Tüm ekranlardan erişilebilen tekil yönetici örneği.
  static final ThemeController instance = ThemeController._internal();

  /// Özel kurucu.
  ThemeController._internal();

  // ---------------------------------------------------------------------------
  // Reaktif Durum
  // ---------------------------------------------------------------------------
  /// Aktif tema modunu tutan dinlenebilir değişken.
  /// Varsayılan tema olarak modern ve teknolojik olan Koyu Mod (dark) seçilmiştir.
  final ValueNotifier<ThemeMode> themeModeNotifier =
      ValueNotifier<ThemeMode>(ThemeMode.dark);

  /// Koyu temanın aktif olup olmadığını kontrol eden yardımcı getter.
  bool get isDarkMode => themeModeNotifier.value == ThemeMode.dark;

  // ---------------------------------------------------------------------------
  // Tema Değiştirme Metotları
  // ---------------------------------------------------------------------------
  /// Açık ve koyu tema arasında geçiş yapar.
  void toggleTheme() {
    themeModeNotifier.value =
        isDarkMode ? ThemeMode.light : ThemeMode.dark;
  }

  /// İstenilen tema modunu doğrudan ayarlar.
  void setThemeMode(ThemeMode mode) {
=======
>>>>>>> Stashed changes
import 'package:flutter/material.dart';

/// [ThemeController] sınıfı, uygulamanın tema modunu (Açık veya Koyu)
/// merkezi olarak yöneten ve durum değişikliklerini dinleyicilere bildiren sınıftır.
///
/// Proje kuralları gereği harici ağır paketler (Bloc, Riverpod vb.) yerine
/// Flutter'ın yerel ve performanslı [ValueNotifier] yapısını kullanır.
class ThemeController {
  // Singleton deseni: Tüm uygulama boyunca tek bir tema kontrolcüsü kullanılır
  ThemeController._internal();
  static final ThemeController instance = ThemeController._internal();

  /// Uygulamanın anlık tema modunu tutan reaktif bildirim nesnesi.
  /// Varsayılan olarak modern koyu tema (ThemeMode.dark) ile başlar.
  final ValueNotifier<ThemeMode> themeModeNotifier =
      ValueNotifier<ThemeMode>(ThemeMode.dark);

  /// Anlık temanın koyu mod olup olmadığını kontrol eden yardımcı getter.
  bool get isDarkMode => themeModeNotifier.value == ThemeMode.dark;

  /// Temayı açık ve koyu mod arasında tek dokunuşla değiştiren metod.
  void toggleTheme() {
    if (themeModeNotifier.value == ThemeMode.dark) {
      themeModeNotifier.value = ThemeMode.light;
    } else {
      themeModeNotifier.value = ThemeMode.dark;
    }
  }

  /// Belirli bir tema modunu doğrudan ayarlayan metod.
  /// [mode]: Uygulanmak istenen [ThemeMode] (dark veya light).
  void setTheme(ThemeMode mode) {
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
    themeModeNotifier.value = mode;
  }
}
