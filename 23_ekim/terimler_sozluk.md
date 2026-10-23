## SÖZLEŞMELER, SOLID PRENSİPLERİ & OOP MİMARİSİ 

## 1 - INTERFACE (ARAYÜZ/SÖZLEŞME)

İki bağımsız sistemin veya sınıfın birbiriyle nasıl konuşacağını belirleyen içi boş metot imzalardan oluşan kurallar bütünü.

- Neden Kullanılır?
Bir sınıfa göbekten bağımlı kalmamak (örneğin gerçek şarj istasyonu ciha olamdan sahte/mock servisiyle testi çalıştırabilmek) için.

```dart

abstract interface class StationContreact{
    Future<void> starCharging(String socketId);
    Stream<double> watchLivePower();

}
````

## 1.2. `implements` vs `extends` vs `with`

## 1.2.1 `implements` (Arayüz Sözleşmesi)
bir sınıfın, bir şablonun belirlediği kuralları kabul edip (içini sıfırdan kendisinin doldurması) zorunluluğudur.

- Neden Kullanılır?
farklı sınıflara ortak bir standart/sözleşme dayatmak, çoklu arayüz desteği sağlamak ve kodda bağımlılıkları azaltmak için.


## 1.2.2 `extends` (Kalıtım / Miras)
Bir sınıfın başka bir sınıfın özelliklerini ve metotlarını doğrudan devir alması.

- Neden Kullanılır?
kod tekrarını önlemek (DRY - Don t Repeat Yourself) mantıksal bir sınıf hiyeraşisini oluşturmak için.


### 1.2.3 with (Mixin/Yetenek Aşılama)
**Sözlük Anlamı:** Sınıf hiyerarşisni bozmadan, bağımsız bir sınıfa hazır kod blokları (metotlar ve değişkenler) enjekte etme mekanizmasıdır.

**Neden Kullanılır:** Akraba olmayan sınıflara ortak yetenekler kazandırmak, çoklu kalıtım kimliğini önlemek ve modülerliği artırmak için.





## 1.3 SOLID PRENSİPLERİ (mobil ve dart odaklı)
## 1. S - Single Responsiblity Principle(Tek Sorumluluk Prensibi)
Bir sınıfın veya dosyanın değişmesi için yalnızca 1 sebebi olmalıdır

## 2. O - Open/Closed Principle(Açık/Kapalı Prensibi)
yazılım varlıkları (sınıflar,modüller) genişletmeye açık ancak değiştirilmeye kapalı olmalıdır.

## 3. L - Liskov Substitution Principle(Liskov Yerine Koyma Prensibi)
Bir sınıfın yerine onun alt sınıflarından herhangi biri geçirildiğinden sistemin davranışı bozulmamamlı ve hasar bırakmamalıdır.

## 4. I - Interface Sepregation Principle (Arayüz Ayrıştırma Prensibi)
İstemciler (sınıflar) kullanmadıkları metotları içermeye zorlanmamalıdır. şişman(fat) interfaceler yerine küçük amaca yönelik arayüzler kurulmalıdır.

## 5. D - Dependency Inversion Principle (Bağımlılıkların Tersine Çevrilmesi)
yüksek seviyeli modüller (UI,ii mantığı) düşük seviyeli modüllere (veritabanı, HTTP istemcisi) doğrudan bağlı olmamalıdır. Her ikiside soyutmalara (interfac) bağlı olmalıdır






## 1.4  `Coupling` (Bağlaşıklık) & `Cohesion` (Uyum)

1 - Tightly Coupled (Sıkı Bağımlı) : Sınıfların birbirinin her datayını bilmesi. birinden yapılan bir harflik edeğişiklik diğer 5 dosyayı bozuyor ise sistem sıkı bağımlıdır.


2 - Loosly Coupled (Gevşek Bağımlı) : Sınıfların sadece interface üzerinden konuşması. biri değiştiğinde diğeri etkilenmez.

3 - High Cohesion (Yüksek Uyum) : Bir sınıfın sadece ama sadece kendi uzmanlık alanı yapması.





 ## STREAM TEMELLERİ, CUBİT & ENTERPRİSE BLOCK

 ## 2.1. STREAM NEDİR? (BloC ` un kalbindeki motor)
Zaman içinde parça parça gelen akıp giden asenkron veri dizisi. BloC sırrı BloC kütüphanesi sihirli bir şey yapmaz! BloC un içinde gizli bir `StreamController` vardır. Eventler borunun bşr ucundan girer(`sink.add`), BloC onları işler ve diğer ucundan ekrana state akıtır (`stream.listen`).

## 2.2 Tablo


## 2.3 BloC un 3 Temel Elemenı : Event, State, Emitter

1 - Event (olay): Kullanıcının veya sistemin BloC`a attığı emir fişi.
Mini Sözdizimi : class StartChargingRequested extends ChargingEvent {final String socketId;}

2 - State(Durum) : ekrnaın o milisaniyedeki dondurulmuş fotoğrafı(snapshot).
class ChargingActiveState extends ChargingState {final double kwh;}

3 - Emitter : BloC un ürettiği yeni stateti ekrana fırlattğı megafon borusu. kural; senkron çalışır -> emit(NewState()) dendiği anda UI`daki builderlar tetiklenir.

--- Tablo gelecek



## 3.1 Side Effect (Yan Etki) Neden BlocBuilder İçine Yazılmaz?

Blockbuilder tek görevi widget döndürmektir. 

Flutter motoru ekranı saniyede 60 kez çizebilir (rebuild). eğer siz BlockBuilder içine ScaffoldMessenger.showSnackBar veya Navigator.push yazarsanız kullanıcı cihazı yan çevirdiğinde veya klavye açıldığında kullanıcıya üst üste 10 defa SnackBar patlar veya 10 kez yeni sayfa açılır.
Kural : Yan etkiler sadece BlockListener içine yazılır. Çünkü Listener sayfa rebuild olduğunda değil, yalnızca state değiştiğinde 1 kez tetiklenir! 


## 3.2. BlockSelecter (Mikro Performans & Pil Tasarrufu)
Statetin içindeki onlarca alandan sadece 1 tanesini süzüp izlemek.







## 4. EŞİTLİK, DEĞİŞMEZLİK & BLOCOBSERVER

## 4.1 Referential Equality vs Value Equality
Dart Varsıyılanı (Referans Eşitliği): İki nesnenin bellekteki (RAM) adresi aynı mı?
    Soket('A') == Soket('A')  -> false çıkar içerideki aynı olsa bile ramdeki evler farklıdır.

Değer Eşitliği (Value Equality): Nesnelerin içindeki veriler aynı mı?   
    `Euatable` paketi tam oalrak bunu çözer: nesneleri RAM adresine göre değil props listesindeki alanlarn değerine göre karşılaştırır.



## 4.2 props Listesi Yazılmas ise Ne Olur?
BloC ekran kartını yormamak için şu denetimi yapar: if (yeniState== eskiState) ekraniCizme();

eğer siz StationLoaded stateine yeni bir filterType alanı eklersiniz ama props içine yazmayı unutursanız BloC iki statei eşit zanneder ve ekranı güncellemez arayüz donuk kalır.


## 4.3 Immutability (Değişmezlik) & `CopyWith`

State sınıflarının tüm alanları final olmalıdır.
copyWith Mantığı: eski nesnenin 5 alanını koruyup sadece değişen 1 alanını güncelleyerek taze bir nesne üretme yöntemidir.

final guncel = state.copyWith(isCharging: true); // diğer alanlar bozulmadan kopyalanır


## 4.4. BlocObserver (Tüm uygulamayı röntgenleme)
uygulamadaki tüm BloC ve Cubitlerin arkasında çalışan merkezi bir kara / telemetri kaydedici
Ne işe Yarar : hangi ekranda hangi event fırlatıldı State nereden nereye geçti ve nerede hata fırlatıldı tek merkezden konsola loglanır. kurumsal projelerde analitik ve çökme ekibi için zorunludur.

--- tablo (presentation domain data)





## 5. CLEAN ARCHITECTURE KATMANLARI & SORUMLULUK DUVARLARI

## 5.1. Entity vs Model / DTO
Entity (Varlık): Saf iş nesnesidir. Bir şarj soketinin gerçek hayattaki özelliklerini (id, kw, durum) tutar. fromJson veya toJson içermez.

Model / DTO (Data Transfer Object) : API den gelen ham JSON verisini karşılayan taşıyıcıdır. Entity den türer. fromJson ve toJson metotları barındırır.


## 5.5. UseCase (Kullanım Seneryosu) 
Kullanıcının veya sistemin gerçekleştirebileceği tek ve atomik bir iş kuralı
Örnekler: StarChargingSessionUseCase , GetStationSocketUseCase, RefaundWalletBalanceUseCase
Kural: Her UseCase sınıfının içinde sadece tek bir call() veya execute() fonksiyonu bulunur.






## 6. BAĞIMLILIK YÖNTEMİ: DEPENDENCY INJECTİON & get_it

## 6.1. Neden new Dio() Yazmak Yasaktır?
Eğer 5 ayrı sayfada final dio = Dio(); derseniz:

Bellekte 5 ayrı bağlantı havuzu açılır, telefonun soket sınırını zorlar.
Base URL veya Timeout değiştiğinde 5 ayrı dosyayı elle değiştirmek zorunda kalırsınız.
Test yazarken sahte (mock) veri enjekte edemezsiniz.



## 6.2. GetIt Kayıt Tipleri: Singleton vs Lazy Singleton vs Factory

Singleton: Uygulama açıldığı milisaniyede nesneyi üretir ve belleğe çiviler.
LazySingleton: Uygulama açıldığında üretmez! Ne zaman ilk kez birisi sl<Dio>() derse o an üretir ve sonrasında hep aynı nesneyi verir. (Bellek ve açılış hızı dostudur).
Factory: Her çağrıldığında yepyeni, sıfır bir kopya üretir.



## 7. KURUMSAL AĞ MİMARİSİ: DIO, INTERCEPTOR & HTTP STATUS KODLARI

## 7.1. Interceptor
Sözlük Anlamı: Ağ isteği telefondan çıkıp internete gitmeden önce veya sunucudan cevap gelip koda düşmeden önce araya girip paketi inceleyen/değiştiren güvenlik noktası.

## 7.2. Bearer Token & Payload
Bearer Token: "Bu anahtarı taşıyan kişi giriş yapmaya yetkilidir" anlamına gelen şifrelenmiş kimlik kartı metni (Authorization: Bearer eyJhbGci...).
Payload: Bir API isteğiyle sunucuya gönderilen veya sunucudan bize dönen asıl veri gövdesi (Body).

## 7.3. HTTP Durum Kodları Sözlüğü 

200 OK: İstek başarılı, veri gövdede.
201 Created: Yeni kayıt (örneğin yeni şarj oturumu) başarıyla oluşturuldu.
400 Bad Request: İstemci hatası; eksik veya hatalı parametre gönderdin.
401 Unauthorized: Token yok veya süresi dolmuş; hemen Logine yönlendir!
403 Forbidden: Giriş yaptın ama bu veriyi görmeye yetkin yok (Admin değilsin).
404 Not Found: Aradığın soket veya istasyon sunucuda bulunamadı.
500 Internal Server Error: Backend sunucusu patladı; istemcilik bir hata yok.





## 8. VERİ DAYANIKLILIĞI : CACHE-FIRS & SAVUNMACI KODLAMA

## 8.1. Cache-First (Önce Önbellek) Stratejisi
Mantık: Kullanıcı şarj istasyonu listesini açtığında 1 saniye bile beyaz ekranda spinner bekletme! Diskteki dünkü veriyi 0.01 milisaniyede ekrana bas. Arka planda sunucudan taze veriyi çek; gelince ekranı ve diski sessizce güncelle.


## 8.2. Defensive Programing (Savunmacı Programlama)


Mantık: Sunucudan gelen veriye asla %100 güvenmeme prensibi.









