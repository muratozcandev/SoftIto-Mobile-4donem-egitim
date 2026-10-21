# AraÇek State Flow Referansı

Bu doküman, AraÇek uygulamasında ekranlar ve modüller arasındaki veri ve durum akışını açıklar.

## 1. Tema Durumu (ThemeController)
- `themeModeNotifier`: Açık/Koyu tema durumunu tutar.
- Arayüzde `ValueListenableBuilder` ile dinlenir ve anında güncellenir.

## 2. Dil Durumu (LocaleController)
- `currentLocaleNotifier`: Türkçe (`tr`) ve İngilizce (`en`) dillerini yönetir.

## 3. Araç ve Filtreleme Durumu (VehicleController)
- Araç listesi, seçili kategori, vites filtresi ve sıralama ölçütü bu controller üzerinde reaktif olarak filtrelenir.

## 4. Kiralama Durumu (RentalController)
- Seçilen araç, kiralama gün sayısı, günlük/toplam bedel hesaplaması ve aktif kiralama listesi.

## 5. Hasar ve Fotoğraf Çekme Durumu (DamageReportController)
- Teslim alma ve teslim etme anında aracın fotoğraflarını çekme, hasar noktalarını işaretleme ve rapor oluşturma.
