# Referans Kılavuzları İndeksi

Bu klasör, `flutter-feature-scaffold` yeteneği ve Susadım v1 projesinde uygulanan mimari prensiplerin detaylı dökümantasyonunu içerir.

---

## Döküman Listesi

1. **[state_flow.md](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/references/state_flow.md)**
   - Reaktif `ValueNotifier` & `ValueListenableBuilder` mimarisi.
   - Durum bildirim döngüsü (Mermaid sekans diyagramı).
   - Koleksiyon ve liste mutasyonlarında referans yenileme kuralları.
   - Çoklu dinleme (`Listenable.merge`) ve asenkron state yönetimi.
   - Bellek temizliği (`dispose()`) ve mimari karşılaştırma tablosu.

2. **[architecture_rules.md](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/references/architecture_rules.md)**
   - Modüler Feature klasör hiyerarşisi (`controllers/`, `models/`, `views/`, `widgets/`).
   - Sorumlulukların ayrıştırılması (Separation of Concerns).
   - Kırmızı Çizgiler: Asla tek dosyada toplamama, 40 satır build kuralı, `const` zorunluluğu.
   - İsimlendirme ve bağımlılık yönü standartları.

3. **[theme_and_styling.md](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/references/theme_and_styling.md)**
   - Material 3 tasarım ilkeleri.
   - Dark Obsidian & Neon koyu teması ve Fresh Arctic aydınlık teması renk paletleri.
   - `ThemeController` ile paket kullanmadan reaktif tema değişimi.
   - `ContextExtension` ile kolay erişim metotları (`context.theme`, `context.colorScheme`).
   - Köşe yuvarlama, kenarlık ve tipografi standartları.

4. **[testing_guide.md](file:///Users/d1-24/Desktop/19_ekim3/.agents/skills/references/testing_guide.md)**
   - Controller birim testleri (Saf Dart ile senkron testler).
   - Widget testleri (`tester.pumpWidget`, `tester.tap`).
   - Statik analiz ve kalite kontrolü (`flutter analyze` 0 hata 0 uyarı standardı).
