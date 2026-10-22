import 'package:flutter/material.dart';
import 'habit_goal.dart';

class BadgeItem {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final HabitCategory? targetCategory;

  const BadgeItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.isUnlocked = false,
    this.unlockedAt,
    this.targetCategory,
  });

  BadgeItem copyWith({
    String? id,
    String? title,
    String? description,
    IconData? icon,
    Color? color,
    bool? isUnlocked,
    DateTime? unlockedAt,
    HabitCategory? targetCategory,
  }) {
    return BadgeItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      targetCategory: targetCategory ?? this.targetCategory,
    );
  }

  static List<BadgeItem> getDefaultBadges() {
    return [
      const BadgeItem(
        id: 'calorie_master',
        title: 'Kalori Şampiyonu',
        description: 'Günlük kalori hedefine tam başarıyla ulaştın.',
        icon: Icons.local_fire_department_rounded,
        color: Color(0xFFF97316),
        isUnlocked: false,
        targetCategory: HabitCategory.calorie,
      ),
      const BadgeItem(
        id: 'water_master',
        title: 'Su Ustası',
        description: 'Hedeflenen günlük su miktarını eksiksiz tamamladın.',
        icon: Icons.water_drop_rounded,
        color: Color(0xFF06B6D4),
        isUnlocked: false,
        targetCategory: HabitCategory.water,
      ),
      const BadgeItem(
        id: 'step_master',
        title: 'Adım Rekortmeni',
        description: '10.000 adım hedefini geçerek harika bir hareket sağladın.',
        icon: Icons.directions_walk_rounded,
        color: Color(0xFF10B981),
        isUnlocked: false,
        targetCategory: HabitCategory.step,
      ),
      const BadgeItem(
        id: 'sleep_master',
        title: 'Düzenli Uyku Rozeti',
        description: 'Vücuduna hak ettiği kaliteli ve dinlendirici uykuyu verdin.',
        icon: Icons.bedtime_rounded,
        color: Color(0xFF8B5CF6),
        isUnlocked: false,
        targetCategory: HabitCategory.sleep,
      ),
      BadgeItem(
        id: 'first_step',
        title: 'İlk Adım',
        description: 'Alışkanlık Takibi uygulamasına katıldın ve hedeflerini belirledin.',
        icon: Icons.flag_rounded,
        color: const Color(0xFF3B82F6),
        isUnlocked: true,
        unlockedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      const BadgeItem(
        id: 'streak_3',
        title: '3 Günlük Seri',
        description: 'Üst üste 3 gün boyunca tüm alışkanlıklarını güncelledin.',
        icon: Icons.bolt_rounded,
        color: Color(0xFFEAB308),
        isUnlocked: false,
      ),
    ];
  }
}
