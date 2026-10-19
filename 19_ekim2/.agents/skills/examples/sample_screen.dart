import 'package:flutter/material.dart';

class SampleTrackerController {
  final ValueNotifier<int> counter = ValueNotifier<int>(0);

  void increment() => counter.value++;
  void reset() => counter.value = 0;
  void dispose() => counter.dispose();
}

class SampleScreenView extends StatelessWidget {
  final SampleTrackerController controller;

  const SampleScreenView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Örnek Ekran')),
      body: Center(
        child: ValueListenableBuilder<int>(
          valueListenable: controller.counter,
          builder: (context, value, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Değer: $value', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.increment,
                  child: const Text('Artır'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
