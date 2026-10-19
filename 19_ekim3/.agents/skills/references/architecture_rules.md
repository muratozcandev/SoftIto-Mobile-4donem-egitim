# Mimari Kurallar ve Temiz Kod Prensipleri

Bu doküman, projede yeni bir özellik (feature) geliştirirken veya mevcut özellikleri düzenlerken uyulması zorunlu olan mimari standartları ve temiz kod ilkelerini belirler.

---

## 1. Modüler Feature (Özellik) Klasör Mimarisi

Her yeni özellik `lib/features/<feature_name>` dizini altında izole bir modül olarak kurgulanmalıdır.

```text
lib/features/<feature_name>/
├── controllers/
│   └── <feature_name>_controller.dart  # İş mantığı, ValueNotifier state yönetimi
├── models/
│   └── <feature_name>_model.dart       # İmmutable veri modelleri (copyWith, toJson, fromJson)
├── views/
│   └── <feature_name>_view.dart        # Ana ekran arayüzü (StatelessWidget)
└── widgets/
    ├── <feature_name>_card.dart        # Ayrıştırılmış alt bileşenler
    └── <feature_name>_gauge.dart       # Görsel grafik ve sayaç widgetları
```

---

## 2. Katmanlar ve Sorumluluk Dağılımı (Separation of Concerns)

| Katman | Sorumluluk | İzin Verilen İçerik | Yasaklanan İçerik |
| :--- | :--- | :--- | :--- |
| **Controllers** | Durum yönetimi, hesaplamalar, veri işleme | `ValueNotifier`, `List<T>`, iş metotları, `dispose()` | `BuildContext`, widget, doğrudan UI çizim çağrıları |
| **Models** | Veri yapıları ve serileştirme | `@immutable`, `final` alanlar, `copyWith`, JSON parsers | İş mantığı, controller referansları |
| **Views** | Ekran iskeleti (Scaffold, AppBar, Layout) | `StatelessWidget`, `SafeArea`, `Column`, `ListView` | Ağır iş mantığı, doğrudan veri manipülasyonu |
| **Widgets** | Yeniden kullanılabilir küçük UI parçaları | `StatelessWidget`, `const` kurucular, `ValueListenableBuilder` | 40 satırı aşan karmaşık `build` blokları |

---

## 3. Kod Kalite Kırmızı Çizgileri

### Kural 1: Asla Tek Dosyada Toplama
Aynı `.dart` dosyası içinde Controller, Model, View ve Widget tanımlamak kesinlikle yasaktır. Her varlık kendi ait olduğu klasördeki bağımsız dosyada bulunmalıdır.

### Kural 2: 40 Satır Build Kuralı
Bir widget'ın `build(BuildContext context)` metodu 40 satırı geçemez. 40 satırı geçen veya mantıksal olarak ayrılabilen bloklar `widgets/` klasörüne bağımsız bir `StatelessWidget` olarak taşınmalıdır:

```dart
// YANLIŞ (Gereksiz uzayan ve iç içe geçen build metodu):
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        // 50 satırlık karmaşık kart tasarımı...
        // 40 satırlık buton grubu...
        // 60 satırlık liste görünümü...
      ],
    ),
  );
}

// DOĞRU (Modüler ve temiz kompozisyon):
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          WaterSummaryCard(controller: controller),
          QuickActionButtons(controller: controller),
          Expanded(child: WaterLogList(controller: controller)),
        ],
      ),
    ),
  );
}
```

### Kural 3: `const` Kurucu Zorunluluğu
Statik olan veya çalışma anında değişmeyen tüm widget kurucularında `const` kullanımı zorunludur. `const` kullanılmaması gereksiz bellek tahsisine (allocation) ve performans kaybına yol açar.

### Kural 4: Bağımlılık Yönü
Katmanlar arasındaki bağımlılık tek yönlü olmalıdır:
- `View` -> `Controller` ve `Model` kullanabilir.
- `Widget` -> `Controller` ve `Model` kullanabilir.
- `Controller` -> `Model` kullanabilir; ancak ASLA `View` veya `BuildContext` barındıramaz.
- `Model` -> Saf veri sınıfıdır, hiçbir üst katmana bağımlı olamaz.

---

## 4. İsimlendirme Standartları

- **Dosya İsimleri:** Küçük harf ve alt tire (snake_case)
  - `water_tracker_controller.dart`
  - `water_log_model.dart`
  - `water_tracker_view.dart`
  - `water_metric_card.dart`
- **Sınıf İsimleri:** Büyük harfle başlayan PascalCase
  - `WaterTrackerController`
  - `WaterLog`
  - `WaterTrackerView`
  - `WaterMetricCard`
- **Değişken ve Metot İsimleri:** camelCase
  - `currentWater`
  - `addWater(int amount)`
  - `resetProgress()`
