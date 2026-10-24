// ==============================================================================
// Dosya: damage_photo_slot.dart
// Görev: Aracın ön, arka, sol veya sağ cephesinin fotoğraf çekim yuvası widget'ı.
// Açıklama: Çekim öncesi ve sonrası durumları dinamik simgeler, onay rozetleri
// ve renkli kenarlıklar ile görselleştirir.
// ==============================================================================

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// [DamagePhotoSlot] widget'ı, tek bir araç cephesinin fotoğraf çekim kartıdır.
class DamagePhotoSlot extends StatelessWidget {
  /// Cephe adı (Örn: Ön Cephe, Arka Cephe)
  final String title;

  /// Fotoğrafın çekilip çekilmediği
  final bool isCaptured;

  /// Tıklama aksiyonu
  final VoidCallback onTap;

  /// Cepheye uygun simge
  final IconData icon;

  const DamagePhotoSlot({
    super.key,
    required this.title,
    required this.isCaptured,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isCaptured
              ? AppColors.success.withValues(alpha: isDark ? 0.12 : 0.08)
              : (isDark ? AppColors.darkSurface : AppColors.lightSurface),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCaptured
                ? AppColors.success
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isCaptured ? 1.8 : 1.2,
          ),
          boxShadow: isCaptured
              ? [
                  BoxShadow(
                    color: AppColors.success.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Simge ve Durum Rozeti
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isCaptured
                        ? AppColors.success.withValues(alpha: 0.2)
                        : AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCaptured ? Icons.camera_alt_rounded : icon,
                    size: 28,
                    color: isCaptured ? AppColors.success : AppColors.primary,
                  ),
                ),
                if (isCaptured)
                  const Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: AppColors.success,
                      child: Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),

            // Başlık
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),

            // Durum İpucu Metni
            Text(
              isCaptured ? 'Fotoğraf Çekildi' : 'Çekmek İçin Dokun',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isCaptured
                    ? AppColors.success
                    : (isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
