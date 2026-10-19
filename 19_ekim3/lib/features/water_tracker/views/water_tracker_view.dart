import 'package:flutter/material.dart';
import '../../../core/theme/theme_controller.dart';
import '../controllers/water_tracker_controller.dart';
import '../widgets/app_header.dart';
import '../widgets/quick_add_buttons.dart';
import '../widgets/water_circular_gauge.dart';
import '../widgets/water_log_list.dart';
import '../widgets/water_stats_row.dart';

class WaterTrackerView extends StatelessWidget {
  final WaterTrackerController controller;
  final ThemeController themeController;

  const WaterTrackerView({
    super.key,
    required this.controller,
    required this.themeController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppHeader(themeController: themeController),
              const SizedBox(height: 12),
              WaterCircularGauge(controller: controller),
              const SizedBox(height: 24),
              QuickAddButtons(controller: controller),
              const SizedBox(height: 20),
              WaterStatsRow(controller: controller),
              const SizedBox(height: 20),
              WaterLogList(controller: controller),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _SusadimBottomNav(),
    );
  }
}

class _SusadimBottomNav extends StatelessWidget {
  const _SusadimBottomNav();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BottomNavigationBar(
      currentIndex: 0,
      backgroundColor: theme.cardTheme.color ?? theme.colorScheme.surface,
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: theme.textTheme.bodySmall?.color,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.water_drop),
          label: 'Su Takibi',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Antrenman',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}
