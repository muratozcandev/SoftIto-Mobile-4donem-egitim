# Feature Kod Üreteci (generate.feature.sh) Kılavuzu

Bu dizinde, `flutter-feature-scaffold` mimarisine tam uyumlu yeni modüller üretmek için tasarlanmış otomasyon betiği yer alır.

---

## 1. Genel Bakış

[generate.feature.sh](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/script/generate.feature.sh) betiği, Flutter projelerinde Clean Architecture ve modüler feature yaklaşımına uygun olarak:
- Controller (`ValueNotifier` state yönetimi ve `dispose()` metodu),
- Model (`@immutable`, `copyWith`, `toJson`, `fromJson`),
- View (`StatelessWidget`, `<40` satır build kuralı),
- Widget (`_card.dart` alt bileşeni),
- Test (`_controller_test.dart` birim test iskeleti)

dosyalarını tek komutla, sıfır eksik veri bırakacak şekilde üretir.

---

## 2. Kullanım Şekli ve Parametreler

```bash
# Temel kullanım (snake_case modül adı)
./generate.feature.sh <feature_name>

# Mevcut dosyaları ezerek yeniden oluşturma
./generate.feature.sh <feature_name> --force

# Yardım iletisini görüntüleme
./generate.feature.sh --help
```

---

## 3. Örnek Senaryo

Yeni bir adım sayar (step counter) modülü eklemek için:

```bash
./generate.feature.sh step_counter
```

**Üretilen Dosyalar:**
```text
lib/features/step_counter/
├── controllers/
│   └── step_counter_controller.dart
├── models/
│   └── step_counter_model.dart
├── views/
│   └── step_counter_view.dart
└── widgets/
    └── step_counter_card.dart

test/features/step_counter/
└── step_counter_controller_test.dart
```

---

## 4. Kod Standartlarına Uyum

- **Sıfır Hata Garantisi:** Üretilen tüm kodlar `flutter analyze` kurallarına (`prefer_const_constructors`, `use_super_parameters`, `avoid_print`) %100 uyumludur.
- **Güvenli Yazma:** `--force` parametresi verilmediği sürece var olan dosyaları korur, yanlışlıkla veri kaybını önler.
- **Otomatik Test:** Üretilen birim test dosyası anında `flutter test` ile çalıştırılabilir durumdadır.
