---
name: flutter-feature-scaffold
description: Flutter projelerinde feature bazlı kod yazmak için gerekli klasör yapısını oluşturur. ValueNotifier state mimarisini, UI ayrımını ve birim test iskeletini standartlara uygun olarak üretir.
---

# Flutter Feature Scaffold (Modüler Ekran İskeleti)

Bu yetenek, projede yeni bir ekran ya da işlev modülü açarken Clean UI ve reaktif State kurallarına tam uyulmasını garanti altına alır.

## Temel Kurallar
1. **Asla tek dosyada toplama:** 
   UI (`_view.dart`), State Controller (`_controller.dart`), Model (`_model.dart`) ve bileşen (`_widgets.dart`) dosyaları ayrı ayrı açılmalıdır.
2. **State Yönetimi:**
   Basit ve reaktif durumlar için `ValueNotifier` kullanılmalıdır. Doğrudan devasa `StatefulWidget`'lar yazarak arayüzü ve mantığı karmaşıklaştırma.
3. **Const Zorunluluğu:**
   Statik tüm widget'larda `const` zorunludur.

---

## Adım Adım Uygulama Akışı

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

### Adım 2: Controller Dosyasını Yaz
`controllers/<feature_name>_controller.dart` içinde mantığı ve `ValueNotifier` tanımlarını oluştur:

```dart
import 'package:flutter/foundation.dart';

class WaterTrackerController {
  final ValueNotifier<int> currentWater = ValueNotifier<int>(0);
  final int dailyGoal = 2000; // 2000 ml

  void addWater(int amount) {
    currentWater.value += amount;
  }

  void resetWater() {
    currentWater.value = 0;
  }

  void dispose() {
    currentWater.dispose();
  }
}
```

### Adım 3: Model Dosyasını Oluşturma
`models/<feature_name>_model.dart` dosyasını `immutable` olarak tanımla:

```dart
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
}
```

### Adım 4: View Dosyasını Oluşturma
`views/<feature_name>_view.dart` dosyasında `StatelessWidget` ve `ValueListenableBuilder` kullanılarak UI katmanı oluşturulur.

### Adım 5: Widget Dosyalarını Oluşturma
Büyük widget'lar (40 satırı geçen `build` blokları) `widgets/` klasöründe ayrık `StatelessWidget`'lar olarak yazılır.
