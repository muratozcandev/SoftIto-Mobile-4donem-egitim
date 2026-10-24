<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: app_colors.dart
// Görev: AraÇek uygulamasının açık ve koyu tema için merkezi renk paleti tanımları.
// Açıklama: Tüm ekranlarda tutarlı renk uyumu, neon vurgular ve modern Material 3
// görünümü sağlamak amacıyla statik sabitler barındırır.
// ==============================================================================

import 'package:flutter/material.dart';

/// [AppColors] sınıfı, uygulama genelinde kullanılan tüm renk kodlarını tek bir
/// noktada toplayarak kod tekrarını önler ve tema yönetimini kolaylaştırır.
abstract class AppColors {
  // ---------------------------------------------------------------------------
  // Marka & Vurgu (Accent / Primary) Renkleri
  // ---------------------------------------------------------------------------
  /// Birincil marka rengi: Canlı elektrik neon camgöbeği (Cyan).
  /// Butonlar, aktif sekmeler ve dikkat çeken vurgularda kullanılır.
  static const Color primary = Color(0xFF00D2FF);

  /// Birincil rengin koyu tonu; degrade ve gölgelendirmelerde derinlik katar.
  static const Color primaryDark = Color(0xFF0077B6);

  /// İkincil renk: Modern mor/indigo tonu; kart kenarlıkları ve rozetlerde kullanılır.
  static const Color secondary = Color(0xFF6C5CE7);

  /// Başarı rengi: Neon yeşil; onay simgeleri ve teslimat başarı durumlarında kullanılır.
  static const Color success = Color(0xFF00E676);

  /// Uyarı rengi: Canlı kehribar; hasar tespit uyarılarında ve gecikme bildirimlerinde kullanılır.
  static const Color warning = Color(0xFFFFB703);

  /// Hata rengi: Mercan kırmızısı; form validasyon hatalarında ve iptal durumlarında kullanılır.
  static const Color error = Color(0xFFFF3366);

  // ---------------------------------------------------------------------------
  // Koyu Tema (Dark Mode / Obsidian) Renkleri
  // ---------------------------------------------------------------------------
  /// Koyu temada ana ekran arka planı (Derin Obsidyen Siyahı).
  static const Color darkBackground = Color(0xFF0B0F19);

  /// Koyu temada kartların ve panellerin zemin rengi.
  static const Color darkSurface = Color(0xFF161C2E);

  /// Koyu temada açılır pencereler, modal sayfalar ve yükseltilmiş kart rengi.
  static const Color darkElevated = Color(0xFF1E263D);

  /// Koyu tema ana metin rengi (Saf beyaza yakın net okunabilirlik).
  static const Color darkTextPrimary = Color(0xFFF0F4FC);

  /// Koyu tema ikincil/açıklama metin rengi (Mavimsi gri ton).
  static const Color darkTextSecondary = Color(0xFF94A3B8);

  /// Koyu tema kenarlık (border) ve ayırıcı (divider) çizgileri için renk.
  static const Color darkBorder = Color(0xFF232D48);

  // ---------------------------------------------------------------------------
  // Açık Tema (Light Mode / Crisp Clean) Renkleri
  // ---------------------------------------------------------------------------
  /// Açık temada ana ekran arka planı (Hafif soğuk beyaz/gri ton).
  static const Color lightBackground = Color(0xFFF4F7FC);

  /// Açık temada kartların, app bar'ın ve form alanlarının zemin rengi (Saf beyaz).
  static const Color lightSurface = Color(0xFFFFFFFF);

  /// Açık temada yükseltilmiş öğelerin zemin rengi.
  static const Color lightElevated = Color(0xFFEDF2F7);

  /// Açık tema ana başlık ve gövde metin rengi (Derin lacivert-siyah).
  static const Color lightTextPrimary = Color(0xFF0F172A);

  /// Açık tema ikincil açıklama metin rengi (Orta koyulukta gri).
  static const Color lightTextSecondary = Color(0xFF64748B);

  /// Açık tema kenarlık ve ayırıcı çizgi rengi.
  static const Color lightBorder = Color(0xFFE2E8F0);

  // ---------------------------------------------------------------------------
  // Özel Gradyanlar (Görsel Zenginlik İçin)
  // ---------------------------------------------------------------------------
  /// AraÇek ana marka buton ve kartları için neon elektrik degrade geçişi.
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00D2FF), Color(0xFF0066FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Premium kartlar ve hasar teslimat panelleri için koyu degrade geçişi.
  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF1A2238), Color(0xFF111726)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
}
