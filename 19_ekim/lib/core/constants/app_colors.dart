import 'package:flutter/material.dart';

/// Dark Obsidian & Neon gece spor salonu renk paleti
abstract final class AppColors {
  // Arka Plan & Yüzey (Dark Obsidian)
  static const Color background = Color(0xFF0B0E14);
  static const Color surface = Color(0xFF151922);
  static const Color surfaceElevated = Color(0xFF1E2430);
  static const Color surfaceBorder = Color(0xFF2B3344);

  // Neon Vurgu Renkleri
  static const Color neonCyan = Color(0xFF00F0FF); // Su & Hidrasyon
  static const Color neonBlue = Color(0xFF0070F3);
  static const Color neonGreen = Color(0xFF10E775); // Egzersiz & Tamamlama
  static const Color neonOrange = Color(0xFFFF6B00); // Kalori & Enerji
  static const Color neonPurple = Color(0xFF9D00FF);

  // Metin Renkleri
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Yardımcı & Fonksiyonel Renkler
  static const Color error = Color(0xFFFF3B30);
  static const Color success = Color(0xFF10E775);
}
