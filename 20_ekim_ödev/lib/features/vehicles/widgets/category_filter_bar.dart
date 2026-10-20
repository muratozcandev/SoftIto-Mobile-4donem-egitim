import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/theme_controller.dart';
import '../controllers/vehicle_controller.dart';

/// [CategoryFilterBar] widget'ı, araç tiplerini (Tümü, Sedan, SUV, Elektrikli, Spor)
/// yatayda kaydırılabilir şık hap butonlar şeklinde listeleyen filtre çubuğudur.
class CategoryFilterBar extends StatelessWidget {
  const CategoryFilterBar({super.key});

  static const List<Map<String, dynamic>> categories = [
    {'label': 'Tümü', 'icon': Icons.grid_view_rounded},
    {'label': 'Sedan', 'icon': Icons.directions_car_filled_outlined},
    {'label': 'SUV', 'icon': Icons.airport_shuttle_outlined},
    {'label': 'Elektrikli', 'icon': Icons.bolt_outlined},
    {'label': 'Spor', 'icon': Icons.sports_motorsports_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeController.instance.isDarkMode;

    return ValueListenableBuilder<String>(
      valueListenable: VehicleController.instance.selectedCategoryNotifier,
      builder: (context, selectedCategory, _) {
        return SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final cat = categories[index];
              final label = cat['label'] as String;
              final icon = cat['icon'] as IconData;
              final isSelected = selectedCategory == label;

              return InkWell(
                onTap: () {
                  VehicleController.instance.selectCategory(label);
                },
                borderRadius: BorderRadius.circular(14),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : (isDark
                            ? AppColors.darkSurface
                            : AppColors.lightSurface),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : (isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder),
                      width: 1.2,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withAlpha(80),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        size: 16,
                        color: isSelected
                            ? Colors.black
                            : (isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w600,
                          color: isSelected
                              ? Colors.black
                              : (isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.lightTextPrimary),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
