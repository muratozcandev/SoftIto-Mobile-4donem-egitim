# Fitness Su Takip ve Egzersiz Uygulaması - Proje Kılavuzu

Bu doküman Flutter projesinde geliştirme yapacak olan ajan (Antigravity), yapay zeka modelleri ve yazılım geliştiriciler için bağlayıcı bir kılavuzdur. Projede üretilen her kod satırı buradaki kurallara **UYMAK ZORUNDADIR**.

---

## 1. Proje Özeti ve Teknolojiler

- **Uygulama Adı:** Susadım v1 (Akıllı Su, Egzersiz ve Kalori Takip Uygulaması)
- **Hedef Platformlar:** iOS ve Android öncelikli, ardından macOS, Web ve Masaüstü platformları.
- **Flutter SDK:** 3.29.0
- **Dart SDK:** 3.0.0+
- **Tasarım Dili:** Material 3
- **Tema Desteği:** Dinamik Koyu ve Aydınlık tema geçişi
  - **Koyu Tema (Dark Obsidian & Neon):** Arka plan `#0B0E14`, Yüzey `#151922`, Neon Cyan `#00F0FF`, Neon Green `#10E775`, Neon Orange `#FF6B00`.
  - **Aydınlık Tema (Fresh Arctic):** Arka plan `#F8FAFC`, Yüzey `#FFFFFF`, Vurgu `#0070F3` & `#00F0FF`.
- **Temel Özellikler:**
  - Hızlı ve reaktif su tüketimi takibi, günlük hedef ve ilerleme göstergesi (Gauge).
  - Su tüketim geçmişi günlüğü (Log listesi) ve sıfırlama mekanizması.
  - Antrenman, süre ve kalori takibi.
  - Tek dokunuşla çalışan reaktif Karanlık/Aydınlık mod geçişi (`ThemeController`).

---

## 2. Mimari Yapı: Feature (Özellik) Bazlı Modüler Düzen

Kodlar kesinlikle tek bir dosyada veya düzensiz klasörlerde toplanmayacaktır. Her işlevsel modül `lib/features/<feature_name>` altında şu katmanlara ayrılır:

```text
lib/
  core/
    constants/
      app_colors.dart          # Renk paleti ve tasarım tokenları
    theme/
      app_theme.dart           # Koyu ve açık Material 3 ThemeData yapılandırması
      theme_controller.dart    # ValueNotifier<ThemeMode> tabanlı tema yöneticisi
    extensions/
      context_extension.dart   # BuildContext yardımcı metotları (theme, colorScheme, screenSize)

  features/
    <feature_name>/
      controllers/
        <feature_name>_controller.dart  # ValueNotifier tabanlı iş mantığı
      models/
        <feature_name>_model.dart       # Değişmez (immutable) veri modelleri
      views/
        <feature_name>_view.dart        # Ana ekran arayüzü (StatelessWidget)
      widgets/
        <feature_name>_card.dart        # Ayrıştırılmış alt bileşenler (< 40 satır build kuralı)

  main.dart                             # Uygulama başlangıcı ve tema sarmalayıcısı
```

---

## 3. Kırmızı Çizgiler ve Kod Kalite Standartları

### 1. Reaktif State Yönetimi Standartları
- **Sayfa Düzeyinde `setState` Yasaktır:** Tüm ekranı yeniden çizdiren ağır `setState` kullanılamaz.
- **`ValueNotifier` & `ValueListenableBuilder` Kullanımı:** Arayüz güncellemeleri yalnızca değişen bileşeni dinleyen `ValueListenableBuilder` ile yapılacaktır.
- **Resource Cleanup:** Controller sınıflarında açılan tüm `ValueNotifier` nesneleri `dispose()` metodu ile bellekten temizlenmelidir.
- **Yasaklı Ağır Paketler:** Projeye gereksiz ve ağır harici state kütüphaneleri (Bloc, MobX, Riverpod vb.) eklenmeyecektir. Dart ve Flutter'ın yerel API'ları esastır.

### 2. UI ve Performans Standartları
- **`const` Zorunluluğu:** Statik tüm widget'larda `const` tanımlanması zorunludur.
- **Merkezi Tema Kullanımı:** Renk ve metin stilleri doğrudan kod içerisine sabit yazılmayacak; `Theme.of(context)` veya `AppColors` üzerinden alınacaktır.
- **Build Metodu Uzunluk Kuralı (Maksimum 40 Satır):** 40 satırı geçen `build` metotları kesinlikle `widgets/` klasörü altına bağımsız `StatelessWidget` olarak parçalanmalıdır.
- **Immutability (Değişmezlik):** Veri modelleri `@immutable` olmalı, `copyWith`, `toJson` ve `fromJson` metotlarını barındırmalıdır.

---

## 4. Geliştirme, Analiz ve Test Standartları

Her geliştirme adımından sonra aşağıdaki komutların hatasız çalıştığı doğrulanmalıdır:

1. **Statik Kod Analizi (0 Uyarı, 0 Hata):**
   ```bash
   flutter analyze
   ```
2. **Birim ve Widget Testleri:**
   ```bash
   flutter test
   ```
3. **Projeyi Çalıştırma:**
   ```bash
   flutter run
   ```

---

## 5. Antigravity ve Ajan Standartları

- Açıklamalar Türkçe, teknik terimlerin doğruluğu korunarak net ve eksiksiz hazırlanmalıdır.
- Kodlarda eksik veya `TODO` şeklinde yarım bırakılmış alan yer almamalıdır.
- Markdown dökümantasyonları her adımda kontrol edilip doğrulanmalıdır.
