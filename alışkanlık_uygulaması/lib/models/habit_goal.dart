import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

enum HabitCategory {
  calorie,
  water,
  step,
  sleep,
}

class HabitGoal {
  final String id;
  final String title;
  final HabitCategory category;
  final String unit;
  final double targetValue;
  final double currentValue;
  final IconData icon;
  final Color color;

  const HabitGoal({
    required this.id,
    required this.title,
    required this.category,
    required this.unit,
    required this.targetValue,
    required this.currentValue,
    required this.icon,
    required this.color,
  });

  /// Tamamlanma yüzdesi [0.0 - 100.0] aralığına sınırlandırılmıştır
  double get percentage {
    if (targetValue <= 0) return 0.0;
    final pct = (currentValue / targetValue) * 100;
    return pct.clamp(0.0, 100.0);
  }

  /// İlerleme barı için oran [0.0 - 1.0]
  double get progressRatio {
    if (targetValue <= 0) return 0.0;
    return (currentValue / targetValue).clamp(0.0, 1.0);
  }

  /// Hedef tamamlandı mı?
  bool get isCompleted => targetValue > 0 && currentValue >= targetValue;

  HabitGoal copyWith({
    String? id,
    String? title,
    HabitCategory? category,
    String? unit,
    double? targetValue,
    double? currentValue,
    IconData? icon,
    Color? color,
  }) {
    return HabitGoal(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      targetValue: targetValue ?? this.targetValue,
      currentValue: currentValue ?? this.currentValue,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }

  static List<HabitGoal> getDefaultHabits() {
    return [
      const HabitGoal(
        id: 'calorie',
        title: 'Kalori Hedefi',
        category: HabitCategory.calorie,
        unit: 'kcal',
        targetValue: 2200,
        currentValue: 1650,
        icon: Icons.local_fire_department_rounded,
        color: AppColors.calorieColor,
      ),
      const HabitGoal(
        id: 'water',
        title: 'Su Tüketimi',
        category: HabitCategory.water,
        unit: 'ml',
        targetValue: 2500,
        currentValue: 2000,
        icon: Icons.water_drop_rounded,
        color: AppColors.waterColor,
      ),
      const HabitGoal(
        id: 'step',
        title: 'Günlük Adım',
        category: HabitCategory.step,
        unit: 'adım',
        targetValue: 10000,
        currentValue: 8450,
        icon: Icons.directions_walk_rounded,
        color: AppColors.stepColor,
      ),
      const HabitGoal(
        id: 'sleep',
        title: 'Uyku Süresi',
        category: HabitCategory.sleep,
        unit: 'saat',
        targetValue: 8.0,
        currentValue: 7.5,
        icon: Icons.bedtime_rounded,
        color: AppColors.sleepColor,
      ),
    ];
  }
}
