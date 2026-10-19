import 'package:flutter/foundation.dart';
import '../models/water_log_model.dart';

/// Su takip mantığını yöneten hafif reaktif kontrolcü
class WaterTrackerController {
  final ValueNotifier<int> currentWater = ValueNotifier<int>(750);
  final ValueNotifier<List<WaterLog>> logs = ValueNotifier<List<WaterLog>>([
    WaterLog(
      id: '1',
      amountMl: 250,
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    WaterLog(
      id: '2',
      amountMl: 500,
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ]);

  final int dailyGoal = 2500; // 2500 ml günlük hedef

  double get progressRatio => (currentWater.value / dailyGoal).clamp(0.0, 1.0);
  int get remainingWater => (dailyGoal - currentWater.value).clamp(0, dailyGoal);

  void addWater(int amount) {
    currentWater.value += amount;
    final newLog = WaterLog(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amountMl: amount,
      timestamp: DateTime.now(),
    );
    logs.value = [newLog, ...logs.value];
  }

  void resetWater() {
    currentWater.value = 0;
    logs.value = [];
  }

  void dispose() {
    currentWater.dispose();
    logs.dispose();
  }
}
