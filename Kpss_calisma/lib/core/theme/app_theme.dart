import 'package:flutter/material.dart'; // Flutter Material Design kütüphanesini içeri aktarır
import 'package:google_fonts/google_fonts.dart'; // Modern Google Fonts (Plus Jakarta Sans) tipografisi için kütüphaneyi içeri aktarır
import '../constants/app_colors.dart'; // Temada kullanılacak sabit renkleri içeri aktarır

/// Uygulamanın Açık (Light) ve Koyu (Dark) mod görsel temalarını yapılandıran sınıf
class AppTheme {
  /// Uygulamanın Açık Tema (Light Mode) ayarlarını yapılandırıp döndüren getter metodu
  static ThemeData get lightTheme {
    // Uygulama genelinde kullanılacak olan Plus Jakarta Sans yazı tipinin ailesini alır
    final fontFamily = GoogleFonts.plusJakartaSans().fontFamily;

    return ThemeData(
      useMaterial3: true, // Google'ın modern Material Design 3 tasarım sistemini aktif eder
      brightness: Brightness.light, // Temanın açık renk modunda olduğunu belirtir
      fontFamily: fontFamily, // Genel yazı tipini ayarlar
      
      // Renk şeması (Color Scheme) yapılandırması
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary, // Ana tema rengi (İndigo)
        secondary: AppColors.secondary, // İkincil tema rengi (Camgöbeği)
        surface: AppColors.lightSurface, // Yüzey bileşenlerinin arka planı (Beyaz)
        surfaceContainerHighest: AppColors.lightSurfaceVariant, // Yüzey varyantı (Hafif gri ton)
        onSurface: AppColors.lightTextPrimary, // Yüzey üzeri metin rengi (Koyu renk)
        error: AppColors.wrong, // Hata durumları rengi (Kırmızı)
      ),
      
      scaffoldBackgroundColor: AppColors.lightBackground, // Sayfaların genel arka plan rengi (Kırık beyaz)
      
      // Üst Başlık Çubuğu (AppBar) Teması
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, // AppBar arka planını şeffaf yapar
        elevation: 0, // Altındaki gölgeyi sıfırlar (Düz modern görünüm)
        scrolledUnderElevation: 0, // Sayfa kaydırıldığında oluşan gölgelenmeyi de kapatır
        centerTitle: false, // Başlığın sola yaslı olmasını sağlar
        titleTextStyle: TextStyle(
          fontSize: 20, // Başlık yazı boyutu
          fontWeight: FontWeight.w700, // Kalın yazı tipi (Bold)
          color: AppColors.lightTextPrimary, // Başlık metin rengi
        ),
        iconTheme: IconThemeData(color: AppColors.lightTextPrimary), // AppBar üzerindeki simgelerin rengi
      ),
      
      // Kart Bileşeni (Card) Teması
      cardTheme: CardThemeData(
        color: AppColors.lightCard, // Kartların arka plan rengi (Beyaz)
        elevation: 0, // Kart gölgesini sıfırlar
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Kart köşelerine 16 piksel yuvarlaklık verir
          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1), // Kart etrafına ince açık gri çerçeve çizer
        ),
        margin: EdgeInsets.zero, // Kartın dış kenar boşluğunu sıfırlar
      ),
      
      // Alt Gezinme Çubuğu (Bottom Navigation Bar) Teması
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white, // Alt gezinme çubuğu arka plan rengi
        indicatorColor: AppColors.primary.withValues(alpha: 0.15), // Seçili sekmenin etrafındaki hafif renkli kapsül gösterge
        
        // Menü sekme metinlerinin durumuna göre renk değişimi
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            // Eğer sekme seçili ise
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.primary, // Seçili iken ana tema renginde kalın metin
            );
          }
          // Seçili olmayan sekmeler için
          return const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B), // Pasif iken gri orta kalınlıkta metin
          );
        }),
        
        // Menü simgelerinin durumuna göre renk değişimi
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primary); // Seçili sekme simge rengi
          }
          return const IconThemeData(color: Color(0xFF64748B)); // Pasif sekme simge rengi
        }),
      ),
      
      // Vurgulu Buton (ElevatedButton) Teması
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, // Buton arka plan rengi
          foregroundColor: Colors.white, // Buton üzerindeki yazı ve ikon rengi
          elevation: 0, // Buton alt gölgesini kaldırır
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Buton köşelerine 12 piksel ovallik verir
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), // Buton iç boşluğu
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600, // Yarı kalın buton yazısı
            fontSize: 15, // Buton yazı boyutu
          ),
        ),
      ),
      
      // Metin Giriş Kutusu (TextField / InputDecoration) Teması
      inputDecorationTheme: InputDecorationTheme(
        filled: true, // Giriş kutusunun içinin renkli olmasını sağlar
        fillColor: AppColors.lightSurfaceVariant, // Giriş kutusunun iç dolgu rengi
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), // Giriş kutusu iç dolgusu
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Çerçeve kenar ovalliği
          borderSide: BorderSide.none, // Varsayılan kenarlığı kaldırır
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)), // Pasif kenarlık rengi
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2), // Odaklanıldığında (Focus) 2px ana renk kenarlık
        ),
      ),
    );
  }

  /// Uygulamanın Koyu Tema (Dark Mode) ayarlarını yapılandırıp döndüren getter metodu
  static ThemeData get darkTheme {
    // Koyu mod için de aynı yazı tipini kullanır
    final fontFamily = GoogleFonts.plusJakartaSans().fontFamily;

    return ThemeData(
      useMaterial3: true, // Material Design 3 aktif
      brightness: Brightness.dark, // Temanın koyu modda olduğunu belirtir
      fontFamily: fontFamily, // Yazı tipi ailesi
      
      // Koyu Mod Renk Şeması
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight, // Koyu modda daha iyi parlayan açık çivit rengi
        secondary: AppColors.secondary, // İkincil renk
        surface: AppColors.darkSurface, // Koyu yüzey rengi (Slate 800)
        surfaceContainerHighest: AppColors.darkSurfaceVariant, // Koyu ikincil yüzey
        onSurface: AppColors.darkTextPrimary, // Koyu yüzey üzeri açık metin rengi
        error: AppColors.wrong, // Hata rengi
      ),
      
      scaffoldBackgroundColor: AppColors.darkBackground, // Koyu tema genel sayfa arka plan rengi (Slate 900)
      
      // Koyu Mod Başlık Çubuğu (AppBar) Teması
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, // Şeffaf arka plan
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.darkTextPrimary, // Açık renk başlık yazısı
        ),
        iconTheme: IconThemeData(color: AppColors.darkTextPrimary), // Açık renk ikonlar
      ),
      
      // Koyu Mod Kart Teması
      cardTheme: CardThemeData(
        color: AppColors.darkCard, // Koyu kart yüzeyi
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF334155), width: 1), // Koyu tonda ince çerçeve çizgisi
        ),
        margin: EdgeInsets.zero,
      ),
      
      // Koyu Mod Alt Gezinme Çubuğu Teması
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.darkSurface, // Koyu gezinme çubuğu rengi
        indicatorColor: AppColors.primary.withValues(alpha: 0.3), // Koyu moddaki seçili sekme kapsül rengi
        
        // Koyu mod sekme metin renkleri
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryLight, // Seçili sekmede açık mor/indigo
            );
          }
          return const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.darkTextSecondary, // Pasif sekmede gri
          );
        }),
        
        // Koyu mod sekme simge renkleri
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primaryLight);
          }
          return const IconThemeData(color: AppColors.darkTextSecondary);
        }),
      ),
      
      // Koyu Mod Buton Teması
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, // Buton dolgu rengi
          foregroundColor: Colors.white, // Buton yazı rengi
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
      
      // Koyu Mod Giriş Kutuları Teması
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceVariant, // Koyu giriş kutusu dolgusu
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF334155)), // Koyu pasif çerçeve çizgisi
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2), // Odaklanıldığında belirgin açık renk çerçeve
        ),
      ),
    );
  }
}
