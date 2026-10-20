# Araç Kiralama ve Teslimat Uygulaması — Proje Kılavuzu

Bu doküman, Antigravity IDE ile geliştirilecek Flutter araç kiralama ve hasar/teslimat prototipinin temel kurallarını belirler. Uygulama eğitim ve gösterim amaçlıdır; gerçek kullanıcı, ödeme veya araç kiralama sistemi değildir.

## 1. Proje Özeti ve Teknolojiler
- **Uygulama Adı:** AraÇek
- **Platform:** Öncelikle iOS simülatörü, ardından Android.
- **Teknoloji:** Flutter ve Dart.
- **Tasarım:** Material Design 3. Modern, şık ve dinamik arayüz.
- **Tema:** Açık ve koyu mod desteği (ThemeController).
- **Dil:** Türkçe ve İngilizce arayüz desteği.
- **Veri:** Veritabanı ve backend kullanılmayacak. Örnek araçlar ve kullanıcı bilgileri uygulama içinde in-memory tutulacak.
- **İşlemler:** Kayıt, giriş, kiralama, hasar kaydı/fotoğraf çekme simülasyonu ve ödeme prototip olarak çalışacak.

## 2. Uygulamanın Temel Özellikleri
- **Giriş ve Kayıt (Authentication):** Telefon veya e-posta ve şifre alanları bulunacak. Misafir girişi olmayacak. Formlar doğrulandıktan sonra örnek kullanıcıyla ana sayfaya geçilecek; gerçek hesap oluşturulmayacak.
- **Ana Sayfa (Home):** Profil karşılama bilgileri, aktif kiralama kartı, araç kategorileri, örnek araç listesi, arama ve filtreleme seçenekleri, hasar kaydı ve konum erişimi.
- **Araç Filtreleme ve Sıralama:** Araç türü (SUV, Sedan, Elektrikli, Spor vb.), marka, vites türü (Manuel/Otomatik) seçilebilecek; fiyata göre artan/azalan sıralama yapılabilecek.
- **Araç Detayları:** Araç görselleri, teknik özellikleri (yakıt, vites, koltuk, motor, menzil), günlük ücreti ve kiralama süresi hesaplama.
- **Kiralama Süreci (Rental):** Kiralama süresi 1-31 gün arasında dinamik seçilecek. Toplam ücret anlık hesaplanacak.
- **Ödeme Simülasyonu (Payment):** Örnek kredi kartı formu, doğrulama, kupon kodu ve başarılı ödeme simülasyonu.
- **Hasar / Fotoğraf Çek Kaydı (Damage & Delivery Report - AraÇek):** Araç teslim alınırken ve bırakılırken aracın 4 köşesinden/hasarlı yerlerinden örnek fotoğraf çekme/ekleme simülasyonu, hasar notu ve teslimat konum seçimi.
- **Aktif Kiralama:** Kiralanmış aktif aracın bilgileri, kalan gün sayısı, kiralama bedeli ve teslim etme aksiyonu.
- **Profil ve Ayarlar:** Profil bilgileri, sanal ödeme yöntemleri, açık/koyu tema geçişi, Türkçe/İngilizce dil seçimi ve yardım/SSS ekranı.

## 3. Mimari Yapı

```text
lib/
  core/
    constants/
      app_colors.dart
      app_assets.dart
    theme/
      app_theme.dart
      theme_controller.dart
    localization/
      app_strings.dart
      locale_controller.dart

  features/
    authentication/
      controllers/
      views/
      widgets/

    home/
      views/
      widgets/

    vehicles/
      models/
      controllers/
      views/
      widgets/

    rental/
      controllers/
      views/
      widgets/

    damage_report/
      models/
      controllers/
      views/
      widgets/

    profile/
      views/
      widgets/

    settings/
      views/
      widgets/

  main.dart
```

## 4. Kodlama Kuralları
- **Yorum Satırları:** 20_ekim_ödev klasöründeki TÜM kodların her satırı, fonksiyonu, widget'ı ve sınıfı detaylı Türkçe yorum satırları ile açıklanacaktır.
- **State Yönetimi:** ValueNotifier ve ValueListenableBuilder tercih edilecektir. Basit yerel durumlar için StatefulWidget kullanılabilir.
- **Form Doğrulama:** Boş alanlar, geçersiz telefon/e-posta ve şifre kontrolleri eksiksiz yapılacaktır.
- **UI & UX:** Modern Material 3 kartlar, yumuşak geçişler, premium renk paleti ve AraÇek logolu özel tasarım.
- **Hata ve Sıfırlama Yönetimi:** Test edilebilir, temiz ve uyarı vermeyen kod yazılacaktır.
