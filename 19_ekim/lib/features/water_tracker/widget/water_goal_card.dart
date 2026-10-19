import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Hedef ve kalan su miktarını gösteren neon kart
class WaterGoalCardWidget extends StatelessWidget {
  final int remainingInMl;
  final bool isCompleted;

  const WaterGoalCardWidget({
    super.key,
    required this.remainingInMl,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCompleted ? AppColors.neonGreen : AppColors.surfaceBorder,
          width: isCompleted ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        children: [
          _buildIconBadge(),
          const SizedBox(width: 16),
          _buildTextContent(),
        ],
      ),
    );
  }

  Widget _buildIconBadge() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (isCompleted ? AppColors.neonGreen : AppColors.neonCyan)
            .withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isCompleted ? Icons.check_circle : Icons.flag_outlined,
        color: isCompleted ? AppColors.neonGreen : AppColors.neonCyan,
        size: 26,
      ),
    );
  }

  Widget _buildTextContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isCompleted ? 'Günlük Hedefine Ulaştın!' : 'Kalan Hedef',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isCompleted
                ? 'Harika iş! Vücudun yeterli hidrasyona ulaştı.'
                : '$remainingInMl ml daha içerek hedefini tamamla.',
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
