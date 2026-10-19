import 'package:flutter/material.dart';

/// [AppColors], Sırdaşım uygulamasının Material 3 açık tema
/// renk paletini barındıran merkezi renk tanımları sınıfıdır.
abstract final class AppColors {
  // Ana Renkler (Primary)
  static const Color primary = Color(0xFF4F46E5); // Canlı İndigo
  static const Color primaryContainer = Color(0xFFEEF2FF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF312E81);

  // İkincil Renkler (Secondary / Vurgu)
  static const Color secondary = Color(0xFF0EA5E9); // Gökyüzü Mavisi
  static const Color secondaryContainer = Color(0xFFE0F2FE);
  static const Color onSecondary = Color(0xFFFFFFFF);

  // Nötr Zemin & Yüzey Renkleri
  static const Color background = Color(0xFFF8FAFC); // Ferah kirli beyaz
  static const Color surface = Color(0xFFFFFFFF); // Kartlar ve modal yüzeyler
  static const Color surfaceVariant = Color(0xFFF1F5F9);
  static const Color border = Color(0xFFE2E8F0); // İnce ayırıcı çizgiler

  // Metin Renkleri
  static const Color textPrimary = Color(0xFF0F172A); // Koyu lacivert/siyah
  static const Color textSecondary = Color(0xFF475569); // Yardımcı metin
  static const Color textMuted = Color(0xFF94A3B8); // İpucu ve pasif metinler

  // Durum & Rozet Renkleri
  static const Color timeBadgeBackground = Color(0xFFFEF3C7); // Sıcak kehribar zemin
  static const Color timeBadgeText = Color(0xFF92400E); // Sıcak kehribar metin
  static const Color success = Color(0xFF10B981); // Zümrüt yeşili
  static const Color successContainer = Color(0xFFD1FAE5);
  static const Color error = Color(0xFFEF4444);
}
