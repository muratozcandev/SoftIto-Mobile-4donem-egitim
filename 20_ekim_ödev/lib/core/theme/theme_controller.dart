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
    themeModeNotifier.value = mode;
  }
}
