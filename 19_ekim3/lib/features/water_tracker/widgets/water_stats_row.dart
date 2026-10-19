import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/water_tracker_controller.dart';

class WaterStatsRow extends StatelessWidget {
  final WaterTrackerController controller;

  const WaterStatsRow({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: controller.currentWater,
      builder: (context, current, _) {
        final remaining = controller.remainingWater;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'Kalan Su',
                  value: '$remaining ml',
                  icon: Icons.hourglass_bottom,
                  accentColor: AppColors.neonCyan,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: _StatCard(
                  title: 'Yakılan Kalori',
                  value: '420 kcal',
                  icon: Icons.local_fire_department,
                  accentColor: AppColors.neonOrange,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: _StatCard(
                  title: 'Egzersiz Süresi',
                  value: '35 dk',
                  icon: Icons.timer,
                  accentColor: AppColors.neonGreen,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color accentColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.surfaceBorder : AppColors.lightSurfaceBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accentColor, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              color: theme.textTheme.bodySmall?.color,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
