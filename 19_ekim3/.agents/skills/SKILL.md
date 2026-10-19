---
name: flutter-feature-scaffold
description: Flutter projelerinde Clean Architecture ve modüler feature bazlı kod yazmak için gerekli klasör yapısını ve boilerplate kodları oluşturur. ValueNotifier reaktif state mimarisini, UI ayrımını, <40 satır build kuralını ve birim test iskeletini standartlara uygun olarak üretir.
---

# Flutter Feature Scaffold (Modüler Ekran İskeleti)

Bu yetenek, projede yeni bir ekran ya da işlev modülü açarken Clean UI, reaktif State kuralları ve test edilebilirlik standartlarına tam uyulmasını garanti altına alır.

---

## 1. Temel Kurallar ve Kırmızı Çizgiler

1. **Asla Tek Dosyada Toplama:** 
   UI (`_view.dart`), State Controller (`_controller.dart`), Model (`_model.dart`) ve bileşen (`_widgets.dart`) dosyaları ayrı ayrı açılmalıdır.
2. **Reaktif State Yönetimi (`ValueNotifier`):**
   Ağır `setState` veya onaylanmamış harici paketler (Bloc, Riverpod) kullanılmaz. Flutter'ın yerel `ValueNotifier` ve `ValueListenableBuilder` API'ları esastır.
3. **Maksimum 40 Satır `build` Kuralı:**
   Bir widget'ın `build` metodu 40 satırı geçemez. Aşan parçalar `widgets/` altına bağımsız `StatelessWidget` olarak taşınır.
4. **`const` Zorunluluğu:**
   Statik tüm widget'larda `const` kurucu kullanımı zorunludur.
5. **Model İmmutability (Değişmezlik):**
   Tüm modeller `@immutable` olmalı, `copyWith`, `toJson` ve `fromJson` metotlarını barındırmalıdır.

---

## 2. Otomatik Üretim Betiği (Hızlı Yol)

Modül iskeletini ve testlerini otomatik oluşturmak için `script/generate.feature.sh` betiğini çalıştırınız:

```bash
# Kullanım:
./.agents/skills/script/generate.feature.sh <feature_name>

# Örnek:
./.agents/skills/script/generate.feature.sh water_tracker
```

Bu komut ilgili `lib/features/<feature_name>/` klasörünü ve `test/features/<feature_name>/` altındaki birim testini eksiksiz oluşturur.

---

## 3. Adım Adım Manuel Uygulama Akışı

### Adım 1: Klasör Yapısı Oluşturma
Hedeflenen modül adları (örn: `water_tracker`), `lib/features/<feature_name>` altında şu yapıda kurulmalıdır:

```text
lib/features/<feature_name>/
    controllers/
        <feature_name>_controller.dart
    models/
        <feature_name>_model.dart
    views/
        <feature_name>_view.dart
    widgets/
        <feature_name>_card.dart
```

### Adım 2: Controller Dosyasını Yazma
`controllers/<feature_name>_controller.dart` içinde iş mantığını, `ValueNotifier` tanımlarını ve `dispose()` metodunu oluştur:

```dart
import 'package:flutter/foundation.dart';
import '../models/water_log_model.dart';

class WaterTrackerController {
  final ValueNotifier<int> currentWater = ValueNotifier<int>(0);
  final ValueNotifier<List<WaterLog>> logs = ValueNotifier<List<WaterLog>>([]);
  final int dailyGoal = 2500; // ml

  double get progressRatio => (currentWater.value / dailyGoal).clamp(0.0, 1.0);
  int get remainingWater => (dailyGoal - currentWater.value).clamp(0, dailyGoal);

  void addWater(int amount) {
    if (amount <= 0) return;
    currentWater.value += amount;

    final newLog = WaterLog(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amountMl: amount,
      timestamp: DateTime.now(),
    );
    // DİKKAT: Reaktif tetikleme için referans yenilenmelidir
    logs.value = [newLog, ...logs.value];
  }

  void resetWater() {
    currentWater.value = 0;
    logs.value = [];
  }

  void dispose() {
    currentWater.dispose();
    logs.dispose();
  }
}
```

### Adım 3: Model Dosyasını Oluşturma
`models/<feature_name>_model.dart` dosyasını `immutable` olarak tanımla:

```dart
import 'package:flutter/foundation.dart';

@immutable
class WaterLog {
  final String id;
  final int amountMl;
  final DateTime timestamp;

  const WaterLog({
    required this.id,
    required this.amountMl,
    required this.timestamp,
  });

  WaterLog copyWith({
    String? id,
    int? amountMl,
    DateTime? timestamp,
  }) {
    return WaterLog(
      id: id ?? this.id,
      amountMl: amountMl ?? this.amountMl,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory WaterLog.fromJson(Map<String, dynamic> json) {
    return WaterLog(
      id: json['id'] as String? ?? '',
      amountMl: (json['amountMl'] as num?)?.toInt() ?? 0,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amountMl': amountMl,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
```

### Adım 4: Widget Dosyalarını Oluşturma (< 40 Satır Kuralı)
Ayrıştırılmış alt bileşenler `widgets/` klasöründe bağımsız `StatelessWidget` olarak yazılır:

```dart
import 'package:flutter/material.dart';
import '../controllers/water_tracker_controller.dart';

class WaterCard extends StatelessWidget {
  final WaterTrackerController controller;

  const WaterCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () => controller.addWater(250),
              child: const Text('+250 ml'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: controller.resetWater,
              child: const Text('Sıfırla'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Adım 5: View Dosyasını Oluşturma
`views/<feature_name>_view.dart` dosyasında `StatelessWidget` ve `ValueListenableBuilder` kullanılarak düzen kurulur.

### Adım 6: Birim Testini Yazma
`test/features/<feature_name>/<feature_name>_controller_test.dart` dosyasında controller durumu test edilir:

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('addWater miktar artırmalı', () {
    final controller = WaterTrackerController();
    controller.addWater(250);
    expect(controller.currentWater.value, 250);
    controller.dispose();
  });
}
```

---

## 4. Detaylı Referanslar ve Örnekler

Daha fazla ayrıntı ve standart dökümanları için ilgili bağlantıları inceleyiniz:

- **Referans Kılavuzları:**
  - [state_flow.md](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/references/state_flow.md) - Reaktif state akışı, mermaid şeması ve bellek yönetimi
  - [architecture_rules.md](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/references/architecture_rules.md) - Modüler katman kuralları ve kırmızı çizgiler
  - [theme_and_styling.md](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/references/theme_and_styling.md) - Dark Obsidian & Neon tema standartları ve ThemeController
  - [testing_guide.md](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/references/testing_guide.md) - Birim ve widget testi rehberi, statik analiz
- **Canlı Örnekler:**
  - [water_tracker_feature/](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/examples/water_tracker_feature) - Eksiksiz, üretime hazır modül örneği
  - [sample_screen.dart](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/examples/sample_screen.dart) - Hızlı arayüz prototip örneği
- **Otomasyon Betiği:**
  - [generate.feature.sh](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/script/generate.feature.sh) - Modül ve test üreteci
