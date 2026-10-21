import 'package:flutter/material.dart';
import '../storage/local_storage_service.dart';
import '../constants/app_constants.dart';

/// Tema yönetimi controller'ı
class ThemeController extends ChangeNotifier {
  static final ThemeController instance = ThemeController._internal();
  ThemeController._internal();

  ThemeMode _themeMode = ThemeMode.dark; // Varsayılan: Football Night (Koyu)

  ThemeMode get themeMode => _themeMode;

  Future<void> init() async {
    final savedMode = LocalStorageService.instance.getString(AppConstants.keyThemeMode);
    if (savedMode != null) {
      if (savedMode == 'light') {
        _themeMode = ThemeMode.light;
      } else if (savedMode == 'dark') {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.system;
      }
      notifyListeners();
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();

    String modeStr = 'dark';
    if (mode == ThemeMode.light) {
      modeStr = 'light';
    } else if (mode == ThemeMode.system) {
      modeStr = 'system';
    }
    await LocalStorageService.instance.setString(AppConstants.keyThemeMode, modeStr);
  }
}
