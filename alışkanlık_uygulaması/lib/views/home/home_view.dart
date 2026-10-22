import 'package:flutter/material.dart';
import '../../controllers/app_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/habit_card.dart';
import '../../widgets/progress_ring.dart';
import '../add_habit/add_habit_view.dart';

class HomeView extends StatelessWidget {
  final Function(int tabIndex)? onNavigateToTab;

  const HomeView({
    super.key,
    this.onNavigateToTab,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final controller = AppController.instance;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final habits = controller.habits;
        final overallRate = controller.overallCompletionRate;
        final completedCount = habits.where((h) => h.isCompleted).length;

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // 1. Günlük Genel İlerleme Özeti Kartı
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [
                          AppColors.darkCard,
                          AppColors.darkSurface.withValues(alpha: 0.8),
                        ]
                      : [
                          Colors.white,
                          AppColors.primary.withValues(alpha: 0.05),
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.06)
                      : Colors.grey.shade200,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'GÜNLÜK ÖZET',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Hedeflerine Adım Adım! ✨',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$completedCount / ${habits.length} hedef tamamlandı.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        InkWell(
                          onTap: () {
                            if (onNavigateToTab != null) {
                              onNavigateToTab!(1); // Ekle/Güncelle sekmesine git
                            }
                          },
                          child: const Row(
                            children: [
                              Text(
                                'Değerleri Güncelle',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 16,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  ProgressRing(
                    percentage: overallRate,
                    size: 110,
                    strokeWidth: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. Başlık ve Filtre
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bugünkü Alışkanlıklar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    if (onNavigateToTab != null) {
                      onNavigateToTab!(1);
                    }
                  },
                  icon: const Icon(Icons.tune_rounded, size: 18),
                  label: const Text('Hedefleri Düzenle'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 3. Alışkanlık Kartları Listesi
            ...habits.map((habit) {
              return HabitCard(
                habit: habit,
                onQuickAdd: () {
                  // Hızlı artırım: kalori +150, su +250, adım +1000, uyku +0.5
                  double delta = 100;
                  if (habit.id == 'calorie') delta = 200;
                  if (habit.id == 'water') delta = 250;
                  if (habit.id == 'step') delta = 1000;
                  if (habit.id == 'sleep') delta = 0.5;

                  controller.quickAddValue(habit.id, delta);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${habit.title}: +$delta ${habit.unit} eklendi!',
                      ),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: habit.color,
                    ),
                  );
                },
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AddHabitView(initialHabitId: habit.id),
                    ),
                  );
                },
              );
            }),
            const SizedBox(height: 16),

            // 4. Günün Sözü Kartı
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.04)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.format_quote_rounded,
                    color: AppColors.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '“Alışkanlıklar geleceğinizi inşa eden günlük tuğlalardır. Bugün attığın her adım yarınını şekillendirir.”',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 13,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}
