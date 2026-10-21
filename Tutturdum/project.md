Tutturdum – Flutter Futbol Bahis Kuponu Simülasyonu Proje Kılavuzu

Bu doküman, Tutturdum isimli Flutter uygulamasının geliştirilmesinde Antigravity IDE, yapay zekâ ajanları ve yazılım geliştiriciler için temel proje şartnamesidir.

Projede oluşturulan bütün kodlar, ekranlar, veri modelleri ve işlevler bu dokümanda belirtilen kurallara uygun olmalıdır.

Önemli proje sınırı: Tutturdum, eğitim ve ödev amacıyla geliştirilen, gerçek para veya gerçek bahis işlemi gerçekleştirmeyen bir mobil uygulama prototipidir. Gerçek bir bahis platformu değildir. Gerçek ödeme, para transferi, bahis sağlayıcısı, harici API, sunucu veya çevrim içi veritabanı kullanılmayacaktır.

1. Proje Özeti ve Teknolojiler
Uygulama adı: Tutturdum
Proje türü: Futbol bahis kuponu simülasyonu ve mobil uygulama prototipi
Ana teknoloji: Flutter
Programlama dili: Dart
IDE: Antigravity IDE
Hedef platformlar: Öncelikle Android ve iOS simülatörleri; geliştirme ortamına uygun diğer Flutter platformları desteklenebilir.
Flutter sürümü: Geliştirme ortamında kurulu, kararlı Flutter SDK sürümü kullanılmalıdır.
Tasarım sistemi: Material 3
Mimari: Feature-based modüler yapı, katmanlara ayrılmış iş mantığı ve yerel veri saklama.
Durum yönetimi: Flutter'ın yerleşik ValueNotifier, ValueListenableBuilder ve gerektiğinde ChangeNotifier API'ları.
Yerel depolama: Küçük ölçekli demo verileri için uygun bir yerel depolama paketi veya Flutter'ın yerleşik dosya/veri olanakları. Paket seçimi gereksinime göre yapılmalıdır.
Ağ bağlantısı: Uygulamanın temel işlevleri için gerekli değildir.
Backend/API: Kullanılmayacaktır.
Gerçek ödeme sistemi: Kullanılmayacaktır.
Yapay zekâ servisi: Kullanılmayacaktır. Yapay zekâ tarafından oluşturulması istenen içerikler yerel kurallar, hazır veri kümeleri ve kontrollü rastgele üretim ile simüle edilecektir.
1.1 Temel amaç

Kullanıcının kayıt ve giriş ekranlarından geçebildiği, futbol liglerini ve takımlarını inceleyebildiği, maçlara ait örnek oranları seçebildiği, kupon oluşturabildiği, sanal bakiye üzerinden bahis simülasyonu yapabildiği ve kupon geçmişini görebildiği çalışan bir mobil prototip oluşturmak.

Tasarım, gerçek bir futbol bahis uygulamasının kullanıcı deneyimini örnek alabilir ancak bütün işlemler açıkça demo ve sanal veri mantığıyla çalışmalıdır.

1.2 Geliştirme öncelikleri
Uygulamanın açılması ve sorunsuz çalışması.
Bütün ekranlar ve butonlar arasında doğru navigasyon.
Doğru kupon hesaplamaları ve tutarlı sanal bakiye.
Lig, takım, maç ve oran verilerinin birbiriyle uyumlu olması.
Kullanıcı verilerinin ve kupon geçmişinin yerel olarak saklanması.
Modern, tutarlı ve mobil cihazlara uyumlu tasarım.
Test edilebilir, modüler ve bakımı kolay kod.
2. Uygulamanın Genel Tasarımı

Tutturdum, koyu ve aydınlık tema desteğine sahip, futbol odaklı ve modern bir arayüz kullanmalıdır.

2.1 Görsel tasarım

Önerilen tasarım yönü:

Koyu tema – Football Night

Ana arka plan: #0B0F14
İkincil arka plan: #121922
Kart yüzeyi: #19232D
Ana vurgu: #22C55E
İkincil vurgu: #38BDF8
Ana metin: #F8FAFC
İkincil metin: #94A3B8
Hata: #EF4444
Ayırıcılar: #2A3642

Aydınlık tema – Stadium Light

Ana arka plan: #F5F7FA
Kart yüzeyi: #FFFFFF
Ana vurgu: #16A34A
İkincil vurgu: #0284C7
Ana metin: #17212B
İkincil metin: #64748B
Ayırıcılar: #E2E8F0

Renkler merkezi AppColors sınıfında tanımlanmalı ve ekranlara doğrudan sabit renkler yazılmamalıdır. Tema yapılandırması ThemeData üzerinden yapılmalıdır.

2.2 Kullanıcı deneyimi
Alt navigasyon sabit ve kolay erişilebilir olmalıdır.
Kartlar, ligler, takımlar, maçlar ve oran seçenekleri belirgin tıklama alanlarına sahip olmalıdır.
Sayfalar arasında geri dönüş davranışı doğru çalışmalıdır.
Form alanları doğrulanmalıdır.
Kullanıcıya başarılı ve hatalı işlemlerde anlaşılır mesajlar gösterilmelidir.
Para tutarları Türk lirası biçiminde gösterilmelidir.
Oranlar ve hesaplanan tutarlar tutarlı sayısal formatta sunulmalıdır.
Dar ekranlarda taşma ve yatay kayma sorunları oluşmamalıdır.
Boş listeler, hatalı girişler ve yetersiz bakiye durumları için özel arayüzler bulunmalıdır.
3. Uygulama Ekranları ve İşlevleri
3.1 Giriş ekranı

Uygulama ilk açıldığında giriş ekranı gösterilmelidir.

Ekran içeriği:

Tutturdum logosu veya metinsel marka alanı.
Kullanıcı adı alanı.
Kullanıcı adı alanında ad soyad veya TC kimlik numarası ile giriş seçeneği.
Şifre alanı.
Şifre görünürlüğünü değiştiren kontrol.
Giriş yap butonu.
Hesabı olmayan kullanıcılar için Kayıt Ol butonu.

Giriş işlemi yerel kullanıcı kayıtları üzerinden yapılmalıdır. Doğru bilgiler girildiğinde ana sayfaya geçilmelidir. Yanlış bilgilerde hata mesajı gösterilmelidir.

İlk açılışta kayıtlı kullanıcı yoksa kullanıcı kayıt ekranına yönlendirilebilir. Demo amacıyla otomatik bir demo hesabı oluşturulacaksa bunun bilgileri açıkça belirtilmeli ve gerçek kullanıcı hesabı gibi sunulmamalıdır.

3.2 Kayıt ekranı

Aşağıdaki alanlar zorunludur:

İş adı değil, kullanıcının gerçek ad ve soyadı için Ad Soyad alanı.
TC kimlik numarası.
Telefon numarası.
E-posta adresi.
Şifre.
Şifre doğrulama alanı.

Ekranın alt kısmında Kayıt İşlemini Tamamla butonu bulunmalıdır.

Doğrulama kuralları:

Boş alanlar kabul edilmemelidir.
E-posta biçimi kontrol edilmelidir.
Telefon alanı uygun biçimde doğrulanmalıdır.
Şifre için makul bir minimum uzunluk uygulanmalıdır.
Şifre doğrulama alanı şifreyle eşleşmelidir.
Aynı kullanıcı adı, TC kimlik numarası veya e-posta ile ikinci bir hesap oluşturulması engellenmelidir.
TC kimlik numarası için biçim kontrolü uygulanmalıdır. Gerçek kimlik doğrulaması yapılmadığı açık olmalıdır.

Kayıt başarılı olunca kullanıcı bilgileri yerel depolamaya kaydedilmeli, kullanıcı giriş ekranına döndürülmeli ve başarı mesajı gösterilmelidir.

Gizlilik: TC kimlik numarası, telefon, e-posta ve şifre gerçek bir servise gönderilmemelidir. Mümkünse prototipte gerçek kişisel veriler yerine örnek bilgiler kullanılmalıdır. Şifreler düz metin olarak kalıcı depolanmamalıdır. Yerel prototipte bile uygun bir hash yaklaşımı tercih edilmeli; kullanılan çözüm güvenli kimlik doğrulama altyapısı olarak tanıtılmamalıdır.

3.3 Ana sayfa – Günün Bülteni

Giriş başarılı olduktan sonra ana sayfa açılmalıdır. İlk sekme varsayılan olarak Günün Bülteni olmalıdır.

Üst bölüm:

Sol üstte profil simgesi.
Ortada veya belirgin bir konumda sanal bakiye.
Sağ üstte bildirim simgesi.

İçerik:

Futbol haber kartları.
Öne çıkan maçlar.
Günün futbol gündemi.
Yerel olarak üretilen örnek bildirimler ve haber içerikleri.

Haberler hazır bir veri kümesinden seçilebilir. Rastgele seçim kullanılacaksa aynı oturumda gereksiz tekrarlardan kaçınılmalıdır. Gerçek zamanlı haber veya internetten veri çekildiği iddia edilmemelidir.

3.4 Alt navigasyon

Ana uygulama bölümünde beş sekme bulunmalıdır:

Günün Bülteni
Kupon Oyna
Sepet
Kupon Geçmişi
Sohbet

Navigasyon tercihen NavigationBar veya uygun bir Material 3 alt navigasyon bileşeniyle uygulanmalıdır.

Sekmeler arasında geçiş yapıldığında gerekli durum korunmalıdır. Örneğin kullanıcı kupon seçenekleri belirledikten sonra başka sekmeye geçerse sepeti kaybolmamalıdır.

3.5 Profil ve ayarlar

Ana sayfanın sol üstündeki profil simgesi profil menüsünü açmalıdır.

Menü seçenekleri:

Hesap Bilgileri
Ayarlar
Tema Seçimi
Kart Bilgileri
Oturumu Kapat

Hesap bilgileri ekranında kayıt sırasında girilen bilgiler görüntülenmelidir. Hassas alanlar mümkün olduğunca maskelenmelidir.

Ayarlar ekranında tema seçimi bulunmalıdır:

Sistem varsayılanı
Açık tema
Koyu tema

Tema seçimi uygulamanın tamamına uygulanmalı ve tercihen yeniden açılışta korunmalıdır.

3.6 Kart bilgileri ve sanal bakiye

Kart Bilgileri ekranında şu alanlar bulunmalıdır:

Kart sahibi adı soyadı.
Kart numarası.
Son kullanma tarihi.
CVV alanı.
Yüklenecek tutar.
Tamamla/Yükle butonu.

Bu ekran yalnızca arayüz ve sanal bakiye simülasyonu içindir.

Gerçek kart verileri hiçbir şekilde işlenmemeli veya kalıcı depolanmamalıdır. Kart alanlarına örnek/test verisi girilmesi gerektiği arayüzde belirtilmelidir. CVV ve kart numarası uygulama yeniden açıldığında geri getirilecek şekilde kaydedilmemelidir.

Kullanıcı geçerli bir demo tutarı girdiğinde işlem başarılı mesajıyla tamamlanmalı ve sanal bakiye artırılmalıdır. Gerçek ödeme, banka bağlantısı veya karttan para çekme işlemi yapılmamalıdır.

Sanal bakiye için tek bir merkezi durum yöneticisi kullanılmalıdır. Ana sayfa, profil ve kupon işlemleri aynı bakiye değerini kullanmalıdır.

3.7 Bildirimler

Sağ üstteki bildirim simgesi bildirimler ekranını açmalıdır.

Örnek bildirim türleri:

Demo maç hatırlatması.
Örnek kupon durumu.
Uygulama içi duyuru.
Sanal bakiye işlemi bildirimi.

Bildirimler yerel verilerden üretilmeli veya hazır listeden seçilmelidir. Okundu/okunmadı durumu uygulama içinde tutulabilir. Gerçek push bildirimi altyapısı kurulmayacaktır.

4. Kupon Oyna Modülü

Bu modül uygulamanın en kapsamlı özelliğidir.

4.1 Lig seçimi ekranı

Ligler kart veya kutu şeklinde gösterilmelidir.

Desteklenecek ligler:

Lig	Takım sayısı
Süper Lig	18
Premier Lig	20
LaLiga	20
Serie A	20
Bundesliga	18
Fransa Ligi	18
Portekiz Ligi	18
Hollanda Ligi	18
Şampiyonlar Ligi	36
Avrupa Ligi	36
Konferans Ligi	36

Her lig kartında lig adı, simgesi veya logosu için uygun bir görsel alan ve takım sayısı gösterilmelidir.

Lig kartına dokunulduğunda ilgili ligin detay ekranı açılmalıdır.

4.2 Lig detay ekranı

Lig detay ekranında puan tablosu ve takımlar bulunmalıdır.

Lig tablosu alanları:

Sıra.
Takım adı.
Oynanan maç.
Galibiyet.
Beraberlik.
Mağlubiyet.
Atılan gol.
Yenilen gol.
Averaj.
Puan.

Süper Lig için özel demo gereksinimi:

Beşiktaş birinci sırada ve lider olmalıdır.
Galatasaray sıfır puanla son sırada olmalıdır.

Bu özel sıralama yalnızca prototipin başlangıç veri kümesinde uygulanmalıdır. Diğer takımların puanları ve sıralamaları tutarlı örnek verilerle doldurulmalıdır.

Takım sayısı, puan tablosundaki takım sayısıyla eşleşmelidir.

Takım adları ve sezon maçları veri katmanında tutulmalı; ekran kodlarına dağınık şekilde sabitlenmemelidir.

4.3 Takım detay ekranı

Kullanıcı puan tablosundan bir takıma dokunduğunda takım detay ekranı açılmalıdır.

Ekranda:

Takım adı.
Bağlı olduğu lig.
Sezonun ilk yarısı.
Sezonun ikinci yarısı.
Takımın o sezondaki maç programı.

18 takımlı liglerde her takım için toplam 34 maç, 20 takımlı liglerde toplam 38 maç oluşturulmalıdır.

18 takımlı ligler: İlk yarı 17 maç, ikinci yarı 17 maç.
20 takımlı ligler: İlk yarı 19 maç, ikinci yarı 19 maç.

Her takımın maç programı tutarlı şekilde oluşturulmalıdır. Aynı maçta iki farklı takımın karşılaşması, ev sahibi ve deplasman takımları açısından birbiriyle uyumlu olmalıdır.

UEFA organizasyonlarındaki 36 takımlı lig aşaması, geleneksel çift devreli lig formatı gibi modellenmemelidir. Bu organizasyonlar için ayrı bir demo maç formatı kullanılmalıdır. Takım sayısının 36 olması her takımın 35 rakibin tamamıyla iki kez oynadığı anlamına gelmez.

Maç kartlarında:

Ev sahibi takım.
Deplasman takımı.
Tarih ve saat.
Hafta veya maç günü.
Maçın durumu.
Oranlara gitme kontrolü.

Maç kartına tıklandığında maç oranları ekranı açılmalıdır.

4.4 Maç oranları ekranı

Her maç için aşağıdaki oran grupları desteklenmelidir.

Maç sonucu

1: Ev sahibi galibiyeti.
X: Beraberlik.
2: Deplasman galibiyeti.

Çifte şans

1X
12
X2

Handikaplı maç sonucu

Handikaplı maç sonucu 1-0: 1, X, 2.
Handikaplı maç sonucu 0-1: 1, X, 2.
Handikaplı maç sonucu 2-0: 1, X, 2.

Handikapın hangi takıma uygulandığı kullanıcı arayüzünde açıkça belirtilmelidir. Seçenek etiketleri ile hesaplama mantığı birbiriyle tutarlı olmalıdır.

Maç sonu toplam gol alt/üst

1.5 Alt / Üst
2.5 Alt / Üst
3.5 Alt / Üst
4.5 Alt / Üst

Karşılıklı gol

Var
Yok

Takım gol bahisleri

Ev sahibi takım gol alt/üst.
Deplasman takımı gol alt/üst.

İlk yarı bahisleri

İlk yarı maç sonucu 1/X/2.
İlk yarı çifte şans.
İlk yarı toplam gol alt/üst.
İlk yarı karşılıklı gol.

Diğer örnek bahis seçenekleri

İlk golü atan takım.
Son golü atan takım.
Tek/çift toplam gol.
Ev sahibi takım gol atar mı?
Deplasman takımı gol atar mı?
Penaltı olur mu? Evet/Hayır.
Kırmızı kart olur mu? Evet/Hayır.

Bu seçenekler gerçek bahis sağlayıcısının tam ve kesin oran kataloğu olarak sunulmayacaktır. Amaç, yeterli sayıda etkileşimli bahis seçeneğiyle çalışan bir demo oluşturmaktır.

4.5 Oran üretimi

Oranlar internetten veya harici API'den alınmayacaktır.

Her maç için yerel olarak örnek oranlar oluşturulmalıdır.

Kurallar:

Oranlar sıfırdan büyük olmalıdır.
Oranlar makul, okunabilir bir aralıkta tutulmalıdır.
Aynı maç ve bahis seçeneği ekrana tekrar açıldığında oranların gereksiz yere değişmesi önlenmelidir.
Bunun için maç kimliği üzerinden deterministik üretim veya başlangıçta oluşturulan sabit demo veri kümesi kullanılabilir.
Bir kupon seçildiğinde seçilen oran, kuponda sabitlenmelidir.
Kupon geçmişine kaydedilmiş oranlar sonradan değişmemelidir.

Bir maçın bahis seçenekleri kategori başlıkları altında kartlar veya seçim butonları şeklinde sunulmalıdır.

4.6 Sepete oran ekleme

Kullanıcı bir oranı seçtiğinde seçim sepet ekranına eklenmelidir.

Her seçim için:

Maç kimliği.
Lig.
Ev sahibi takım.
Deplasman takımı.
Bahis kategorisi.
Seçilen seçenek.
Seçim anındaki oran.

Aynı maçtan birden fazla farklı seçim yapılması isteniyorsa bunun davranışı açıkça tanımlanmalıdır. Varsayılan olarak aynı maç ve aynı bahis pazarı için çakışan seçimler kontrol edilmelidir. Kullanıcı aynı seçimi tekrar ekleyerek mükerrer kupon satırları oluşturmamalıdır.

Kullanıcıya oran seçiminin sepete eklendiğini gösteren anlaşılır bir bildirim verilmelidir.

5. Sepet ve Kupon Hesaplama Sistemi
5.1 Sepet ekranı

Sepet sekmesinde seçilmiş tüm bahisler gösterilmelidir.

Her satırda:

Maç bilgisi.
Bahis türü.
Seçilen sonuç.
Oran.
Seçimi kaldırma kontrolü.

Ayrıca:

Toplam oran.
Bahis tutarı giriş alanı.
Minimum bahis tutarı.
Olası kazanç.
Kuponu Oyna butonu.
Sepeti temizle kontrolü.
5.2 Hesaplama kuralları

Toplam oran, sepetteki bütün seçim oranlarının çarpımıdır.

Örnek:

Birinci oran: 1.50
İkinci oran: 2.00
Üçüncü oran: 1.80

Toplam oran:

1.50 × 2.00 × 1.80 = 5.40

Olası brüt dönüş:

Bahis tutarı × Toplam oran

Örneğin 50 TL bahis ve 5.40 toplam oran için:

50 × 5.40 = 270 TL

Bu tutar, demo hesaplamasında olası brüt dönüş olarak gösterilmelidir. Net kazanç ayrıca gösterilecekse bahis tutarı düşülerek hesaplanmalıdır.

Kurallar:

Minimum bahis tutarı 50 TL'dir.
Boş kupon oynanamaz.
Geçersiz veya negatif tutar kabul edilmez.
Tutar 50 TL'den düşükse işlem engellenir.
Sanal bakiye yetersizse işlem engellenir.
Para hesaplamalarında kayan nokta hatalarını önlemek için kuruş tabanlı tam sayı veya uygun decimal yaklaşımı kullanılmalıdır.
Kupon hesaplaması tek bir iş mantığı sınıfında yapılmalıdır.
UI içinde dağınık hesaplama yapılmamalıdır.
5.3 Kuponu oynama

Kuponu Oyna butonuna tıklandığında:

Kupon ve bahis tutarı doğrulanır.
Sanal bakiye kontrol edilir.
Bakiye, bahis tutarı kadar azaltılır.
Kupon benzersiz bir kimlikle oluşturulur.
Seçimler, oranlar, toplam oran, bahis tutarı ve olası dönüş sabitlenir.
Kupon geçmişine yerel olarak kaydedilir.
Sepet temizlenir.
Kullanıcıya başarılı işlem mesajı gösterilir.

Bu işlem gerçek bahis veya gerçek para transferi değildir. Kuponun sonucu gerçek maçlara göre takip edilmeyecekse durum Simülasyon veya Bekliyor şeklinde gösterilmelidir. Sonuç ve kazanç gerçekleşmiş gibi gösterilmemelidir.

Bir hata oluşursa bakiye eksilmemeli ve kupon geçmişine yarım kayıt yazılmamalıdır. İşlem mümkün olduğunca tek bir kontrollü iş akışı olarak yürütülmelidir.

6. Kupon Geçmişi

Kupon Geçmişi sekmesi daha önce oluşturulan demo kuponlarını listelemelidir.

Her kupon kartında:

Kupon numarası.
Tarih ve saat.
Seçim sayısı.
Toplam oran.
Bahis tutarı.
Olası brüt dönüş.
Simülasyon durumu.

Kupon detayına tıklandığında kupondaki bütün maçlar ve seçilen oranlar gösterilmelidir.

Geçmiş kayıtları uygulama kapatılıp açıldığında da yerel depolama üzerinden yüklenmelidir.

Kayıtlı kuponların oranları ve tutarları değiştirilememelidir.

7. Sohbet Modülü

Sohbet sekmesinde futbol hakkında konuşan örnek bot kullanıcılar bulunmalıdır.

Özellikler:

Bot kullanıcı adı ve profil simgesi.
Mesaj metni.
Mesaj zamanı.
Kullanıcı mesajı gönderme alanı.
Gönder butonu.
Kaydırılabilir mesaj listesi.

Bot mesajları hazır mesaj havuzundan seçilmeli veya yerel kurallarla oluşturulmalıdır.

Örnek konu başlıkları:

Takımların performansı.
Yaklaşan maçlar.
Örnek maç değerlendirmeleri.
Futbol haberleri.
Eğlence amaçlı tahmin sohbetleri.

Gerçek yapay zekâ servisi veya çevrim içi kullanıcılar bulunmadığı açık olmalıdır. Botlar yerel simülasyon kullanıcılarıdır.

Kullanıcı mesaj gönderdiğinde mesaj listeye eklenmeli ve gerektiğinde ilgili mesaj havuzundan bir demo bot yanıtı oluşturulmalıdır. Botun yanıtı gerçek analiz veya güvenilir bahis tavsiyesi olarak sunulmamalıdır.

8. Yerel Veri Yönetimi

Uygulamanın temel verileri cihaz üzerinde tutulmalıdır.

Saklanabilecek veriler:

Demo kullanıcı profili.
Tema tercihi.
Sanal bakiye.
Sepetteki seçimler.
Kupon geçmişi.
Okundu/okunmadı bildirim bilgileri.
Sohbet mesajları.
Gerekli demo ayarları.

Sabit veya oluşturulmuş futbol verileri ayrı veri dosyalarında ya da repository sınıflarında tutulmalıdır.

Önerilen veri katmanı:

UserRepository
LeagueRepository
MatchRepository
OddsRepository
WalletRepository
CouponRepository
NotificationRepository
ChatRepository

Repository'ler uygulamanın yerel veri kaynağıyla çalışmalıdır. Harici API kullanıldığı izlenimi veren sahte ağ istekleri eklenmemelidir.

Yerel depolama seçimi:

Basit ayarlar için shared_preferences değerlendirilebilir.
İlişkili ve kalıcı kayıtlar için uygun bir yerel veritabanı veya yapılandırılmış dosya depolaması seçilebilir.
Seçilen paket projenin gerçek gereksinimleriyle uyumlu olmalıdır.
Aynı veriyi farklı dosyalarda birbiriyle çelişecek şekilde saklamaktan kaçınılmalıdır.
9. Önerilen Proje Klasör Yapısı
lib/
  main.dart

  app/
    app.dart
    app_router.dart

  core/
    constants/
      app_colors.dart
      app_constants.dart

    theme/
      app_theme.dart
      theme_controller.dart

    utils/
      currency_formatter.dart
      input_validators.dart
      id_generator.dart

    storage/
      local_storage_service.dart

    widgets/
      app_button.dart
      app_text_field.dart
      empty_state.dart
      loading_view.dart

  data/
    demo/
      demo_leagues.dart
      demo_teams.dart
      demo_matches.dart
      demo_news.dart
      demo_chat_messages.dart

    repositories/
      user_repository.dart
      league_repository.dart
      match_repository.dart
      odds_repository.dart
      wallet_repository.dart
      coupon_repository.dart
      notification_repository.dart
      chat_repository.dart

  features/
    auth/
      models/
      controllers/
      views/
      widgets/

    home/
      models/
      controllers/
      views/
      widgets/

    profile/
      models/
      controllers/
      views/
      widgets/

    wallet/
      models/
      controllers/
      views/
      widgets/

    notifications/
      models/
      controllers/
      views/
      widgets/

    leagues/
      models/
      controllers/
      views/
      widgets/

    teams/
      models/
      controllers/
      views/
      widgets/

    matches/
      models/
      controllers/
      views/
      widgets/

    odds/
      models/
      controllers/
      views/
      widgets/

    coupon_cart/
      models/
      controllers/
      views/
      widgets/

    coupon_history/
      models/
      controllers/
      views/
      widgets/

    chat/
      models/
      controllers/
      views/
      widgets/

test/
  core/
  data/
  features/


Bu yapı başlangıç için öneridir. İhtiyaç duyulmayan boş dosyalar oluşturulmamalıdır. Yeni modüller aynı mimari prensiplerle eklenmelidir.

10. Mimari ve Kod Kalitesi Kuralları
10.1 Sorumluluk ayrımı
View dosyaları arayüzü oluşturur.
Controller dosyaları ekran durumunu ve kullanıcı etkileşimlerini yönetir.
Model dosyaları veri yapılarını tanımlar.
Repository dosyaları veriye erişim ve saklama işlemlerini yönetir.
Hesaplama ve doğrulama mantığı uygun servis veya yardımcı sınıflarda tutulur.

Bütün uygulama tek bir Dart dosyasına yazılmamalıdır.

10.2 Durum yönetimi
Ekranın tamamını gereksiz yere yeniden çizdiren büyük setState kullanımlarından kaçınılmalıdır.
Yerel ve basit durumlarda ValueNotifier ve ValueListenableBuilder kullanılmalıdır.
Birden fazla ekranı etkileyen bakiye, tema ve kupon sepeti gibi durumlar merkezi bir controller veya uygun bir uygulama kapsamlı durum yöneticisi üzerinden paylaşılmalıdır.
Controller içinde oluşturulan dinleyiciler ve notifier nesneleri gerektiğinde dispose() ile temizlenmelidir.
Liste güncellemelerinde yeni liste referansı oluşturularak reaktif güncelleme sağlanmalıdır.
10.3 Widget kuralları
Statik widget'larda mümkün olduğunca const kullanılmalıdır.
Renkler ve yazı stilleri merkezi temadan alınmalıdır.
build metotları mümkün olduğunca 40 satırı aşmamalıdır. Aşan bölümler bağımsız widget'lara ayrılmalıdır.
Aynı işlevi yapan widget'lar tekrar kullanılabilir şekilde tasarlanmalıdır.
Uzun formlar ve listeler uygun Flutter bileşenleriyle oluşturulmalıdır.
Formlar klavye açıldığında kullanılabilir durumda kalmalıdır.
10.4 Model kuralları
Modeller mümkün olduğunca immutable olmalıdır.
Uygun modellerde copyWith, toJson ve fromJson metotları bulunmalıdır.
Para ve oran alanlarında veri türleri dikkatle seçilmelidir.
İlişkili nesneler adlarıyla değil mümkün olduğunca kararlı kimliklerle birbirine bağlanmalıdır.
Tarihler için DateTime kullanılmalı ve yerel gösterim ayrı biçimlendirilmelidir.
10.5 Navigasyon
Ana alt navigasyon ve detay sayfalarının navigasyon davranışı birbirinden ayrılmalıdır.
Ekran geçişlerinde seçili lig, takım, maç veya kupon verisi açıkça aktarılmalıdır.
Geri tuşu davranışı kontrol edilmelidir.
Alt sekmeler arasında geçiş yapıldığında sepet ve diğer önemli durumlar korunmalıdır.
11. Güvenilirlik ve Veri Tutarlılığı

Aşağıdaki kurallar zorunludur:

Sanal bakiye tek bir doğruluk kaynağına sahip olmalıdır.
Bakiye yükleme simülasyonu ve kupon oynama aynı bakiye sistemini kullanmalıdır.
Kupon oluşturulurken bakiye ve kupon geçmişi tutarlı güncellenmelidir.
Başarısız işlem bakiye kaybına neden olmamalıdır.
Oranlar pozitif olmalıdır.
Kupon toplam oranı seçim oranlarının çarpımıyla eşleşmelidir.
Liglerin takım sayıları belirtilen sayılarla eşleşmelidir.
Normal liglerin takım maç programları doğru toplam maç sayısını sağlamalıdır.
Kupon geçmişi kayıtları değişmez bir geçmiş kaydı olarak tutulmalıdır.
Yerel veri okunamadığında uygulama çökmeden anlaşılır bir hata veya güvenli varsayılan durum göstermelidir.
Önemli yerel veri güncellemelerinde yarım kayıt ve çakışma riskleri azaltılmalıdır.
12. Test Standartları

Her önemli geliştirme adımından sonra aşağıdaki komutlar çalıştırılmalıdır.

Statik analiz
flutter analyze

Testler
flutter test

Uygulamayı çalıştırma
flutter run

Asgari test senaryoları
Kayıt formunun boş alanları reddetmesi.
Başarılı kayıt ve giriş akışı.
Hatalı şifreyle girişin engellenmesi.
Tema değişiminin bütün ekranlara uygulanması.
Liglerin doğru sayıda takım göstermesi.
18 takımlı ve 20 takımlı liglerin maç sayılarının doğrulanması.
Oran seçimlerinin sepete eklenmesi ve kaldırılması.
Toplam oran çarpımının doğruluğu.
50 TL minimum bahis kuralı.
Yetersiz bakiye durumunda kuponun oynanamaması.
Başarılı kupon işleminde bakiyenin doğru azalması.
Kuponun geçmişe kaydedilmesi.
Uygulama yeniden açıldığında yerel kayıtların korunması.
Kart alanlarının gerçek ödeme işlemi başlatmaması.
Sohbette kullanıcı mesajının görüntülenmesi.
13. Antigravity IDE İçin Çalışma Kuralları

Antigravity, bu projede yalnızca kod üretmekle kalmamalı; mevcut kodu incelemeli, mimariyi korumalı ve yaptığı değişiklikleri doğrulamalıdır.

Yeni özellik eklemeden önce ilgili dosyalar incelenmelidir.
Var olan çalışan işlevler gereksiz yere silinmemelidir.
Dosya ve sınıf isimleri tutarlı tutulmalıdır.
Bir modül tamamlanmadan diğer modüle geçilmemelidir.
Hata mesajları gizlenmemeli; sorunlar giderilmelidir.
Kullanılmayan import, gereksiz paket ve kopya kod bırakılmamalıdır.
Kod içinde çalışmayan buton, boş ekran veya işlevsiz TODO bırakılmamalıdır.
Demo amaçlı olan işlevler gerçek bir servise bağlanmış gibi gösterilmemelidir.
Bir özelliğin tamamlandığı iddia edilmeden önce ilgili ekran ve testler doğrulanmalıdır.
Teknik dokümantasyon ve klasör yapısı güncel tutulmalıdır.
Önerilen geliştirme sırası
Flutter projesini ve tema sistemini oluştur.
Uygulama navigasyonunu ve alt sekmeleri kur.
Kayıt ve giriş ekranlarını tamamla.
Yerel depolama ve kullanıcı profilini oluştur.
Sanal bakiye ve tema ayarlarını tamamla.
Lig, takım ve maç veri modellerini oluştur.
Lig listesi, puan tablosu ve takım maç programını tamamla.
Maç oranları ekranını ve demo oran üretimini oluştur.
Kupon sepetini ve hesaplama sistemini tamamla.
Kupon geçmişini oluştur.
Bildirimler ekranını tamamla.
Sohbet simülasyonunu oluştur.
Bütün ekranların tasarımını iyileştir.
Testleri çalıştır ve hataları gider.
Projeyi Antigravity IDE üzerinden çalıştırıp uçtan uca doğrula.

Nihai hedef: Gerçek bir bahis veya ödeme altyapısı bulunmayan, ancak arayüzleri ve temel kullanıcı akışları eksiksiz çalışan, tutarlı veriler kullanan ve mobil cihazda gerçek bir uygulama deneyimi sunan Tutturdum prototipini geliştirmek.