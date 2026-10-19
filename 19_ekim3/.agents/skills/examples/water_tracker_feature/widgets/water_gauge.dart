import 'package:flutter/material.dart';
import '../controllers/water_tracker_controller.dart';

/// Su tüketim ilerlemesini gösteren dairesel sayaç bileşeni
class WaterGauge extends StatelessWidget {
  final WaterTrackerController controller;

  const WaterGauge({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<int>(
        valueListenable: controller.currentWater,
        builder: (context, current, _) {
          final ratio = controller.progressRatio;
          final percentage = (ratio * 100).toInt();

          return SizedBox(
            width: 180,
            height: 180,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: ratio,
                  strokeWidth: 12,
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$current ml',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        '%$percentage / ${controller.dailyGoal} ml',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
