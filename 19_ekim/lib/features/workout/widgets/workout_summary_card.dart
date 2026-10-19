import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Günlük egzersiz ve yakılan kalori özet paneli
class WorkoutSummaryCardWidget extends StatelessWidget {
  final int totalMinutes;
  final int totalCalories;

  const WorkoutSummaryCardWidget({
    super.key,
    required this.totalMinutes,
    required this.totalCalories,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricTile(
            label: 'Toplam Süre',
            value: '$totalMinutes dk',
            icon: Icons.timer_outlined,
            accentColor: AppColors.neonGreen,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _buildMetricTile(
            label: 'Yakılan Kalori',
            value: '$totalCalories kcal',
            icon: Icons.local_fire_department_outlined,
            accentColor: AppColors.neonOrange,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricTile({
    required String label,
    required String value,
    required IconData icon,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accentColor, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
