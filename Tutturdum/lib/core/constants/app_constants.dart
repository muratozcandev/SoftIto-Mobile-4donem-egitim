/// Tutturdum uygulama sabitleri
abstract class AppConstants {
  static const String appName = 'Tutturdum';
  static const String appSubtitle = 'Futbol Bahis Kuponu Simülasyonu';
  static const String appVersion = '1.0.0';

  // Kupon kuralları
  static const double minBetAmount = 50.0; // Minimum bahis tutarı 50 TL
  static const double initialDemoBalance = 1000.0; // Başlangıç sanal bakiyesi

  // Özel Demo Şartları
  static const String superLigLeaderTeam = 'Beşiktaş';
  static const String superLigLastTeam = 'Galatasaray';

  // Depolama Anahtarları
  static const String keyThemeMode = 'app_theme_mode';
  static const String keyVirtualBalance = 'virtual_balance';
  static const String keyCurrentUser = 'current_user';
  static const String keyCoupons = 'saved_coupons';
  static const String keyNotifications = 'saved_notifications';
  static const String keyChatMessages = 'saved_chat_messages';
  static const String keyCartSelections = 'saved_cart_selections';
}
