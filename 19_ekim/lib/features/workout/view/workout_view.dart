import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../controller/workout_controller.dart';
import '../widgets/add_workout_bottom_sheet.dart';
import '../widgets/workout_item_tile.dart';
import '../widgets/workout_summary_card.dart';

/// Egzersiz ve aktivite ana ekranı
class WorkoutView extends StatelessWidget {
  final WorkoutController controller;

  const WorkoutView({
    super.key,
    required this.controller,
  });

  void _openAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => AddWorkoutBottomSheet(
        onAdd: ({
          required title,
          required type,
          required durationMinutes,
          required burnedCalories,
        }) {
          controller.addWorkout(
            title: title,
            type: type,
            durationMinutes: durationMinutes,
            burnedCalories: burnedCalories,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSummarySection(),
              const SizedBox(height: 24),
              _buildAddAction(context),
              const SizedBox(height: 24),
              _buildWorkoutListSection(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummarySection() {
    return WorkoutSummaryCardWidget(
      totalMinutes: controller.totalDurationMinutes,
      totalCalories: controller.totalCaloriesBurned,
    );
  }

  Widget _buildAddAction(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _openAddSheet(context),
      icon: const Icon(Icons.add, color: AppColors.background),
      label: const Text(
        'Yeni Egzersiz Ekle',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: AppColors.background,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.neonGreen,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildWorkoutListSection() {
    final workouts = controller.workouts;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tamamlanan Aktiviteler',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        if (workouts.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Text(
                'Henüz egzersiz kaydı bulunmuyor.',
                style: TextStyle(color: AppColors.textMuted, fontSize: 14),
              ),
            ),
          )
        else
          ...workouts.map(
            (workout) => WorkoutItemTileWidget(
              workout: workout,
              onDelete: () => controller.removeWorkout(workout.id),
            ),
          ),
      ],
    );
  }
}
