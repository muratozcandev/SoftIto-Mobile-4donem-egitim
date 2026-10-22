name: akilli-aliskanlik-flutter description: Flutter ile veritabanı ve API kullanmadan çalışan, hedef takibi, alışkanlık yönetimi, takvim, analiz, tema ve başarı rozetleri içeren Akıllı Alışkanlık uygulaması prototipi geliştirir.
Akıllı Alışkanlık - Geliştirme Kuralları
1. Genel Kurallar
Prototip Odaklı Geliştirme: Veritabanı, API, sunucu ve gerçek kimlik doğrulama kullanılmayacaktır. Tüm işlemler yerel ve örnek verilerle çalışmalıdır.
Modüler Kod: Giriş, kayıt, hedefler, alışkanlık ekleme, takvim, analiz, profil ve bildirim ekranları ayrı dosyalarda tutulmalıdır.
Çalışan Etkileşimler: Hiçbir buton işlevsiz bırakılmamalıdır. Formlar doğrulanmalı, navigasyon çalışmalı ve işlemler arayüze yansımalıdır.
Durum Yönetimi: Basit durum yönetimi için Flutter'ın ValueNotifier ve ValueListenableBuilder özellikleri tercih edilmelidir. Gereksiz harici state yönetimi paketleri eklenmemelidir.
Tema: Açık ve koyu tema merkezi olarak yönetilmeli ve tüm ekranlarda uygulanmalıdır.
Kod Kalitesi: Uygun yerlerde const kullanılmalı, tekrarlanan bileşenler ortak widget'lara ayrılmalı ve kaynaklar gerektiğinde temizlenmelidir.
2. Hedef ve Rozet Kuralları
Kalori, su, adım ve uyku hedefleri kullanıcı tarafından girilebilmelidir.
Her hedef için hedeflenen değer, gerçekleşen değer ve tamamlanma yüzdesi gösterilmelidir.
İlerleme yüzdesi otomatik hesaplanmalı ve hedef tamamlandığında %100 ile sınırlandırılmalıdır.
Hedef tamamlandığında ilgili başarı rozeti kazanılmalıdır.
Aynı hedef için aynı rozet tekrar tekrar verilmemelidir.
Kazanılan rozetler Analiz ekranında görüntülenmelidir.
Hatalı veya negatif değerlerin girilmesi engellenmelidir.
3. Arayüz Kuralları
Arayüz dili Türkçe olmalıdır.
Material 3 tasarım sistemi kullanılmalıdır.
Alt navigasyonda Hedeflerim, Ekle, Takvim ve Analiz sekmeleri bulunmalıdır.
Profil ve bildirim simgeleri üst çubukta yer almalıdır.
Giriş ve kayıt ekranları doğrulama içermeli; başarılı prototip girişinde Hedeflerim ekranı açılmalıdır.
Takvim, analiz ve bildirimler gerçek servis olmadan örnek verilerle çalışmalıdır.
Ekranlar farklı emülatör boyutlarında taşma oluşturmamalıdır.
4. Tamamlama Kontrolü

Her geliştirme adımında:

flutter analyze çalıştır ve hataları düzelt.
flutter test çalıştır ve testlerin başarılı olmasını sağla.
flutter run ile uygulamanın açıldığını doğrula.
Eksik buton, bozuk navigasyon, çalışmayan tema ve güncellenmeyen hedef bırakma.

Öncelik: Gerçek bir backend kurmak değil, emülatörde tasarımı düzgün görünen ve temel kullanıcı akışları baştan sona çalışan bir prototip oluşturmaktır.