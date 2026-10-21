import 'package:flutter/material.dart';

/// Tutturdum merkezi renk paleti
/// project.md şartnamesine uygun olarak Football Night (koyu) ve Stadium Light (açık) temaları tanımlanmıştır.
abstract class AppColors {
  // Football Night - Koyu Tema
  static const Color darkBackground = Color(0xFF0B0F14);
  static const Color darkSecondaryBackground = Color(0xFF121922);
  static const Color darkCardSurface = Color(0xFF19232D);
  static const Color darkPrimaryAccent = Color(0xFF22C55E); // Zümrüt Yeşili
  static const Color darkSecondaryAccent = Color(0xFF38BDF8); // Gökyüzü Mavisi
  static const Color darkPrimaryText = Color(0xFFF8FAFC);
  static const Color darkSecondaryText = Color(0xFF94A3B8);
  static const Color darkError = Color(0xFFEF4444);
  static const Color darkDivider = Color(0xFF2A3642);

  // Stadium Light - Aydınlık Tema
  static const Color lightBackground = Color(0xFFF5F7FA);
  static const Color lightSecondaryBackground = Color(0xFFFFFFFF);
  static const Color lightCardSurface = Color(0xFFFFFFFF);
  static const Color lightPrimaryAccent = Color(0xFF16A34A);
  static const Color lightSecondaryAccent = Color(0xFF0284C7);
  static const Color lightPrimaryText = Color(0xFF17212B);
  static const Color lightSecondaryText = Color(0xFF64748B);
  static const Color lightError = Color(0xFFDC2626);
  static const Color lightDivider = Color(0xFFE2E8F0);

  // Ortak Renkler
  static const Color gold = Color(0xFFF59E0B);
  static const Color silver = Color(0xFF9CA3AF);
  static const Color bronze = Color(0xFFD97706);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
}
