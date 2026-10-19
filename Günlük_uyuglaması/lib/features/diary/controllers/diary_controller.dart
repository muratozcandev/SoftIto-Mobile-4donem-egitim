import 'package:flutter/foundation.dart';
import '../../../core/utils/date_formatter.dart';
import '../models/diary_entry.dart';

/// [DiaryController], Flutter'ın yerel [ChangeNotifier] API'sini kullanarak
/// sayfa düzeyinde ağır `setState` çağrılarına gerek kalmadan durum yönetimini sağlar.
class DiaryController extends ChangeNotifier {
  DiaryController() {
    _initSampleData();
  }

  DateTime _selectedDate = DateTime.now();
  DateTime _displayMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
  String _selectedMood = '😊';
  final Map<String, DiaryEntry> _entries = <String, DiaryEntry>{};

  DateTime get selectedDate => _selectedDate;
  DateTime get displayMonth => _displayMonth;
  String get selectedMood => _selectedMood;
  Map<String, DiaryEntry> get entries => Map<String, DiaryEntry>.unmodifiable(_entries);

  /// Seçili güne ait mevcut günlük kaydını döner (yoksa null)
  DiaryEntry? get currentEntry {
    final String key = DateFormatter.toDateKey(_selectedDate);
    return _entries[key];
  }

  /// Belirli bir günde kayıt var mı kontrolü
  bool hasEntryOn(DateTime date) {
    return _entries.containsKey(DateFormatter.toDateKey(date));
  }

  /// Ruh hali seçimi
  void setMood(String mood) {
    if (_selectedMood == mood) return;
    _selectedMood = mood;
    notifyListeners();
  }

  /// Gün seçimi
  void selectDate(DateTime date) {
    if (_selectedDate.year == date.year &&
        _selectedDate.month == date.month &&
        _selectedDate.day == date.day) {
      return;
    }
    _selectedDate = date;
    // Seçili günün mevcut ruh halini yükle, yoksa varsayılan
    final String key = DateFormatter.toDateKey(date);
    _selectedMood = _entries[key]?.mood ?? '😊';

    // Eğer seçilen gün görüntülenen aydan farklıysa ayı da güncelle
    if (_displayMonth.month != date.month || _displayMonth.year != date.year) {
      _displayMonth = DateTime(date.year, date.month, 1);
    }
    notifyListeners();
  }

  /// Sonraki aya geçiş
  void nextMonth() {
    _displayMonth = DateTime(_displayMonth.year, _displayMonth.month + 1, 1);
    notifyListeners();
  }

  /// Önceki aya geçiş
  void previousMonth() {
    _displayMonth = DateTime(_displayMonth.year, _displayMonth.month - 1, 1);
    notifyListeners();
  }

  /// Bugüne dön
  void jumpToToday() {
    final DateTime now = DateTime.now();
    _selectedDate = now;
    _displayMonth = DateTime(now.year, now.month, 1);
    notifyListeners();
  }

  /// Günlük kaydını ekleme / güncelleme
  void saveEntry({
    required String title,
    required String content,
    required String mood,
  }) {
    final String key = DateFormatter.toDateKey(_selectedDate);
    final DateTime now = DateTime.now();
    final String timeStr = DateFormatter.formatTime(now);

    final DiaryEntry existing = _entries[key] ??
        DiaryEntry(
          id: key,
          date: _selectedDate,
          time: timeStr,
          title: title,
          content: content,
          mood: mood,
          createdAt: now,
          updatedAt: now,
        );

    _entries[key] = existing.copyWith(
      title: title.trim(),
      content: content.trim(),
      mood: mood,
      time: timeStr,
      updatedAt: now,
    );

    notifyListeners();
  }

  /// Test ve ilk deneyim için örnek günlük verileri
  void _initSampleData() {
    final DateTime now = DateTime.now();
    final String todayKey = DateFormatter.toDateKey(now);
    final String todayTime = DateFormatter.formatTime(now);

    _entries[todayKey] = DiaryEntry(
      id: todayKey,
      date: now,
      time: todayTime,
      title: 'Sırdaşım İle Yeni Bir Başlangıç',
      content:
          'Bugün yeni akıllı günlüğüm Sırdaşım ile ilk yazımı yazıyorum. '
          'Temiz, sade ve düşüncelerimi saklamak için harika bir his veriyor.',
      mood: '✨',
      createdAt: now,
      updatedAt: now,
    );

    final DateTime yesterday = now.subtract(const Duration(days: 1));
    final String yesterdayKey = DateFormatter.toDateKey(yesterday);
    _entries[yesterdayKey] = DiaryEntry(
      id: yesterdayKey,
      date: yesterday,
      time: '21:15',
      title: 'Huzurlu Bir Akşamüstü',
      content:
          'Kahvemi alıp balkonda kitap okudum. Sakin ve dingin bir gün oldu.',
      mood: '☕',
      createdAt: yesterday,
      updatedAt: yesterday,
    );
  }
}
