import 'package:shared_preferences/shared_preferences.dart';

/// Tutturdum yerel depolama servisi
class LocalStorageService {
  static final LocalStorageService instance = LocalStorageService._internal();
  LocalStorageService._internal();

  SharedPreferences? _prefs;
  final Map<String, dynamic> _memoryCache = {};

  Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (_) {
      // Test ortamlarında veya fallback durumunda memoryCache kullanılır
    }
  }

  String? getString(String key) {
    if (_prefs != null) {
      return _prefs!.getString(key) ?? (_memoryCache[key] as String?);
    }
    return _memoryCache[key] as String?;
  }

  Future<bool> setString(String key, String value) async {
    _memoryCache[key] = value;
    if (_prefs != null) {
      return _prefs!.setString(key, value);
    }
    return true;
  }

  double? getDouble(String key) {
    if (_prefs != null) {
      return _prefs!.getDouble(key) ?? (_memoryCache[key] as double?);
    }
    return _memoryCache[key] as double?;
  }

  Future<bool> setDouble(String key, double value) async {
    _memoryCache[key] = value;
    if (_prefs != null) {
      return _prefs!.setDouble(key, value);
    }
    return true;
  }

  bool? getBool(String key) {
    if (_prefs != null) {
      return _prefs!.getBool(key) ?? (_memoryCache[key] as bool?);
    }
    return _memoryCache[key] as bool?;
  }

  Future<bool> setBool(String key, bool value) async {
    _memoryCache[key] = value;
    if (_prefs != null) {
      return _prefs!.setBool(key, value);
    }
    return true;
  }

  Future<bool> remove(String key) async {
    _memoryCache.remove(key);
    if (_prefs != null) {
      return _prefs!.remove(key);
    }
    return true;
  }

  Future<bool> clear() async {
    _memoryCache.clear();
    if (_prefs != null) {
      return _prefs!.clear();
    }
    return true;
  }
}
