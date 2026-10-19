import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/workout_entry.dart';

/// Tekil antrenman kayıt kartı bileşeni
class WorkoutItemTileWidget extends StatelessWidget {
  final WorkoutEntry workout;
  final VoidCallback onDelete;

  const WorkoutItemTileWidget({
    super.key,
    required this.workout,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Row(
        children: [
          _buildLeadingIcon(),
          const SizedBox(width: 14),
          _buildTitleAndDetails(),
          _buildTrailingActions(),
        ],
      ),
    );
  }

  Widget _buildLeadingIcon() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: workout.type.accentColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(
        workout.type.icon,
        color: workout.type.accentColor,
        size: 22,
      ),
    );
  }

  Widget _buildTitleAndDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            workout.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${workout.type.label} • ${workout.durationMinutes} dk • ${workout.burnedCalories} kcal',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrailingActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          workout.formattedTime,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 6),
        IconButton(
          icon: const Icon(Icons.close, size: 18, color: AppColors.textMuted),
          onPressed: onDelete,
          splashRadius: 18,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
