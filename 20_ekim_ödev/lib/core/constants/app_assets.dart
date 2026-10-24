<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: app_assets.dart
// Görev: Uygulama içerisinde kullanılan görsel, logo ve ikon yollarını yönetir.
// Açıklama: Dosya yollarının el ile yanlış yazılmasını önlemek için merkezi
// sabitler sağlar.
// ==============================================================================

/// [AppAssets] sınıfı, yerel olarak tanımlanmış varlıkların (asset) yollarını barındırır.
abstract class AppAssets {
  /// AraÇek uygulamasına özel üretilen ana logo ve uygulama simgesi.
  /// Otomobil silueti, kamera lensi ve teslimat onay tikini bir arada barındırır.
  static const String logo = 'assets/images/logo.png';

  /// Web favicon simgesi yolu
  static const String favicon = 'web/favicon.png';
=======
>>>>>>> Stashed changes
/// [AppAssets] sınıfı, AraÇek uygulamasında kullanılan tüm yerel görsel,
/// ikon ve marka varlıklarının dosya yollarını sabit olarak tanımlar.
/// Bu sayede yazım hatalarının önüne geçilir ve görsel yönetimi tek elden yapılır.
class AppAssets {
  // Sınıfın dışarıdan örneklenmesini (instance) engeller
  const AppAssets._();

  // ==========================================
  // MARKA VE LOGO VARLIKLARI (BRAND ASSETS)
  // ==========================================

  /// AraÇek ana uygulama ikonu ve yuvarlak logo görseli:
  /// Giriş ekranında, profil sayfasında ve karşılama diyaloglarında kullanılır.
  static const String appLogo = 'assets/images/app_logo.png';

  /// AraÇek yatay banner logosu:
  /// 'AraÇek - Kirala & Güvenle Çek' sloganı ve spor araba silüetini içerir.
  static const String bannerLogo = 'assets/images/banner_logo.jpg';

  // ==========================================
  // ARAÇ GÖRSELLERİ (VEHICLE PHOTOGRAPHY)
  // ==========================================

  /// Elektrikli Lüks Spor Sedan görseli (Tesla / Taycan sınıfı araçlar için):
  static const String carSedan = 'assets/images/car_sedan.jpg';

  /// Performans SUV görseli (Geniş aile ve offroad/şehir crossover araçlar için):
  static const String carSuv = 'assets/images/car_suv.jpg';

  /// Egzotik Spor Coupe görseli (Kırmızı lüks spor otomobiller için):
  static const String carCoupe = 'assets/images/car_coupe.jpg';

  /// Şehir İçi Kompakt Hatchback görseli (Ekonomik ve pratik şehir araçları için):
  static const String carHatchback = 'assets/images/car_hatchback.jpg';
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
}
