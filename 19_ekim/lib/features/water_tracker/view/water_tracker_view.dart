import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../controller/water_controller.dart';
import '../widget/quick_add_buttons.dart';
import '../widget/water_goal_card.dart';
import '../widget/water_history_tile.dart';
import '../widget/water_progress_indicator.dart';

/// Su takip ana görünüm ekranı
class WaterTrackerView extends StatelessWidget {
  final WaterController controller;

  const WaterTrackerView({
    super.key,
    required this.controller,
  });

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
              _buildProgressSection(),
              const SizedBox(height: 24),
              _buildGoalSection(),
              const SizedBox(height: 24),
              _buildQuickActionsSection(),
              const SizedBox(height: 28),
              _buildHistorySection(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgressSection() {
    return WaterProgressIndicatorWidget(
      progressRatio: controller.progressRatio,
      totalConsumed: controller.totalConsumedInMl,
      dailyGoal: controller.dailyGoalInMl,
    );
  }

  Widget _buildGoalSection() {
    return WaterGoalCardWidget(
      remainingInMl: controller.remainingInMl,
      isCompleted: controller.isGoalCompleted,
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hızlı Ekle',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        QuickAddButtonsWidget(
          onAdd: (amount) => controller.addWater(amount),
        ),
      ],
    );
  }

  Widget _buildHistorySection() {
    final entries = controller.entries;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bugünkü Kayıtlar',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        if (entries.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text(
                'Henüz kayıt yok. İlk bardağını ekle!',
                style: TextStyle(color: AppColors.textMuted, fontSize: 14),
              ),
            ),
          )
        else
          ...entries.map(
            (entry) => WaterHistoryTileWidget(
              entry: entry,
              onDelete: () => controller.removeEntry(entry.id),
            ),
          ),
      ],
    );
  }
}
