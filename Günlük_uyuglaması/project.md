# Günlük Uyuglaması
Bu döküman flutter projesinde geliştirme yapacak olan ajan(antigravity) yapay zeka ve yazılım geliştiriciler için bağlayıcı bir klavuzdur. Projede üretilen her kod satırı burdaki kurallara UYMAk ZORUNDADIR.

## 1.Proje Özeti ve Teknolojiler
-**Uygulama adı:** Sırdaşım (akıllı günlük: ay yıl gün ve günlüğün yazıldığı saat kısmını gösteren ve o gün içerisinde ne yaşadıysak aktarabildiğimiz uygulama)
-**Hedef Platformlar:** İos ve android öncelikli ardından web ve masaüstü platformları
-**Flutter SDK:** 3.32.3
-**Dart SDK:** 3.10.1
-**Tasarım Dili:** Material 3, Açık Tema

---


## Mimari Yapı : Özellik bazlı 
kodlar kesinlikle tek bir yerde toplanmayacaktır. Her modül kendi feature klasöründe kodlanacaktır.

```text
lib/
core/
extension'lar
        constans/app.colors.dart
        theme/app_theme.dart
    features/
        diary/
            screens/
                diary_screen.dart

            widgets/
                month_header.dart
                day_selector.dart
                diary_date.dart
                diary_editor.dart
        main.dart
```
#### sadece uygulama başlatma ve tema bölümleri

## 3 Kırmızı çizgiler kod kalite standartı 
1- **State Yönetim Standartları:**
Sayfa düzeyinde ağır `setState` KULLANILMAYACAKTIR.
Sadece yerel arayüz durumunu yöneten (örneğin buton animasyonları vb) StatefulWidget kabul edilir.

2- **UI ve Performans kuralları:**
Statik tüm widgetlar da `const` zorunludur.
Renk ve metin stilleri kesinlikler tema dosyalarını yazılacaktır
Büyük build methodları yasaktır 40 satırı geçen build metodları özel widgetlara yazılacaktır.

3- **Yasaklı Paketler:**
Projeye onay almadan harici ağır state paketleri EKLENMEYECEKTİR.
Dart'ın ve Flutter'ın yerel çekirdek apilerini kullanmak esastır

## 4 Geliştime analiz ve test konuları
Ajan yaptığı herhangi bir kod değişiklerinden sonra mutlaka konumların çalıştığını doğrulamalıdır.


* **Statik Kod Analizi(0 uyarı ve 0 hata şart):**
```bash
flutter analyze
```
* **Birim ve widget Testleri:**
```bash
flutter test
```

* **Projeyi Çalıştırma:**
```bash
flutter run
```

## 5 Ajanın çıktı ve yaanıt verme standartları 

**Açıklamalar** Türkçe teknik terimleri özünü bozmadan ve doğrudan olacaktır. 
**Değişiklik Sunumları:** Örnek 500 satırlık vir dosyada 3 satır değiştiyse tüm dosyayı baştan sonra basma; hedef satırları ve diff yapısını göster.
**Dosya Yolları** bahsedilen ve üretilen her dosya için mutlaka projeye före tıklanabilir link ver.
**Doğrulama:** Kod yazdıktan sonra kullanıcıyı "Şimdi flutter analiz ile kontrol edebilirsin" şeklinde doğrulama yönergeleri ver.


            


        
