import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/theme_controller.dart';

/// [VehicleSpecChip] widget'ı, araç kartlarında ve detay sayfasında
/// vites, beygir gücü, yakıt türü gibi teknik verileri ikonla gösteren mikro-etikettir.
class VehicleSpecChip extends StatelessWidget {
  /// Sol taraftaki küçük ikon
  final IconData icon;

  /// Etiket metni (Örn: "Otomatik", "1020 HP", "Elektrik")
  final String label;

  /// Vurgulu renk mi kullanılacak?
  final bool isHighlighted;

  /// Kurucu metod
  const VehicleSpecChip({
    super.key,
    required this.icon,
    required this.label,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeController.instance.isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isHighlighted
            ? AppColors.primary.withAlpha(isDark ? 40 : 25)
            : (isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurfaceElevated),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isHighlighted
              ? AppColors.primary.withAlpha(120)
              : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: isHighlighted ? AppColors.primary : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w600,
              color: isHighlighted
                  ? AppColors.primary
                  : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
