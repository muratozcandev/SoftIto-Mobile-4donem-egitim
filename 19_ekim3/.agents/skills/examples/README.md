# Örnek Kodlar ve Modüler Mimari Rehberi

Bu dizin, `flutter-feature-scaffold` yeteneği ve `project.md` standartlarına %100 uyumlu örnek kodları ve referans şablonları içerir.

---

## 1. Klasör Yapısı

```text
examples/
├── README.md                      # Bu doküman (Örnek kullanım kılavuzu)
├── sample_screen.dart             # Hızlı konsept gösterimi (tek bakışta akışı görmek için)
└── water_tracker_feature/         # Üretime hazır, modüler tam feature örneği
    ├── controllers/
    │   └── water_tracker_controller.dart  # ValueNotifier, hesaplanmış getters, dispose()
    ├── models/
    │   └── water_log_model.dart           # @immutable model, copyWith, toJson, fromJson
    ├── views/
    │   └── water_tracker_view.dart        # StatelessWidget, <30 satır build metodu
    ├── widgets/
    │   ├── water_card.dart                # Ayrık buton ve aksiyon bileşeni
    │   └── water_gauge.dart               # Dairesel reaktif sayaç bileşeni
    └── test/
        └── water_tracker_controller_test.dart  # Kapsamlı birim test paketi
```

---

## 2. Modüler Örneğe Dair Önemli Prensipler

1. **Katman İzolasyonu:**
   - [water_tracker_controller.dart](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/examples/water_tracker_feature/controllers/water_tracker_controller.dart) içerisinde kesinlikle `BuildContext` veya UI kodu bulunmaz. Yalnızca reaktif durum ve iş mantığı yer alır.
   - [water_log_model.dart](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/examples/water_tracker_feature/models/water_log_model.dart) saf veri modelidir ve değişmezdir (`@immutable`).

2. **Arayüz Temizliği (< 40 Satır Kuralı):**
   - [water_tracker_view.dart](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/examples/water_tracker_feature/views/water_tracker_view.dart) sadece layout iskeletini kurar.
   - Kart ve sayaç gibi detaylar [water_card.dart](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/examples/water_tracker_feature/widgets/water_card.dart) ve [water_gauge.dart](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/examples/water_tracker_feature/widgets/water_gauge.dart) olarak bağımsız `StatelessWidget` dosyalarına ayrılmıştır.

3. **Reaktif Bildirim Mekanizması:**
   - UI güncellemeleri yalnızca `ValueListenableBuilder` ile hedeflenen widget parçalarında tetiklenir.
   - Listelerde referans değişimi kuralına (`logs.value = [newLog, ...logs.value]`) tam uyulmuştur.

4. **Birim Test Kapsamı:**
   - [water_tracker_controller_test.dart](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/examples/water_tracker_feature/test/water_tracker_controller_test.dart) başlangıç durumunu, artışları, sıfırlamaları ve sınır kontrollerini test eder.
