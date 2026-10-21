import 'package:flutter/material.dart';

/// Örnek Tutturdum ekran şablonu
/// Modüler mimari, ValueNotifier kullanımı ve Material 3 temasıyla uyumlu.
class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }

  void _increment() {
    _counter.value++;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Örnek Ekran'),
      ),
      body: Center(
        child: ValueListenableBuilder<int>(
          valueListenable: _counter,
          builder: (context, count, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sayaç: $count',
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _increment,
                  icon: const Icon(Icons.add),
                  label: const Text('Artır'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
