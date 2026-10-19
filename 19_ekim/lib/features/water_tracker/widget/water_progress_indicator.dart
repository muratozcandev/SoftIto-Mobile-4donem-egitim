import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Dairesel neon su tüketim ilerleme göstergesi
class WaterProgressIndicatorWidget extends StatelessWidget {
  final double progressRatio;
  final int totalConsumed;
  final int dailyGoal;

  const WaterProgressIndicatorWidget({
    super.key,
    required this.progressRatio,
    required this.totalConsumed,
    required this.dailyGoal,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progressRatio * 100).toInt();

    return Center(
      child: SizedBox(
        width: 220,
        height: 220,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildCircularBar(),
            _buildCenterMetrics(percent),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularBar() {
    return SizedBox(
      width: 200,
      height: 200,
      child: CircularProgressIndicator(
        value: progressRatio,
        strokeWidth: 14,
        backgroundColor: AppColors.surfaceBorder,
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.neonCyan),
        strokeCap: StrokeCap.round,
      ),
    );
  }

  Widget _buildCenterMetrics(int percent) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.water_drop, color: AppColors.neonCyan, size: 36),
        const SizedBox(height: 6),
        Text(
          '$totalConsumed ml',
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '%$percent / $dailyGoal ml',
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
