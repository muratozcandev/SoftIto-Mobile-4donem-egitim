import 'package:flutter/material.dart';

/// Örnek ekran şablonu - AraÇek standart ekran yapısı
class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Örnek Ekran'),
      ),
      body: const Center(
        child: Text('AraÇek Örnek Ekranı'),
      ),
    );
  }
}
