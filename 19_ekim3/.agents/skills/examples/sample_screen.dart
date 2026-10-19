import 'package:flutter/material.dart';

/// NOT: Bu dosya konseptin tek bakışta anlaşılması için basitleştirilmiş hızlı bir referanstır.
/// Gerçek projede Kural 1 gereğince Controller, Model, View ve Widget MUTLAKA ayrı dosyalarda olmalıdır.
/// Eksiksiz ve modüler örnek için `examples/water_tracker_feature/` klasörünü inceleyiniz.

/// Hızlı Örnek Controller Katmanı
class SampleTrackerController {
  final ValueNotifier<int> counter = ValueNotifier<int>(0);

  void increment() => counter.value++;
  void reset() => counter.value = 0;

  void dispose() {
    counter.dispose();
  }
}

/// Hızlı Örnek View Katmanı (Stateless & Reaktif)
class SampleScreenView extends StatelessWidget {
  final SampleTrackerController controller;

  const SampleScreenView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Örnek Reaktif Ekran'),
        centerTitle: true,
      ),
      body: Center(
        child: ValueListenableBuilder<int>(
          valueListenable: controller.counter,
          builder: (context, value, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sayaç Değeri',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '$value',
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: controller.increment,
                      icon: const Icon(Icons.add),
                      label: const Text('Artır'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: controller.reset,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Sıfırla'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
