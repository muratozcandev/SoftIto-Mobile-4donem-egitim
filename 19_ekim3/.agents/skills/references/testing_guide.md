# Test ve Kalite Güvence Kılavuzu (Unit & Widget Testing)

Bu doküman, projede geliştirilen `ValueNotifier` tabanlı kontrolcülerin ve arayüz bileşenlerinin test edilme yöntemlerini, kalite kıstaslarını ve analiz kurallarını içerir.

---

## 1. Test Piramidi ve Yaklaşım

Projede iki ana test seviyesi uygulanır:
1. **Birim Testleri (Unit Tests):** Controller iş mantığı ve hesaplamalarının saf Dart ortamında hızlıca doğrulanması.
2. **Widget Testleri (UI Tests):** Reaktif arayüz bileşenlerinin, kullanıcı tıklamalarının ve render tepkilerinin doğrulanması.

---

## 2. Controller Birim Testi (Unit Testing)

`ValueNotifier` mimarisi doğrudan nesne durumunu değiştirdiği için harici mock araçlarına veya karmaşık asenkron beklemelere ihtiyaç duymaz. Senkron ve ışık hızında çalışır:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:susadim/features/water_tracker/controllers/water_tracker_controller.dart';

void main() {
  group('WaterTrackerController Birim Testleri', () {
    late WaterTrackerController controller;

    setUp(() {
      controller = WaterTrackerController();
    });

    tearDown(() {
      controller.dispose();
    });

    test('Başlangıç değerleri doğru olmalı', () {
      expect(controller.currentWater.value, 0);
      expect(controller.progressRatio, 0.0);
      expect(controller.remainingWater, controller.dailyGoal);
      expect(controller.logs.value, isEmpty);
    });

    test('addWater metodu su miktarını ve kayıt günlüğünü artırmalı', () {
      controller.addWater(250);

      expect(controller.currentWater.value, 250);
      expect(controller.logs.value.length, 1);
      expect(controller.logs.value.first.amountMl, 250);
    });

    test('addWater negatif veya sıfır değer geldiğinde durumu değiştirmemeli', () {
      controller.addWater(0);
      controller.addWater(-100);

      expect(controller.currentWater.value, 0);
      expect(controller.logs.value, isEmpty);
    });

    test('resetWater metodu tüm ilerlemeyi sıfırlamalı', () {
      controller.addWater(500);
      controller.resetWater();

      expect(controller.currentWater.value, 0);
      expect(controller.logs.value, isEmpty);
    });

    test('progressRatio 1.0 değerini aşmamalı (clamp)', () {
      controller.addWater(5000); // Hedefin 2 katı

      expect(controller.progressRatio, 1.0);
      expect(controller.remainingWater, 0);
    });
  });
}
```

---

## 3. Widget Testi (UI Testing)

Widget testlerinde `tester.pumpWidget` ile bileşen yüklenir ve `tester.tap` ile reaktif tepki test edilir:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:susadim/features/water_tracker/controllers/water_tracker_controller.dart';
import 'package:susadim/features/water_tracker/widgets/quick_add_buttons.dart';

void main() {
  testWidgets('QuickAddButtons tıklandığında controller değerini güncellemeli',
      (WidgetTester tester) async {
    final controller = WaterTrackerController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: QuickAddButtons(controller: controller),
        ),
      ),
    );

    // Butonun ekranda olduğunu doğrula
    final add250Btn = find.text('+250 ml');
    expect(add250Btn, findsOneWidget);

    // Dokun ve arayüzü güncelle
    await tester.tap(add250Btn);
    await tester.pump();

    // Controller'ın tetiklendiğini doğrula
    expect(controller.currentWater.value, 250);

    controller.dispose();
  });
}
```

---

## 4. Statik Kod Analizi ve Doğrulama

Her geliştirme adımının ardından terminalde şu analiz çalıştırılır:

```bash
flutter analyze
```

**Kabul Kriteri:**
- **0 Warning (Sıfır Uyarı)**
- **0 Error (Sıfır Hata)**
- `avoid_print`, `prefer_const_constructors`, `use_super_parameters` kurallarına tam uyum.

Birim testlerinin toplu çalıştırılması:
```bash
flutter test
```
Tüm test senaryoları yeşil (`All tests passed!`) olmalıdır.
