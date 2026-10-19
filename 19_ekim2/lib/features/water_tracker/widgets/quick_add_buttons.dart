import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/water_tracker_controller.dart';

class QuickAddButtons extends StatelessWidget {
  final WaterTrackerController controller;

  const QuickAddButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _QuickAddCard(
              amount: 250,
              label: 'Bardak',
              icon: Icons.local_drink,
              color: AppColors.neonCyan,
              onTap: () => controller.addWater(250),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _QuickAddCard(
              amount: 500,
              label: 'Şişe',
              icon: Icons.sports_bar,
              color: AppColors.neonBlue,
              onTap: () => controller.addWater(500),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _QuickAddCard(
              amount: 1000,
              label: 'Termos',
              icon: Icons.fitness_center,
              color: AppColors.neonGreen,
              onTap: () => controller.addWater(1000),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAddCard extends StatelessWidget {
  final int amount;
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickAddCard({
    required this.amount,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: theme.cardTheme.color ?? theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withAlpha(isDark ? 77 : 120),
            width: 1.2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(
              '+$amount ml',
              style: TextStyle(
                color: theme.textTheme.bodyLarge?.color,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: theme.textTheme.bodySmall?.color,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
