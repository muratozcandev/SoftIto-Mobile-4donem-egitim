name: flutter-rental-prototype description: Flutter ile basit araç kiralama prototipi geliştirirken ekranları, widgetları, form doğrulamalarını, tema yönetimini ve yerel örnek verileri düzenli şekilde oluşturur. Gerçek backend veya ödeme sistemi gerektirmez.
Flutter Rental Prototype

Bu skill, Kirala adlı araç kiralama gösterim uygulamasında yeni ekranlar ve etkileşimler oluşturmak için kullanılır.

Amaç üretime hazır bir kiralama sistemi geliştirmek değil; iOS simülatöründe çalışan, tasarımı düzgün ve temel işlemleri simüle eden bir Flutter uygulaması oluşturmaktır.

1. Temel Kurallar
Basit mimari: Arayüz, gerekli controllerlar ve veri modelleri ayrı tutulur. Gereksiz klasör veya katman oluşturulmaz.
Yerel durum yönetimi: Basit durumlarda ValueNotifier ve ValueListenableBuilder kullanılır.
Material Design 3: Açık/koyu tema desteği ve merkezi renk yönetimi bulunur.
Formlar: Giriş, kayıt, kiralama ve örnek ödeme formları doğrulanır.
Örnek veri: Araçlar ve kullanıcı bilgileri uygulama içinde tanımlanır. Veritabanı kullanılmaz.
Simülasyon: Giriş, kiralama ve ödeme işlemleri başarılı mesajlarıyla gösterilir; gerçek işlem yapılmaz.
Kod düzeni: Mümkün olan yerlerde const kullanılır ve tekrar kullanılabilir widgetlar ayrılır.
2. Önerilen Klasör Yapısı
lib/
  core/
    theme/
      app_theme.dart
      theme_controller.dart
    constants/
      app_colors.dart

  features/
    authentication/
      views/
      widgets/
    home/
      views/
      widgets/
    vehicles/
      models/
      views/
      widgets/
    rental/
      controllers/
      views/
      widgets/
    profile/
      views/
      widgets/
    damage_report/
      views/
      widgets/
    settings/
      views/
      widgets/

  main.dart


Her özellik için bütün klasörleri oluşturmak zorunlu değildir. Yalnızca ihtiyaç duyulan dosyalar eklenir.

3. Örnek Araç Modeli

lib/features/vehicles/models/vehicle_model.dart

// Flutter'ın değişmez veri modeli tanımlamak için kullandığı anotasyonu sağlar.
import 'package:flutter/foundation.dart';

// Bir aracı uygulama içinde temsil eder.
@immutable
class Vehicle {
  final String id;
  final String name;
  final String brand;
  final String type;
  final String transmission;
  final int dailyPrice;
  final String imageUrl;

  // Araç bilgilerini oluşturur.
  const Vehicle({
    required this.id,
    required this.name,
    required this.brand,
    required this.type,
    required this.transmission,
    required this.dailyPrice,
    required this.imageUrl,
  });
}

// Örnek araç listesi; veritabanı bağlantısı gerekmez.
const sampleVehicles = <Vehicle>[
  Vehicle(
    id: '1',
    name: 'Clio',
    brand: 'Renault',
    type: 'Otomobil',
    transmission: 'Manuel',
    dailyPrice: 1200,
    imageUrl: '',
  ),
  Vehicle(
    id: '2',
    name: 'Corolla',
    brand: 'Toyota',
    type: 'Otomobil',
    transmission: 'Otomatik',
    dailyPrice: 1800,
    imageUrl: '',
  ),
  Vehicle(
    id: '3',
    name: 'Model 3',
    brand: 'Tesla',
    type: 'Elektrikli',
    transmission: 'Otomatik',
    dailyPrice: 3000,
    imageUrl: '',
  ),
];


Açıklama: Araçlar sabit örnek verilerle gösterilir. Görsel adresi boşsa arayüzde varsayılan araç ikonu gösterilmelidir. Gerçek araç servisi veya API bağlantısı oluşturulmaz.

4. Örnek Kiralama Controllerı

lib/features/rental/controllers/rental_controller.dart

import 'package:flutter/foundation.dart';

// Kiralama süresi ve işlem sonucunu yönetir.
class RentalController {
  // Başlangıçta kiralama süresi bir gündür.
  final ValueNotifier<int> days = ValueNotifier<int>(1);

  // Örnek kiralama işleminin sonucunu tutar.
  final ValueNotifier<bool> isRented = ValueNotifier<bool>(false);

  final int dailyPrice;

  RentalController({required this.dailyPrice});

  // Gün sayısını 1 ile 31 arasında sınırlar.
  void setDays(int value) {
    if (value < 1 || value > 31) return;
    days.value = value;
  }

  // Toplam ücreti yerel olarak hesaplar.
  int get totalPrice => dailyPrice * days.value;

  // Gerçek ödeme yapmadan kiralama sonucunu simüle eder.
  void simulateRental() {
    isRented.value = true;
  }

  // Kullanılmayan durum dinleyicilerini temizler.
  void dispose() {
    days.dispose();
    isRented.dispose();
  }
}


Açıklama: Bu controller kiralama gününü, toplam ücreti ve simüle edilmiş kiralama durumunu yönetir. Gerçek ödeme, rezervasyon veya sunucu kaydı gerçekleştirmez.

5. Form Doğrulama Kuralları
Giriş ekranında telefon veya e-posta ve şifre alanları bulunur.
Kayıt ekranında gerekli alanlar kontrol edilir.
Form geçersizse kullanıcıya açıklayıcı hata mesajı gösterilir.
Form geçerliyse örnek kullanıcıyla ana sayfaya geçilir.
Ödeme ekranında örnek alanlar kontrol edilebilir ancak gerçek kart bilgileri kaydedilmez veya gönderilmez.

Örnek doğrulama:

// Boş bir alanın gönderilmesini engelleyen validator örneği.
String? validateRequired(String? value) {
  // Kullanıcının boşluk girerek alanı geçmesini önler.
  if (value == null || value.trim().isEmpty) {
    return 'Bu alan zorunludur';
  }

  // Alan doluysa hata döndürmez.
  return null;
}


Bu fonksiyon TextFormField içindeki validator parametresinde kullanılabilir.

6. Ekranların Davranışları
Giriş ve kayıt
Misafir girişi bulunmaz.
Telefon veya e-posta ile giriş seçenekleri gösterilir.
Kayıt işlemi yalnızca örnek kullanıcı akışını simüle eder.
Ana sayfa ve araçlar
Araç kartları örnek verilerle oluşturulur.
Filtreleme araç türü, marka ve vites türüne göre yapılır.
Sıralama fiyat artan veya azalan biçimde yapılır.
Araç kartına dokunulduğunda detay sayfası açılır.
Kiralama ve ödeme
Kullanıcı 1-31 gün arasında kiralama süresi seçer.
Toplam fiyat otomatik hesaplanır.
Onay butonu örnek başarılı işlem mesajı gösterir.
Kiralanan araç ana sayfada yerel uygulama durumu üzerinden gösterilebilir.
Hasar kaydı ve konum
Fotoğraf ekleme ve konum seçimi için gösterim ekranları oluşturulur.
Gerçek kamera veya konum entegrasyonu zorunlu değildir.
Görsel yüklenmediyse örnek görsel alanı veya yer tutucu gösterilir.
Profil ve ayarlar
Örnek profil bilgileri gösterilir.
Açık/koyu tema değiştirilebilir.
Türkçe/İngilizce dil seçeneği arayüze uygulanır.
Yardım ekranında sıkça sorulan sorular bulunur.
7. Tamamlama Kontrolü

Her yeni özellik tamamlandığında:

Butonlar ve sayfa geçişleri çalışıyor.
Form doğrulamaları çalışıyor.
Örnek araç verileri doğru gösteriliyor.
Filtreleme ve sıralama sonuçları güncelleniyor.
Kiralama süresi 31 günü geçemiyor.
Toplam fiyat doğru hesaplanıyor.
Açık/koyu tema çalışıyor.
Gereksiz paket veya backend eklenmiyor.
Kod analizinden ve mevcut testlerden geçiyor.
flutter analyze  # Kod kalitesini kontrol eder.
flutter test     # Mevcut testleri çalıştırır.
flutter run      # Uygulamayı simülatörde başlatır.

8. Skill Kullanım Amacı

Bu skill yeni araç kiralama ekranı, form, araç kartı, tema veya yerel simülasyon geliştirilirken kullanılmalıdır.

Küçük bir arayüz değişikliğinde bütün uygulama yeniden oluşturulmaz. Önce mevcut dosyalar incelenir ve yalnızca gerekli değişiklikler yapılır.

Önemli: Bu proje bir prototiptir. Gerçek kullanıcı hesabı, kalıcı veri tabanı, gerçek ödeme, gerçek rezervasyon veya sunucu bağlantısı geliştirmek bu skill'in kapsamı dışındadır.