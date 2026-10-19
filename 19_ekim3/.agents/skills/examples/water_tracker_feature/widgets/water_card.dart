import 'package:flutter/material.dart';
import '../controllers/water_tracker_controller.dart';

/// Hızlı su ekleme ve sıfırlama aksiyon kartı
class WaterCard extends StatelessWidget {
  final WaterTrackerController controller;

  const WaterCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => controller.addWater(250),
                    icon: const Icon(Icons.local_drink),
                    label: const Text('+250 ml'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => controller.addWater(500),
                    icon: const Icon(Icons.water_drop),
                    label: const Text('+500 ml'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: controller.resetWater,
              icon: const Icon(Icons.refresh),
              label: const Text('Tüketimi Sıfırla'),
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.colorScheme.error,
                minimumSize: const Size.fromHeight(42),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
