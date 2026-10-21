import 'package:flutter/material.dart';

/// [AppColors] sınıfı, AraÇek uygulamasının tasarım sisteminde kullanılan
/// tüm renk paletini merkezi bir noktada toplar.
/// Bu sayede uygulama genelinde tutarlı bir renk uyumu ve kolay tema yönetimi sağlanır.
class AppColors {
  // Sınıfın dışarıdan örneklenmesini (instance oluşturulmasını) engellemek için özel kurucu metod
  const AppColors._();

  // ==========================================
  // ANA MARKA VE VURGU RENKLERİ (BRAND COLORS)
  // ==========================================

  /// Birincil Marka Rengi (Canlı Elektrik Mavisi/Neon Cyan):
  /// AraÇek logosunun modern ve teknolojik kimliğini yansıtan ana renk.
  static const Color primary = Color(0xFF00D2FF);

  /// Koyu Birincil Renk (Daha derin ton, açık temada buton kontrastı için kullanılır):
  static const Color primaryDark = Color(0xFF0077B6);

  /// İkincil Renk / Aksan Rengi (Neon Yarış Turuncusu):
  /// Hızlı aksiyon butonları, uyarılar ve araç detaylarındaki dinamik vurgular için kullanılır.
  static const Color accent = Color(0xFFFF6B00);

  /// İkincil Vurgu Rengi (Elektrik Kehribarı):
  static const Color accentLight = Color(0xFFFFAA00);

  // ==========================================
  // KOYU TEMA (DARK THEME) PALETİ
  // ==========================================

  /// Koyu tema ana arka plan rengi (Derin Gece / Obsidyen Mavisi)
  static const Color darkBackground = Color(0xFF0B0F19);

  /// Koyu tema kart ve yüzey rengi (Yumuşak kart ayrımı sağlar)
  static const Color darkSurface = Color(0xFF141A29);

  /// Koyu tema yüzey vurgusu (Seçili öğeler, input alanları ve diyaloglar için)
  static const Color darkSurfaceElevated = Color(0xFF1C2438);

  /// Koyu tema kenarlık/çerçeve rengi (Kartların sınırlarını zarifçe belirler)
  static const Color darkBorder = Color(0xFF26334D);

  /// Koyu tema birincil metin rengi (Yüksek okunabilirlik sağlayan kırık beyaz)
  static const Color darkTextPrimary = Color(0xFFF1F5F9);

  /// Koyu tema ikincil metin rengi (Alt başlıklar ve açıklamalar için gri ton)
  static const Color darkTextSecondary = Color(0xFF94A3B8);

  // ==========================================
  // AYDINLIK TEMA (LIGHT THEME) PALETİ
  // ==========================================

  /// Aydınlık tema ana arka plan rengi (Göz yormayan açık gri/mavi zemin)
  static const Color lightBackground = Color(0xFFF4F7FC);

  /// Aydınlık tema kart ve yüzey rengi (Saf beyaz yüzey)
  static const Color lightSurface = Color(0xFFFFFFFF);

  /// Aydınlık tema yüzey vurgusu (Açık modda buton arkaları ve input alanları)
  static const Color lightSurfaceElevated = Color(0xFFEBF1FA);

  /// Aydınlık tema kenarlık/çerçeve rengi (Açık gri çizgi)
  static const Color lightBorder = Color(0xFFDCE3F1);

  /// Aydınlık tema birincil metin rengi (Koyu grafit grisi/siyah)
  static const Color lightTextPrimary = Color(0xFF0F172A);

  /// Aydınlık tema ikincil metin rengi (Açık modda destekleyici metin rengi)
  static const Color lightTextSecondary = Color(0xFF64748B);

  // ==========================================
  // DURUM BİLDİRİM RENKLERİ (STATUS COLORS)
  // ==========================================

  /// Başarı Rengi (Zümrüt Yeşili - Başarılı kiralama, onay ve aktif durumlar):
  static const Color success = Color(0xFF10B981);

  /// Hata / İptal Rengi (Modern Kırmızı - Geçersiz formlar, hasar bildirimleri):
  static const Color error = Color(0xFFEF4444);

  /// Uyarı Rengi (Canlı Sarı/Turuncu - Dikkat çeken hasar noktaları ve uyarılar):
  static const Color warning = Color(0xFFF59E0B);

  /// Bilgi Rengi (Buzul Mavisi - İpuçları ve genel bilgilendirmeler):
  static const Color info = Color(0xFF3B82F6);
}
