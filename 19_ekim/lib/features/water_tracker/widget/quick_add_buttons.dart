import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Hızlı su ekleme butonları bileşeni
class QuickAddButtonsWidget extends StatelessWidget {
  final ValueChanged<int> onAdd;

  const QuickAddButtonsWidget({
    super.key,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildItem(context, 200, '200 ml', Icons.local_cafe_outlined),
        _buildItem(context, 330, '330 ml', Icons.local_drink_outlined),
        _buildItem(context, 500, '500 ml', Icons.sports_bar_outlined),
        _buildItem(context, 1000, '1 L', Icons.water_drop_outlined),
      ],
    );
  }

  Widget _buildItem(
    BuildContext context,
    int amount,
    String label,
    IconData icon,
  ) {
    return InkWell(
      onTap: () => onAdd(amount),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.surfaceBorder),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.neonCyan, size: 22),
            const SizedBox(height: 6),
            Text(
              '+$label',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
