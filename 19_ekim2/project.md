# Fitness su takip uygulaması 
bu döküman flutter projesinde geliştime yapacak olan ajan(antigravity) yapay zeka ve yazılım geliştiriciler için bağlayıcı bir klavuzdur. projede üretilen her kod satırı burdaki kurallara UYMAK ZORUNDADIR


# 1. Proje Özeti ve Teknolojiler 
- **Uygulama Adı:** Susadım v1 (akıllı su egzersiz ve kalori takip uygulaması)
- **Hedef Platformlar:** iOS ve android öncelikli ardından web ve masaüstü platformları.
- **Flutter SDK:** 3.29.0
- **Dart SDK:** 3.0.0
- **Tasarım dili:** Material 3. Dinamik Koyu ve Aydınlık tema desteği (Koyu: Gece spor salonu paleti, dark obsidian & neon; Aydınlık: Fresh Arctic & neon cyan);
- **Yeni Özellikler:** Su takibi göstergesinde sıfırlama butonu, Karanlık / Aydınlık Mod (Dark/Light Theme) geçiş düğmesi. 

---

## 2. Mimari Yapı : Özellik bazlı
kodlar kesinlikle tek bir yerde toplanmayacaktır. Her modül kendi feature klasöründe kodlanacaktır.

```text
lib/
  core/
    constants/app_colors.dart
    theme/app_theme.dart
    theme/theme_controller.dart
    extensions/context_extension.dart

  features/
    water_tracker/
      controllers/
      models/
      views/
      widgets/
    workout/
      controllers/
      models/
      views/
      widgets/

  main.dart
```
### sadece uygulama başlatma ve tema bölümleri

## 3. Kırmızı Çizgiler Kod Kalite Standartları
1- **State Yönetim Standartları:**
Sayfa düzeyinde ağır 'setState' KULLANILMAYACAKTIR.
Sadece yerel arayüz durumu yöneten (örneğin buton animasyonları vb.) StatefulWidget kabul edilir.
Tema modu `ThemeController` (ValueNotifier<ThemeMode>) ile yönetilecek ve harici paket olmadan reaktif geçiş sağlanacaktır.

2- **UI ve Performans kuralları:**
Statik tüm widget'lar 'const' zorunludur.
Renk ve metin stilleri kesinlikle tema dosyalarına yazılacaktır.
Büyük build methodları yasaktır 40 satırı geçen build metodları özel widgetlara yazılacaktır.

3- **Yasaklı Paketler:**
Projeye onay almadan harici ağır state paketleri EKLENMEYECEKTİR.
Dart'ın ve Flutter'ın yerel çekirdek apilerini kullanmak esastır.

## 4. Geliştirme Analiz ve Test Komutları
Ajan yaptığı herhangi bir kod değişiklerinden sonra mutlaka alttaki komutların çalıştığını doğrulamalıdır.

* **Statik kod analizi (0 uyarı ve 0 hata şart):**
```bash
flutter analyze
```
* **Birim ve widget testleri:**
```bash
flutter test
```
* **Projeyi çalıştırma:**
```bash
flutter run
```

## 5. Ajanın Çıktı ve Yanıt Verme Standartları

**Açıklamalar:** Türkçe teknik terimlerin özünü bozmadan net ve doğrudan olacaktır.
**Değişiklik Sunumları:** Örnek 500 satırlık bir dosyada 3 satır değiştiyse tüm dosyayı baştan sona basma; hedef satırları ve diff yapısını göster.
**Doğrulama:** Kod yazdıktan sonra kullanıcıya "Şimdi flutter analyze ile kontrol edebilirsin" şeklinde doğrulama yönergeleri ver.
