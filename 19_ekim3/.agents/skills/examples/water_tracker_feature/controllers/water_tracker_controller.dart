import 'package:flutter/foundation.dart';
import '../models/water_log_model.dart';

/// Su takip iş mantığını ve durum bildirimlerini yöneten Controller
class WaterTrackerController {
  /// Mevcut tüketilen su miktarı (ml)
  final ValueNotifier<int> currentWater = ValueNotifier<int>(0);

  /// Tüketim işlem günlüğü
  final ValueNotifier<List<WaterLog>> logs = ValueNotifier<List<WaterLog>>([]);

  /// Günlük hedef (ml)
  final int dailyGoal = 2500;

  /// Hedefe ulaşma oranı [0.0 - 1.0] aralığında sınırlandırılmış
  double get progressRatio => (currentWater.value / dailyGoal).clamp(0.0, 1.0);

  /// Kalan su miktarı (ml)
  int get remainingWater => (dailyGoal - currentWater.value).clamp(0, dailyGoal);

  /// Belirtilen miktarda su ekler
  void addWater(int amount) {
    if (amount <= 0) return;

    currentWater.value += amount;

    final newLog = WaterLog(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amountMl: amount,
      timestamp: DateTime.now(),
    );

    // DİKKAT: Reaktif bildirim için yeni liste örneği atanmalıdır
    logs.value = [newLog, ...logs.value];
  }

  /// Tüketimi ve günlüğü sıfırlar
  void resetWater() {
    currentWater.value = 0;
    logs.value = [];
  }

  /// Reaktif kaynakları bellekten serbest bırakır
  void dispose() {
    currentWater.dispose();
    logs.dispose();
  }
}
