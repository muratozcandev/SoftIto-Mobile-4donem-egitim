import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'core/localization/locale_controller.dart';
import 'features/authentication/views/login_view.dart';

/// [main] fonksiyonu, AraÇek uygulamasının ana başlangıç (entry point) noktasıdır.
void main() {
  // Flutter motoru ve widget ağacının düzgün başlatılmasını garanti altına alır
  WidgetsFlutterBinding.ensureInitialized();

  // Durum çubuğunu (StatusBar) şeffaf yaparak modern tam ekran hissi kazandırır
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // Ana uygulama widget'ını çalıştır
  runApp(const AraCekApp());
}

/// [AraCekApp] sınıfı, uygulamanın en tepe seviyedeki kök widget'ıdır.
/// Temayı ([ThemeController]) ve dili ([LocaleController]) reaktif olarak dinler
/// ve MaterialApp yapılandırmasını sağlar.
class AraCekApp extends StatelessWidget {
  const AraCekApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Tema dinleyicisi: Kullanıcı tema butonuna bastığında arayüz anında güncellenir
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.instance.themeModeNotifier,
      builder: (context, currentThemeMode, _) {
        // 2. Dil dinleyicisi: Türkçe ve İngilizce geçişini reaktif olarak sağlar
        return ValueListenableBuilder<String>(
          valueListenable: LocaleController.instance.localeNotifier,
          builder: (context, currentLocaleCode, _) {
            return MaterialApp(
              // Uygulama başlığı
              title: 'AraÇek',

              // Hata ayıklama (Debug) bandını gizler
              debugShowCheckedModeBanner: false,

              // Material 3 Açık Tema tanımı
              theme: AppTheme.lightTheme,

              // Material 3 Koyu Tema tanımı
              darkTheme: AppTheme.darkTheme,

              // Aktif tema modu (Koyu / Açık)
              themeMode: currentThemeMode,

              // Başlangıç ekranı olarak Giriş Ekranını açar
              home: const LoginView(),
            );
          },
        );
      },
    );
  }
}
