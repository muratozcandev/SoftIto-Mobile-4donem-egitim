import 'package:flutter/foundation.dart';
import '../models/workout_entry.dart';

/// Egzersiz ve kalori yönetimi için çekirdek state yöneticisi
class WorkoutController extends ChangeNotifier {
  final List<WorkoutEntry> _workouts = [];

  WorkoutController() {
    // Başlangıç için örnek antrenman verileri
    _workouts.addAll([
      WorkoutEntry(
        id: 'w1',
        title: 'Sabah Koşusu',
        type: WorkoutType.cardio,
        durationMinutes: 30,
        burnedCalories: 280,
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      ),
      WorkoutEntry(
        id: 'w2',
        title: 'Göğüs & Kol Antrenmanı',
        type: WorkoutType.strength,
        durationMinutes: 45,
        burnedCalories: 340,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ]);
  }

  List<WorkoutEntry> get workouts => List.unmodifiable(_workouts);

  int get totalCaloriesBurned {
    return _workouts.fold<int>(0, (sum, item) => sum + item.burnedCalories);
  }

  int get totalDurationMinutes {
    return _workouts.fold<int>(0, (sum, item) => sum + item.durationMinutes);
  }

  void addWorkout({
    required String title,
    required WorkoutType type,
    required int durationMinutes,
    required int burnedCalories,
  }) {
    _workouts.insert(
      0,
      WorkoutEntry(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: title,
        type: type,
        durationMinutes: durationMinutes,
        burnedCalories: burnedCalories,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void removeWorkout(String id) {
    _workouts.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearAll() {
    _workouts.clear();
    notifyListeners();
  }
}
