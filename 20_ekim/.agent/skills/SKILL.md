---
name: flutter-entrepreneurship-scaffold
description: Girişelim Flutter uygulamasında yeni ekranlar ve işlevler oluşturmak için basit klasör yapısını, ValueNotifier state yönetimini, UI ayrımını ve temel test kurallarını uygular.
---

# Flutter Girişimcilik Scaffold (Girişelim)

Bu yetenek, **Girişelim** uygulamasında yeni ekranlar ve işlevler geliştirmek için kullanılır. Amaç, sade, modern ve düzenli kod yazarak çalışan bir girişimcilik ve tohum yatırım demo uygulaması oluşturmaktır.

Uygulama gerçek üyelik, veritabanı, backend veya finansal işlem altyapısı içermez. Bütün işlemler örnek veriler ve sanal bakiye üzerinden gerçekleştirilir.

---

## Temel Kurallar
1. **Dosyaları ayır:** Ekranlar `screens/`, tekrar kullanılabilir bileşenler `widgets/`, veri modelleri `models/` ve iş mantığı `controllers/` altında tutulmalıdır.
2. **State yönetimi:** Basit ve reaktif durumlar için `ValueNotifier` ve `ValueListenableBuilder` kullanılmalıdır. Ağır harici state paketleri (Bloc, Riverpod vb.) kullanılmamalıdır.
3. **Merkezi bakiye:** Sanal bakiye, yatırımlar ve işlem geçmişi merkezi `AppController` üzerinden yönetilmelidir.
4. **Const kullanımı:** Mümkün olan tüm statik widget'larda `const` kullanılmalıdır.
5. **Basit mimari:** Gereksiz dosyalar, harici paketler ve karmaşık mimari katmanları oluşturulmamalıdır.
6. **Tema:** Koyu (`#0B1020`, `#141C2F`, `#36D399`) ve açık (`#F5F7FB`, `#FFFFFF`, `#059669`) tema uygulamanın bütün ekranlarında desteklenmelidir.
7. **Çalışan arayüz:** Her buton tanımlanan işlevi yerine getirmelidir; boş buton veya TODO bırakılmamalıdır.
8. **Veri tutarlılığı:** Yatırım yapıldığında bakiye düşmeli ve yatırım kaydı oluşturulmalıdır.
9. **Demo sınırı:** Gerçek para transferi, ödeme veya veritabanı işlemi yapılmamalıdır.

---

## Adım Adım Modül Oluşturma

### 1. Klasör Yapısı
```text
lib/
  models/
  controllers/
  screens/
  widgets/
  data/
  core/
```

### 2. Controller Mantığı
Tüm iş mantığı `controllers/app_controller.dart` içerisindeki `ValueNotifier` yapılarına bağlanır. Tutar hesaplamaları kuruş cinsinden yapılır ve ekrana TL olarak yansıtılır.

### 3. Ekran Geliştirme
Ekranlar `StatelessWidget` ve `ValueListenableBuilder` kullanılarak oluşturulur.
