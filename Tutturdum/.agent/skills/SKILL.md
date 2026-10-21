name: tutturdum-flutter-feature-scaffold description: Tutturdum Flutter futbol bahis kuponu simülasyonu için modüler feature mimarisi, yerel veri yönetimi, ValueNotifier tabanlı durum yönetimi, test edilebilir iş mantığı ve yeniden kullanılabilir arayüz bileşenleri oluşturur. Gerçek ödeme, backend veya harici API gerektirmeyen demo uygulaması standartlarını uygular.
Tutturdum Flutter Feature Scaffold

Bu skill, Tutturdum projesine yeni bir ekran veya işlev eklenirken uygulanması gereken mimari, kod kalitesi, yerel veri yönetimi ve test standartlarını tanımlar.

Her geliştirme adımında proje kökündeki project.md dosyası ana referans kabul edilmelidir.

1. Projeye Özgü Temel Kurallar
Demo uygulaması: Gerçek bahis, gerçek para transferi, banka bağlantısı veya gerçek ödeme sistemi oluşturulmaz.
Backend yok: Temel işlevler herhangi bir sunucuya veya harici API'ye bağlı olmamalıdır.
Yerel veri: Kullanıcı kayıtları, sanal bakiye, kupon sepeti, kupon geçmişi ve diğer kalıcı demo verileri yerel olarak yönetilmelidir.
Modüler mimari: UI, controller, model ve veri erişim katmanları birbirinden ayrılmalıdır.
Reaktif arayüz: Durum değişiklikleri yalnızca gerekli UI bileşenlerini güncellemelidir.
Test edilebilirlik: İş mantığı Flutter arayüzünden bağımsız olarak test edilebilmelidir.
Tutarlı veri: Aynı takım, maç, oran veya kupon farklı ekranlarda farklı kimlik ya da çelişkili veriyle temsil edilmemelidir.
Gerçekmiş gibi gösterme: Yerel simülasyonlar gerçek ödeme, gerçek haber, gerçek oran veya gerçek yapay zekâ servisi olarak sunulmamalıdır.
2. Modül Oluşturma Standardı

Yeni bir modül oluşturulurken aşağıdaki yapıyı kullan:

lib/features/<feature_name>/
  controllers/
    <feature_name>_controller.dart

  models/
    <feature_name>_model.dart

  views/
    <feature_name>_view.dart

  widgets/
    <feature_name>_card.dart


Gerekliyse bir modüle services/ klasörü eklenebilir. Veri erişimi uygulama genelinde paylaşılacaksa lib/data/repositories/ altındaki repository sınıfları kullanılmalıdır.

Her modülün bu dosyaların tamamına sahip olması zorunlu değildir. Yalnızca gerçekten gerekli olan dosyalar oluşturulmalıdır.

Dosyaların sorumlulukları
Controller: UI durumunu, kullanıcı eylemlerini ve ilgili iş akışını yönetir.
Model: Veri alanlarını, dönüşümleri ve değişmez veri yapısını tanımlar.
View: Ekranın ana düzenini ve bileşenlerini bir araya getirir.
Widget: Tekrar kullanılabilir kart, satır, form veya kontrol bileşenlerini oluşturur.
Repository: Verileri yükler, kaydeder, günceller ve gerektiğinde siler.
Service: Para hesaplama, oran üretimi veya form doğrulama gibi bağımsız iş kurallarını yürütür.

Bir dosyaya birbiriyle ilgisiz çok sayıda sorumluluk yüklenmemelidir.

3. Durum Yönetimi Kuralları
3.1 Kullanılacak yaklaşım

Basit ve orta ölçekli durumlar için Flutter'ın yerleşik API'larını kullan:

ValueNotifier<T>
ValueListenableBuilder<T>
ChangeNotifier
Gerektiğinde ListenableBuilder

Projenin mevcut mimarisiyle uyumluysa ValueNotifier tercih edilmelidir. Aynı işi yapan birden fazla state management çözümü birlikte kullanılmamalıdır.

Gerekli olmadığı sürece yeni bir ağır state management paketi eklenmemelidir.

3.2 Merkezi durumlar

Aşağıdaki veriler birden fazla ekran tarafından kullanılacağı için merkezi olarak yönetilmelidir:

Oturum açmış kullanıcı.
Tema tercihi.
Sanal bakiye.
Kupon sepeti.
Kupon geçmişi.
Bildirim durumu.

Örneğin bakiye yalnızca ana sayfada tanımlanmamalıdır. Profil ekranındaki yükleme simülasyonu ve kupon ekranındaki bahis işlemi aynı bakiye yöneticisini kullanmalıdır.

3.3 Kaynak temizliği

Controller içinde oluşturulan her ValueNotifier veya dinleyici uygun yaşam döngüsünde temizlenmelidir.

void dispose() {
  balance.dispose();
  super.dispose();
}


Yukarıdaki örnekte super.dispose() yalnızca sınıf ChangeNotifier gibi ilgili bir üst sınıftan türemişse kullanılmalıdır.

3.4 Sayfa güncellemeleri
Her durum değişikliği tüm uygulamanın yeniden çizilmesine neden olmamalıdır.
Controller içindeki listeler güncellendiğinde yeni bir liste referansı oluşturulmalıdır.
Widget'lar mümkün olduğunca ilgili ValueListenableBuilder ile yalnızca ihtiyaç duydukları durumu dinlemelidir.
Durum değişiklikleri doğrudan başka bir ekranın widget ağacını değiştirmemelidir.
4. Model Oluşturma Standartları

Modeller mümkün olduğunca immutable olarak yazılmalıdır.

Örnek:

import 'package:flutter/foundation.dart';

@immutable
class DemoCouponSelection {
  final String id;
  final String matchId;
  final String marketName;
  final String selectionName;
  final double odds;

  const DemoCouponSelection({
    required this.id,
    required this.matchId,
    required this.marketName,
    required this.selectionName,
    required this.odds,
  });

  DemoCouponSelection copyWith({
    String? id,
    String? matchId,
    String? marketName,
    String? selectionName,
    double? odds,
  }) {
    return DemoCouponSelection(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      marketName: marketName ?? this.marketName,
      selectionName: selectionName ?? this.selectionName,
      odds: odds ?? this.odds,
    );
  }

  factory DemoCouponSelection.fromJson(Map<String, dynamic> json) {
    return DemoCouponSelection(
      id: json['id'] as String,
      matchId: json['matchId'] as String,
      marketName: json['marketName'] as String,
      selectionName: json['selectionName'] as String,
      odds: (json['odds'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'matchId': matchId,
      'marketName': marketName,
      'selectionName': selectionName,
      'odds': odds,
    };
  }
}


Bu model bir örnektir. Projede kullanılacak gerçek model isimleri ve alanları ilgili modülün ihtiyacına göre tanımlanmalıdır.

Model kuralları
Her model açık ve tutarlı alan isimlerine sahip olmalıdır.
İlişkili veriler kararlı kimliklerle bağlanmalıdır.
fromJson ve toJson dönüşümleri aynı veri biçimiyle uyumlu olmalıdır.
Hatalı veya eksik veriler kontrolsüz biçimde uygulamayı çökertmemelidir.
Modelin copyWith metodu nesnenin değişmezliğini korumalıdır.
Her model için gereksiz alanlar eklenmemelidir.
5. Yerel Depolama ve Repository Kuralları

Yerel veri erişimi UI dosyalarında yapılmamalıdır.

Repository kullanımı:

View
  ↓
Controller
  ↓
Repository
  ↓
Yerel depolama


Örneğin kupon geçmişi ekranı doğrudan JSON dosyası okumamalıdır. Controller, repository üzerinden kayıtları istemeli ve UI'ya göstermelidir.

Repository sorumlulukları
Veriyi yüklemek.
Yeni kayıt oluşturmak.
Mevcut kaydı güncellemek.
Gerektiğinde kaydı silmek.
Veriyi uygulamanın model sınıflarına dönüştürmek.
Hataları kontrol ederek çağıran katmana anlaşılır sonuç döndürmek.
Kalıcı kayıtlar

Aşağıdaki veriler gerektiğinde uygulama yeniden açıldığında korunmalıdır:

Kullanıcı profili.
Tema tercihi.
Sanal bakiye.
Kupon geçmişi.
Sepet durumu.
Sohbet geçmişi.
Bildirimlerin okunma durumu.

Geçici form verileri veya kart CVV alanı gibi hassas veriler kalıcı olarak saklanmamalıdır.

Yerel kayıt mekanizması seçilirken projenin mevcut paketleri kontrol edilmeli, aynı ihtiyaç için gereksiz birden fazla depolama paketi eklenmemelidir.

6. Para ve Kupon Hesaplamaları

Para hesaplaması UI içinde yapılmamalıdır.

Kupon hesaplaması bağımsız bir servis veya controller iş mantığı içinde yürütülmelidir.

6.1 Hesaplama kuralları
Her oran sıfırdan büyük olmalıdır.
Toplam oran bütün seçim oranlarının çarpımıdır.
Olası brüt dönüş, bahis tutarı ile toplam oranın çarpımıdır.
Net kazanç gösterilecekse brüt dönüşten bahis tutarı çıkarılmalıdır.
Minimum bahis tutarı 50 TL'dir.
Sepet boşken kupon oluşturulamaz.
Sanal bakiye yetersizse kupon işlemi tamamlanamaz.
Hesaplama ve bakiye güncellemesi aynı kontrollü iş akışında yürütülmelidir.
6.2 Para gösterimi

UI'da Türk lirası için tutarlı biçimlendirme kullanılmalıdır.

Hesaplamalarda kuruş tabanlı tam sayı veya uygun bir decimal yaklaşımı tercih edilmelidir. double ile yapılan çarpımlar kullanıcıya gösterilmeden önce kontrolsüz yuvarlamaya bırakılmamalıdır.

6.3 Kupon kaydı

Kupon geçmişine kayıt yapılırken aşağıdakiler saklanmalıdır:

Benzersiz kupon kimliği.
Kupon oluşturulma tarihi.
Seçilen maçlar.
Seçilen bahis pazarları.
Seçilen sonuçlar.
Seçim anındaki oranlar.
Toplam oran.
Bahis tutarı.
Olası brüt dönüş.
Simülasyon durumu.

Kaydedilmiş kupon geçmişi, daha sonra oranlar değişse bile aynı kalmalıdır.

7. Futbol Veri Modeli ve Tutarlılık

Ligler, takımlar, maçlar ve bahis seçenekleri ayrı modellerle temsil edilmelidir.

Önerilen ilişkiler:

League
  └── Teams
       └── Matches
            └── Odds Markets
                 └── Selections
                      └── Coupon

Kurallar
Her takımın kararlı bir kimliği olmalıdır.
Her maç bir lig ve iki takımla ilişkilendirilmelidir.
Ev sahibi ve deplasman takımları aynı olmamalıdır.
Bir maçın oranları maç kimliğiyle ilişkilendirilmelidir.
Aynı maç için farklı ekranlarda farklı takım eşleşmeleri üretilmemelidir.
Lig takım sayısı ile takım listesi aynı olmalıdır.
18 takımlı çift devreli ligde takım başına 34 maç bulunmalıdır.
20 takımlı çift devreli ligde takım başına 38 maç bulunmalıdır.
36 takımlı UEFA organizasyonları ayrı bir maç formatı üzerinden simüle edilmelidir.
Süper Lig başlangıç verisinde Beşiktaş birinci, Galatasaray sıfır puanla sonuncu sırada bulunmalıdır.

Rastgele veri üretimi gerektiğinde bir kez oluşturulan ve kararlı kimliklerle saklanan veriler tercih edilmelidir. Her ekran açılışında takımların, maçların veya oranların gelişigüzel değişmesi önlenmelidir.

8. UI ve Widget Standartları
Zorunlu yaklaşımlar
Statik widget'larda mümkün olduğunca const kullanılmalıdır.
Renkler ve metin stilleri merkezi tema sisteminden alınmalıdır.
build metotları mümkün olduğunca 40 satırın altında tutulmalıdır.
Uzun widget ağaçları bağımsız bileşenlere ayrılmalıdır.
Ortak buton, form alanı, kart ve boş durum bileşenleri tekrar kullanılabilir olmalıdır.
Formlar Form ve TextFormField gibi uygun Flutter bileşenleriyle doğrulanmalıdır.
Uzun listelerde ListView.builder gibi verimli liste bileşenleri kullanılmalıdır.
Yükleme, boş liste, hata ve başarılı işlem durumları uygun şekilde ele alınmalıdır.
Metin taşması ve küçük ekran uyumluluğu kontrol edilmelidir.
Dokunulabilir alanlar erişilebilir büyüklükte olmalıdır.
Tema kullanımı

Renkler, kart stilleri ve yazı biçimleri ekranlar arasında tutarlı olmalıdır.

Koyu ve aydınlık tema desteği merkezi ThemeController ve ThemeData üzerinden uygulanmalıdır. Her widget içinde bağımsız tema mantığı oluşturulmamalıdır.

9. Navigasyon Standartları

Ana navigasyon beş sekmeden oluşur:

Günün Bülteni
Kupon Oyna
Sepet
Kupon Geçmişi
Sohbet

Detay ekranları ilgili modülün navigasyon akışına dahil edilmelidir.

Kurallar
Sekmeler arası geçişte kupon sepeti korunmalıdır.
Ligden takıma, takımdan maça ve maçtan oranlara geçişte gerekli model veya kimlik aktarılmalıdır.
Geri dönüşte mümkün olduğunca önceki ekranın bağlamı korunmalıdır.
Profil, ayarlar ve bildirim ekranları ana navigasyon yapısıyla uyumlu olmalıdır.
Navigasyon mantığı tek bir ekranda gereksiz yere karmaşıklaştırılmamalıdır.
10. Form Doğrulama ve Gizlilik
Zorunlu alanlar kontrol edilmelidir.
Hata mesajları kullanıcıya anlaşılır biçimde gösterilmelidir.
E-posta, telefon ve diğer alanların biçimi doğrulanmalıdır.
TC kimlik numarası yalnızca demo giriş/kayıt alanıdır; resmî kimlik doğrulaması yapılmaz.
Gerçek kart bilgileri istenmemeli; örnek kart verileri kullanılması gerektiği belirtilmelidir.
CVV ve tam kart numarası kalıcı olarak saklanmamalıdır.
Şifreler düz metin biçiminde saklanmamalıdır.
Yerel kimlik doğrulamanın gerçek bir sunucu güvenliği sağlamadığı açıkça kabul edilmelidir.
Hassas kişisel veriler log kayıtlarına yazılmamalıdır.
11. Test Kuralları

Yeni bir işlev oluşturulduğunda ilgili iş mantığı için birim testi yazılmalıdır.

Controller testleri
Başarılı işlem.
Hatalı giriş.
Boş veri.
Sınır değerleri.
Durum güncellemeleri.
Kaydetme ve yeniden yükleme.
Kupon testleri
Tek oran seçiminin sepete eklenmesi.
Birden fazla oranın doğru çarpılması.
Aynı seçimin mükerrer eklenmesinin önlenmesi.
Minimum 50 TL kuralı.
Yetersiz bakiye kontrolü.
Başarılı işlemde bakiyenin doğru azalması.
Kupon geçmişine doğru kayıt yapılması.
Başarısız işlemde bakiye ve geçmişin değişmemesi.
Futbol veri testleri
Liglerin doğru takım sayısı.
18 takımlı liglerde takım başına 34 maç.
20 takımlı liglerde takım başına 38 maç.
Takım kimliklerinin benzersizliği.
Maçlarda aynı takımın iki tarafta yer almaması.
Beşiktaş ve Galatasaray özel sıralama koşulları.
Çalıştırılacak komutlar
flutter analyze
flutter test
flutter run


Hatalı analiz veya başarısız testler görmezden gelinmemelidir.

12. Antigravity İçin Özellik Geliştirme İş Akışı

Yeni bir özellik geliştirilirken aşağıdaki sıra uygulanmalıdır.

Adım 1: Mevcut projeyi incele
project.md dosyasını oku.
İlgili modülün mevcut dosyalarını incele.
Projede kullanılan tema, navigasyon, depolama ve durum yönetimi yaklaşımlarını belirle.
Gereksiz yeni paket ekleme.
Adım 2: Veri modelini tanımla
Gerekli alanları belirle.
Benzersiz kimlikleri tanımla.
JSON dönüşümleri gerekiyorsa oluştur.
Veri ilişkilerini açıkça tanımla.
Adım 3: İş mantığını oluştur
Controller veya service sınıfını yaz.
Girdi doğrulamalarını ekle.
Hata durumlarını ele al.
Yerel kayıt gerekiyorsa repository kullan.
İş mantığını widget'lardan bağımsız tut.
Adım 4: Arayüzü oluştur
View dosyasını oluştur.
Tekrar kullanılabilir widget'ları ayır.
Tema sistemini kullan.
Yükleme, boş durum, hata ve başarı durumlarını tasarla.
Mobil ekranlarda taşma olup olmadığını kontrol et.
Adım 5: Navigasyonu bağla
Ekran geçişlerini tanımla.
Gerekli model ve kimlikleri aktar.
Geri dönüş davranışını kontrol et.
Merkezi durumun korunduğundan emin ol.
Adım 6: Test et
Controller birim testlerini yaz.
Gerekli widget testlerini ekle.
flutter analyze çalıştır.
flutter test çalıştır.
Gerekirse flutter run ile gerçek ekran akışını doğrula.
Adım 7: Tamamlanma kontrolü

Bir özellik ancak aşağıdaki koşullar sağlandığında tamamlanmış kabul edilir:

İlgili ekran açılıyor.
İlgili butonlar işlevini yerine getiriyor.
Durum değişiklikleri UI'ya yansıyor.
Veri gerekiyorsa doğru kaydediliyor.
Hata ve sınır durumları ele alınıyor.
Testler başarılı.
Proje genelindeki diğer işlevler bozulmamış.
13. Kesinlikle Yapılmaması Gerekenler
Bütün uygulamayı tek bir main.dart dosyasına yazmak.
UI içine veritabanı veya dosya erişimi yerleştirmek.
Bakiye hesabını farklı ekranlarda ayrı ayrı uygulamak.
Kupon toplam oranını her widget içinde tekrar hesaplamak.
Her ekran açılışında tutarsız rastgele lig ve maç verileri üretmek.
Çalışmayan butonlar bırakmak.
Test edilmemiş özellikleri tamamlanmış ilan etmek.
Gerçek ödeme yapılıyormuş gibi davranmak.
Gerçek maç oranları veya gerçek yapay zekâ kullanıldığı izlenimini vermek.
Kullanıcının kart bilgilerini veya CVV değerini kalıcı depolamak.
Hataları gizlemek veya başarısız kayıtları başarılı gibi göstermek.
Gereksiz paketler, yinelenen controller'lar veya kullanılmayan dosyalar oluşturmak.
14. Nihai Hedef

Bu skill'in amacı, Tutturdum projesinde her yeni özelliğin aynı mimari ve kalite standartlarıyla geliştirilmesini sağlamaktır.

Ortaya çıkacak uygulama:

Flutter ile çalışmalı.
Antigravity IDE tarafından sürdürülebilir olmalı.
Modüler ve test edilebilir kod içermeli.
Yerel verilerle çalışmalı.
Gerçek ödeme veya backend gerektirmemeli.
Kullanıcının kayıt, giriş, futbol ligleri, maçlar, oranlar, kupon, sanal bakiye, geçmiş, bildirim ve sohbet akışlarını tamamlamasına izin vermelidir.

Ana kural: Görsel olarak tamamlanmış ama butonları çalışmayan bir ekran yeterli değildir. Her özellik, demo sınırları içinde gerçek bir kullanıcı etkileşimi ve tutarlı bir iş akışı sunmalıdır.