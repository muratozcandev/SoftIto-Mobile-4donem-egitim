import 'package:flutter/material.dart';

/// Dinamik tema modunu (Koyu/Aydınlık) yöneten reaktif kontrolcü
class ThemeController {
  final ValueNotifier<ThemeMode> themeMode;

  ThemeController({ThemeMode initialMode = ThemeMode.dark})
      : themeMode = ValueNotifier<ThemeMode>(initialMode);

  bool get isDarkMode => themeMode.value == ThemeMode.dark;

  void toggleTheme() {
    if (themeMode.value == ThemeMode.dark) {
      themeMode.value = ThemeMode.light;
    } else {
      themeMode.value = ThemeMode.dark;
    }
  }

  void setTheme(ThemeMode mode) {
    themeMode.value = mode;
  }

  void dispose() {
    themeMode.dispose();
  }
}
