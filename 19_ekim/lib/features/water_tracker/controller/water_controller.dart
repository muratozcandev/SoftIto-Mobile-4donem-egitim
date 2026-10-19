import 'package:flutter/foundation.dart';
import '../models/water_entry.dart';

/// Su tüketim takibi için çekirdek state yöneticisi
class WaterController extends ChangeNotifier {
  int _dailyGoalInMl = 2500;
  final List<WaterEntry> _entries = [];

  WaterController() {
    // İlk başlangıç için örnek kayıtlar
    _entries.addAll([
      WaterEntry(
        id: '1',
        amountInMl: 300,
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        note: 'Sabah uyanış suyu',
      ),
      WaterEntry(
        id: '2',
        amountInMl: 500,
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        note: 'Antrenman öncesi hidrasyon',
      ),
    ]);
  }

  int get dailyGoalInMl => _dailyGoalInMl;
  List<WaterEntry> get entries => List.unmodifiable(_entries);

  int get totalConsumedInMl {
    return _entries.fold<int>(0, (sum, item) => sum + item.amountInMl);
  }

  double get progressRatio {
    if (_dailyGoalInMl <= 0) return 0.0;
    return (totalConsumedInMl / _dailyGoalInMl).clamp(0.0, 1.0);
  }

  int get remainingInMl {
    final diff = _dailyGoalInMl - totalConsumedInMl;
    return diff < 0 ? 0 : diff;
  }

  bool get isGoalCompleted => totalConsumedInMl >= _dailyGoalInMl;

  void addWater(int amountInMl, {String? note}) {
    if (amountInMl <= 0) return;
    _entries.insert(
      0,
      WaterEntry(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        amountInMl: amountInMl,
        timestamp: DateTime.now(),
        note: note,
      ),
    );
    notifyListeners();
  }

  void removeEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    notifyListeners();
  }

  void updateDailyGoal(int newGoalInMl) {
    if (newGoalInMl > 0) {
      _dailyGoalInMl = newGoalInMl;
      notifyListeners();
    }
  }

  void resetToday() {
    _entries.clear();
    notifyListeners();
  }
}
