# Girişimcilik Uygulaması - Proje Kılavuzu

Bu doküman, Flutter projesini geliştirecek Antigravity IDE ajanı için temel kuralları içerir. Proje basit, görsel açıdan modern ve tamamen demo amaçlı olacaktır.

## 1. Proje Özeti ve Teknolojiler
* **Uygulama Adı:** Girişelim
* **Hedef Platform:** Android ve iOS öncelikli.
* **Framework:** Flutter
* **Tasarım Dili:** Material 3
* **Dil:** Türkçe
* **State Yönetimi:** ValueNotifier ve ValueListenableBuilder
* **Veri Yönetimi:** Bellekte tutulan örnek veriler (in-memory demo data).
* **Veritabanı ve Backend:** Kullanılmayacaktır.
* **Tasarım:**
  * **Koyu Tema:** Arka plan `#0B1020`, kartlar `#141C2F`, vurgu `#36D399`.
  * **Açık Tema:** Arka plan `#F5F7FB`, kartlar `#FFFFFF`, vurgu `#059669`.
  * Modern kartlar, yuvarlatılmış köşeler, sade ikonlar ve akıcı sayfa geçişleri kullanılmalıdır.
  * Koyu ve açık tema uygulamanın bütün ekranlarında çalışmalıdır.

### Uygulamanın Amacı
Kullanıcının iş fikirlerini inceleyebildiği, sanal bakiyesiyle yatırım simülasyonu yapabildiği ve girişimlerini takip edebildiği modern bir demo uygulaması geliştirmek.
Gerçek hesap oluşturma, gerçek para transferi veya gerçek yatırım işlemi yapılmayacaktır.

---

## 2. Uygulamanın Temel Ekranları

### Giriş ve Kayıt
* Giriş Yap ve Kayıt Ol ekranları bulunmalıdır.
* Ad, e-posta ve şifre gibi temel alanlar kullanılmalıdır.
* Formlar basit doğrulamalara sahip olmalıdır.
* Gerçek üyelik sistemi olmadan giriş yapıldığında ana sayfaya geçilmelidir.

### Ana Sayfa
* **Sol üst:** Profil bilgileri ve ayarlara erişim.
* **Sağ üst:** Koyu/açık tema değiştirme butonu.
* **Orta alan:** İş fikirleri ve yatırım fırsatları.
* **Sol alt:** Tıklanabilir sanal hesap bakiyesi (`BalanceCard`).
* **Sağ alt:** Yaptığım yatırımlar ve kendi iş fikirlerim sayfalarına erişim.

İş fikirleri kartlarında ad, kısa açıklama, ikon ve yatırım tutarı bulunmalıdır. Kartlara tıklandığında ilgili detay sayfası açılmalıdır.

### İş Fikri Detay Sayfası
* İş fikrinin adı ve açıklaması.
* İş modelinin ve hedef kitlesinin tanıtımı.
* Gerekli sanal yatırım tutarı.
* **Sözleşmeyi İmzala** butonu:
  * Butona basıldığında onay ekranı açılmalıdır. Kullanıcı onay verirse yeterli bakiye kontrol edilmeli, yatırım tutarı bakiyeden düşülmeli ve yatırım ana sayfadaki yatırımlar listesine eklenmelidir.
  * Bakiye yetersizse işlem yapılmamalı ve kullanıcı bilgilendirilmelidir.
  * Sözleşme yalnızca görsel bir simülasyondur; gerçek hukuki sözleşme veya elektronik imza oluşturulmayacaktır.

### Bakiye Sayfası (`WalletScreen`)
* Ana sayfanın sol altındaki bakiye alanına tıklanınca açılmalıdır.
* Güncel sanal bakiye.
* **Para Ekle** butonu: Kullanıcı miktar girer ve onayladığında sanal bakiyesi artar.
* **Para Transferi** butonu: Kullanıcı demo alıcı seçer ve miktar girer. Yeterli bakiye varsa transfer simülasyonu yapılır.
* Basit işlem geçmişi.

### Yatırımlarım ve İş Fikirlerim
* Yapılan yatırımlar listelenmelidir.
* Kullanıcının oluşturduğu örnek iş fikirleri gösterilmelidir.
* Yeni iş fikri eklemek için basit bir form bulunmalıdır.
* Henüz kayıt yoksa açıklayıcı boş ekran gösterilmelidir.

### Profil ve Ayarlar
* Profil bilgileri gösterilmelidir.
* Demo oturumu kapatma seçeneği bulunmalıdır.
* Koyu/açık tema değiştirilebilmelidir.
* Demo verilerini sıfırlama seçeneği bulunmalıdır.

---

## 3. Mimari Yapı

```text
lib/
  main.dart

  core/
    constants/
      app_colors.dart
    theme/
      app_theme.dart
      theme_controller.dart

  models/
    business_idea_model.dart
    investment_model.dart
    transaction_model.dart
    user_model.dart

  data/
    demo_data.dart

  controllers/
    app_controller.dart

  screens/
    login_screen.dart
    register_screen.dart
    home_screen.dart
    business_detail_screen.dart
    wallet_screen.dart
    add_money_screen.dart
    transfer_screen.dart
    investments_screen.dart
    my_ideas_screen.dart
    profile_screen.dart
    settings_screen.dart

  widgets/
    business_card.dart
    balance_card.dart
    app_button.dart
```

---

## 4. Kod Kalitesi ve İşleyiş Kuralları
1. Statik widget'larda mümkün olduğunca `const` kullanılmalıdır.
2. Renkler merkezi tema dosyalarından alınmalıdır.
3. Durum yönetiminde `ValueNotifier` ve `ValueListenableBuilder` tercih edilmelidir.
4. Sayfalar sade tutulmalı, tekrar eden tasarımlar ortak widget'lara ayrılmalıdır.
5. Butonların tamamı tanımlanan işlevi yerine getirmelidir.
6. Bakiye, yatırım ve işlem geçmişi aynı merkezi controller üzerinden yönetilmelidir.
7. Bakiye negatif olamamalıdır.
8. Yatırım ve para ekleme işlemlerinde geçersiz miktarlar kabul edilmemelidir.
9. Gerçek backend, veritabanı veya ödeme paketi eklenmemelidir.
10. Eksik bırakılmış buton veya TODO bulunmamalıdır.
