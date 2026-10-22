# Alışkanlık Takibi Uygulaması - Proje Kılavuzu

## 1. Proje Özeti
- **Uygulama Adı:** Alışkanlık Takibi
- **Teknoloji:** Flutter & Dart
- **IDE:** Antigravity IDE ve VS Code
- **Platform:** Android Emulator / iOS / macOS / Chrome
- **Tasarım:** Material 3, modern, estetik ve kullanıcı dostu arayüz
- **Veri Yönetimi:** Bellek içi (in-memory) reaktif veri yönetimi (ValueNotifier / ChangeNotifier); harici API veya karmaşık veritabanı bağımlılığı olmadan stabil prototip
- **Amaç:** Günlük hedeflerin (kalori, su, adım, uyku vb.) takip edildiği, ilerlemenin görüntülendiği, rozetlerin kazanıldığı, modern açık/koyu tema ve bildirimler içeren eksiksiz ve çalışan bir alışkanlık takip uygulaması.

---

## 2. Temel Özellikler
1. **Giriş ve Kayıt Ekranları:**
   - E-posta veya telefon numarası, şifre girişi, form doğrulaması.
   - Kayıt ekranında Ad Soyad, E-posta / Telefon, Şifre, Kullanıcı Sözleşmesi ve KVKK onayları.
   - Başarılı giriş ile doğrudan ana akışa (Hedeflerim ekranına) yönlendirme.
2. **Hedeflerim (Ana Ekran):**
   - Kalori, Su, Adım ve Uyku hedeflerinin kartlar halinde gösterimi.
   - Günlük özet ilerleme halkası, motive edici sözler ve filtreler.
3. **Alışkanlık Ekle / Güncelle:**
   - Kullanıcının kalori, su, adım ve uyku için hedef değer ve gerçekleşen değer girmesi/güncellemesi.
   - Değer artırma/azaltma ve hızlı tamamlama butonları.
4. **Hedef Takibi & Rozet Sistemi:**
   - Hedeflenen ve gerçekleşen değerlerin anlık karşılaştırılması (% tamamlanma).
   - %100'e ulaşıldığında otomatik başarı rozeti kazanımı ve tebrik bildirimi.
   - Kazanılan rozetlerin ve kilitli rozetlerin takibi.
5. **Takvim Ekranı:**
   - Günlük hedeflerin ve haftalık/aylık ilerlemenin interaktif takvim görünümü.
   - Seçilen günün alışkanlık durumlarının incelenmesi.
6. **Analiz Ekranı:**
   - Kazanılan başarı rozetleri vitrini.
   - Haftalık tamamlama istatistikleri ve grafiksel çubuklar/dağılım.
7. **Profil ve Ayarlar:**
   - Kullanıcı profil bilgileri (isim, e-posta, hedef seviyesi).
   - Açık / Koyu tema modu seçimi (sistem / açık / koyu).
   - Sıkça Sorulan Sorular (S.S.S.) ve Hakkında bölümü.
8. **Bildirimler:**
   - Yapay zekâ asistanı tarzında akıllı öneri ve hatırlatıcı bildirimler listesi (su içme vakti, adım hedefi tebriği vb.).
   - Bildirim okundu / temizleme aksiyonları.

---

## 3. Tasarım ve Navigasyon
- Material 3 tasarım sistemi, özel renk paleti (canlı zümrüt yeşili, derin okyanus mavisi, şık koyu mod ve cam efektleri).
- Üst bar: Sol tarafta Profil simgesi, sağ tarafta Bildirimler ikonu (okunmamış rozetiyle).
- Alt navigasyon barı (NavigationBar):
  1. Hedeflerim (Ana Sayfa)
  2. Alışkanlık Ekle / Güncelle
  3. Takvim
  4. Analiz & Rozetler
- Uygulama genelinde akıcı sayfa geçişleri ve mikromimikler.
- Özel uygulama logosu ve uygulama ikonu.

---

## 4. Kalite ve Doğrulama
- `flutter analyze` ile sıfır hata / sıfır uyarı.
- `flutter test` ile kapsamlı birim ve widget testleri.
- Tüm butonlar ve etkileşimler eksiksiz çalışır durumda olmalıdır.
