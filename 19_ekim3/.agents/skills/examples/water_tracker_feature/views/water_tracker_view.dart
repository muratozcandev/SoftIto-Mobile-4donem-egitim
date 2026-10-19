import 'package:flutter/material.dart';
import '../controllers/water_tracker_controller.dart';
import '../widgets/water_card.dart';
import '../widgets/water_gauge.dart';

/// Su takip modülü ana ekranı
class WaterTrackerView extends StatelessWidget {
  final WaterTrackerController controller;

  const WaterTrackerView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Su Takibi'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WaterGauge(controller: controller),
              const SizedBox(height: 32),
              WaterCard(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}
