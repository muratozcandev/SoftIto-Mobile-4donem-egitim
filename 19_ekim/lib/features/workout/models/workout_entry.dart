import 'package:flutter/material.dart';

/// Egzersiz türleri
enum WorkoutType {
  cardio('Kardiyo', Icons.directions_run, Color(0xFFFF6B00)),
  strength('Ağırlık & Fitness', Icons.fitness_center, Color(0xFF10E775)),
  cycling('Bisiklet', Icons.directions_bike, Color(0xFF00F0FF)),
  yoga('Yoga & Esneme', Icons.self_improvement, Color(0xFF9D00FF)),
  swimming('Yüzme', Icons.pool, Color(0xFF0070F3));

  final String label;
  final IconData icon;
  final Color accentColor;

  const WorkoutType(this.label, this.icon, this.accentColor);
}

/// Egzersiz aktivite modeli
class WorkoutEntry {
  final String id;
  final String title;
  final WorkoutType type;
  final int durationMinutes;
  final int burnedCalories;
  final DateTime timestamp;

  const WorkoutEntry({
    required this.id,
    required this.title,
    required this.type,
    required this.durationMinutes,
    required this.burnedCalories,
    required this.timestamp,
  });

  String get formattedTime {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
