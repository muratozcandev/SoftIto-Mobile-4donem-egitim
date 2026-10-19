import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/water_entry.dart';

/// Geçmiş su tüketim kayıt satırı bileşeni
class WaterHistoryTileWidget extends StatelessWidget {
  final WaterEntry entry;
  final VoidCallback onDelete;

  const WaterHistoryTileWidget({
    super.key,
    required this.entry,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.water_drop, color: AppColors.neonCyan, size: 20),
          const SizedBox(width: 14),
          _buildInfoSection(),
          _buildTrailingSection(),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '+${entry.amountInMl} ml',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          if (entry.note != null && entry.note!.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              entry.note!,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTrailingSection() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          entry.formattedTime,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
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
