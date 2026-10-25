import 'package:flutter/material.dart'; // Flutter arayüz bileşenlerini ve renk tanımlamalarını (Color sınıfı) içeri aktarır

/// Uygulama genelinde kullanılan renk paletini, ders renklerini ve tema tonlarını yöneten sabit sınıf
class AppColors {
  // --- Marka ve Vurgu Renkleri ---
  static const Color primary = Color(0xFF6366F1); // Ana tema rengi (İndigo / Morumsu mavi) - Butonlar ve öne çıkan alanlar için kullanılır
  static const Color primaryLight = Color(0xFF818CF8); // Ana rengin açık tonu - Özellikle koyu modda okunabilirliği artırmak için kullanılır
  static const Color primaryDark = Color(0xFF4338CA); // Ana rengin koyu tonu - Gölgelendirme ve derinlik hissi kazandırmak için kullanılır
  static const Color secondary = Color(0xFF06B6D4); // İkincil tema rengi (Camgöbeği / Cyan) - Yan bileşenler ve vurgular için kullanılır
  static const Color accentGold = Color(0xFFF59E0B); // Vurgu rengi (Kehribar / Altın sarısı) - Hedef tamamlama ve yıldızlar için kullanılır

  // --- KPSS Derslerine Özel Kimlik Renkleri ---
  static const Color courseTurkce = Color(0xFF2196F3); // Türkçe dersi rengi (Mavi) - Ders kartları ve grafiklerde kullanılır
  static const Color courseMatematik = Color(0xFF9C27B0); // Matematik dersi rengi (Mor) - Ders kartları ve grafiklerde kullanılır
  static const Color courseTarih = Color(0xFFFF9800); // Tarih dersi rengi (Turuncu) - Ders kartları ve grafiklerde kullanılır
  static const Color courseCografya = Color(0xFF4CAF50); // Coğrafya dersi rengi (Yeşil) - Ders kartları ve grafiklerde kullanılır
  static const Color courseVatandaslik = Color(0xFFF44336); // Vatandaşlık dersi rengi (Kırmızı) - Ders kartları ve grafiklerde kullanılır

  // --- Konu Çalışma Durumu Renkleri ---
  static const Color notStarted = Color(0xFF94A3B8); // Başlanmadı durumu rengi (Açık Gri / Slate 400) - Henüz çalışılmamış konular için
  static const Color needsReview = Color(0xFFF59E0B); // Tekrar Edilmeli durumu rengi (Turuncu / Amber 500) - Hatırlatma gerektiren konular için
  static const Color completed = Color(0xFF10B981); // Tamamlandı durumu rengi (Zümrüt Yeşili / Emerald 500) - Bitirilen konular için

  // --- Net ve Soru Durumu Renkleri ---
  static const Color correct = Color(0xFF10B981); // Doğru cevap rengi (Yeşil) - Doğru çözülen soruların gösteriminde kullanılır
  static const Color wrong = Color(0xFFEF4444); // Yanlış cevap rengi (Kırmızı) - Hatalı soruların gösteriminde kullanılır
  static const Color empty = Color(0xFF94A3B8); // Boş soru rengi (Gri) - Boş bırakılan soruların gösteriminde kullanılır

  // --- Koyu Tema (Dark Mode) Zemin ve Yüzey Renkleri ---
  static const Color darkBackground = Color(0xFF0F172A); // Koyu tema arka plan rengi (Çok koyu lacivert / Slate 900)
  static const Color darkSurface = Color(0xFF1E293B); // Koyu tema yüzey rengi (Kartlar ve alt menü arkaplanı / Slate 800)
  static const Color darkCard = Color(0xFF1E293B); // Koyu tema kart arka plan rengi
  static const Color darkSurfaceVariant = Color(0xFF334155); // Koyu tema ikincil yüzey rengi (Giriş kutuları ve ayrıcılar / Slate 700)
  static const Color darkTextPrimary = Color(0xFFF8FAFC); // Koyu tema birincil metin rengi (Beyaza yakın açık gri)
  static const Color darkTextSecondary = Color(0xFF94A3B8); // Koyu tema ikincil metin rengi (Açıklamalar ve alt başlıklar için gri)

  // --- Açık Tema (Light Mode) Zemin ve Yüzey Renkleri ---
  static const Color lightBackground = Color(0xFFF8FAFC); // Açık tema arka plan rengi (Hafif kırık beyaz / Slate 50)
  static const Color lightSurface = Colors.white; // Açık tema yüzey rengi (Saf beyaz)
  static const Color lightCard = Colors.white; // Açık tema kart arka planı
  static const Color lightSurfaceVariant = Color(0xFFF1F5F9); // Açık tema form alanı ve pasif buton rengi (Açık gri)
  static const Color lightTextPrimary = Color(0xFF0F172A); // Açık tema birincil metin rengi (Koyu lacivert / siyaha yakın)
  static const Color lightTextSecondary = Color(0xFF64748B); // Açık tema ikincil metin rengi (Orta ton gri)

  /// Ders kimliğine (courseId) göre ilgili dersin temsil rengini döndüren yardımcı fonksiyon
  static Color getCourseColor(String courseId) {
    // Gelen ders ID değerini küçük harfe çevirerek eşleştirme yapar
    switch (courseId.toLowerCase()) {
      case 'turkce': // Türkçe dersi için
        return courseTurkce; // Mavi rengi döndür
      case 'matematik': // Matematik dersi için
        return courseMatematik; // Mor rengi döndür
      case 'tarih': // Tarih dersi için
        return courseTarih; // Turuncu rengi döndür
      case 'cografya': // Coğrafya dersi için
        return courseCografya; // Yeşil rengi döndür
      case 'vatandaslik': // Vatandaşlık dersi için
        return courseVatandaslik; // Kırmızı rengi döndür
      default: // Tanımlanmamış veya bilinmeyen bir ders geldiğinde
        return primary; // Varsayılan olarak ana tema rengini döndür
    }
  }
}
