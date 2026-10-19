import 'package:flutter_test/flutter_test.dart';
import 'package:susadim/features/water_tracker/controller/water_controller.dart';
import 'package:susadim/features/workout/controller/workout_controller.dart';
import 'package:susadim/features/workout/models/workout_entry.dart';
import 'package:susadim/main.dart';

void main() {
  group('Susadım Birim Testleri', () {
    test('WaterController su ekleme ve hedef hesaplama testi', () {
      final controller = WaterController();
      controller.resetToday();

      expect(controller.totalConsumedInMl, 0);
      expect(controller.progressRatio, 0.0);
      expect(controller.isGoalCompleted, false);

      controller.addWater(500);
      expect(controller.totalConsumedInMl, 500);
      expect(controller.remainingInMl, 2000);

      controller.addWater(2000);
      expect(controller.totalConsumedInMl, 2500);
      expect(controller.isGoalCompleted, true);
      expect(controller.progressRatio, 1.0);
    });

    test('WorkoutController egzersiz ekleme ve kalori testi', () {
      final controller = WorkoutController();
      controller.clearAll();

      expect(controller.totalCaloriesBurned, 0);
      expect(controller.totalDurationMinutes, 0);

      controller.addWorkout(
        title: 'Koşu Bandı',
        type: WorkoutType.cardio,
        durationMinutes: 40,
        burnedCalories: 350,
      );

      expect(controller.totalCaloriesBurned, 350);
      expect(controller.totalDurationMinutes, 40);
      expect(controller.workouts.length, 1);
    });
  });

  group('Susadım Widget Testleri', () {
    testWidgets('SusadimApp başarıyla yüklenir ve sekmeleri gösterir', (WidgetTester tester) async {
      await tester.pumpWidget(const SusadimApp());
      await tester.pumpAndSettle();

      expect(find.text('💧 Susadım - Su Takibi'), findsOneWidget);
      expect(find.text('Su Takip'), findsOneWidget);
      expect(find.text('Egzersiz'), findsOneWidget);
    });
  });
}
