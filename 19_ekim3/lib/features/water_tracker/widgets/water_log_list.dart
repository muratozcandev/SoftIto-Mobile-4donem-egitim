import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/water_tracker_controller.dart';
import '../models/water_log_model.dart';

class WaterLogList extends StatelessWidget {
  final WaterTrackerController controller;

  const WaterLogList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<WaterLog>>(
      valueListenable: controller.logs,
      builder: (context, logs, _) {
        if (logs.isEmpty) {
          return const _EmptyLogs();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bugünkü Hidrasyon Kayıtları',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              ...logs.take(5).map((log) => _LogItem(log: log)),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyLogs extends StatelessWidget {
  const _EmptyLogs();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.surfaceBorder : AppColors.lightSurfaceBorder,
        ),
      ),
      child: Center(
        child: Text(
          'Henüz su tüketimi kaydedilmedi.',
          style: TextStyle(
            color: theme.textTheme.bodySmall?.color,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _LogItem extends StatelessWidget {
  final WaterLog log;

  const _LogItem({required this.log});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hour = log.timestamp.hour.toString().padLeft(2, '0');
    final minute = log.timestamp.minute.toString().padLeft(2, '0');

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.surfaceBorder : AppColors.lightSurfaceBorder,
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.neonCyan : AppColors.neonBlue).withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.water_drop,
                  color: isDark ? AppColors.neonCyan : AppColors.neonBlue,
                  size: 16,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '+${log.amountMl} ml Su',
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Text(
            '$hour:$minute',
            style: TextStyle(
              color: theme.textTheme.bodySmall?.color,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
