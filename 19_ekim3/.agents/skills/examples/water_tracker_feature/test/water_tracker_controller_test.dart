import 'package:flutter_test/flutter_test.dart';
import '../controllers/water_tracker_controller.dart';

void main() {
  group('WaterTrackerController Birim Testleri', () {
    late WaterTrackerController controller;

    setUp(() {
      controller = WaterTrackerController();
    });

    tearDown(() {
      controller.dispose();
    });

    test('Başlangıç değerleri varsayılan değerlerle eşleşmeli', () {
      expect(controller.currentWater.value, 0);
      expect(controller.dailyGoal, 2500);
      expect(controller.progressRatio, 0.0);
      expect(controller.remainingWater, 2500);
      expect(controller.logs.value, isEmpty);
    });

    test('addWater su miktarını ve geçmiş listesini doğru güncellemeli', () {
      controller.addWater(250);

      expect(controller.currentWater.value, 250);
      expect(controller.progressRatio, 0.1);
      expect(controller.remainingWater, 2250);
      expect(controller.logs.value.length, 1);
      expect(controller.logs.value.first.amountMl, 250);
    });

    test('addWater geçersiz (0 veya negatif) miktarlarda durumu değiştirmemeli', () {
      controller.addWater(0);
      controller.addWater(-200);

      expect(controller.currentWater.value, 0);
      expect(controller.logs.value, isEmpty);
    });

    test('resetWater tüm tüketimi ve geçmişi temizlemeli', () {
      controller.addWater(500);
      controller.addWater(250);
      expect(controller.currentWater.value, 750);

      controller.resetWater();

      expect(controller.currentWater.value, 0);
      expect(controller.remainingWater, 2500);
      expect(controller.logs.value, isEmpty);
    });

    test('progressRatio 1.0 üzerine çıkmamalı (clamp kontrolü)', () {
      controller.addWater(4000); // Hedef 2500 ml

      expect(controller.currentWater.value, 4000);
      expect(controller.progressRatio, 1.0);
      expect(controller.remainingWater, 0);
    });
  });
}
