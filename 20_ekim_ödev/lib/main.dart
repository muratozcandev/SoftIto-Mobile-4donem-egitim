<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: main.dart
// Görev: AraÇek uygulamasının ana giriş noktası (entrypoint) ve sekmeli gezinim kabuğu.
// Açıklama: ThemeController ve LocaleController ile reaktif entegre çalışır;
// Material Design 3 NavigationBar ile Keşfet, AraÇek, Profil ve Ayarlar sekmelerini sunar.
// ==============================================================================

import 'package:flutter/material.dart';
import 'core/constants/app_colors.dart';
import 'core/localization/app_strings.dart';
import 'core/localization/locale_controller.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'features/authentication/controllers/auth_controller.dart';
import 'features/authentication/views/login_view.dart';
import 'features/damage_report/views/damage_report_view.dart';
import 'features/home/views/home_view.dart';
import 'features/profile/views/profile_view.dart';
import 'features/settings/views/settings_view.dart';

/// Uygulamanın başlatıcı ana fonksiyonu
void main() {
  // Flutter motorunun widget bağlayıcısını ilklendirir
  WidgetsFlutterBinding.ensureInitialized();

  // AraÇek ana uygulamasını çalıştırır
  runApp(const AraCekApp());
}

/// [AraCekApp] widget'ı, uygulamanın kök (root) widget'ıdır.
/// Tema modu ve dil değişikliklerini dinleyerek MaterialApp'i günceller.
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
class AraCekApp extends StatelessWidget {
  const AraCekApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
    // 1. Tema değişimlerini dinleyen reaktif yapı
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.instance.themeModeNotifier,
      builder: (context, themeMode, _) {
        // 2. Dil değişimlerini dinleyen reaktif yapı
        return ValueListenableBuilder<Locale>(
          valueListenable: LocaleController.instance.localeNotifier,
          builder: (context, currentLocale, _) {
            return MaterialApp(
              title: 'AraÇek - Araç Kiralama ve Teslimat',
              debugShowCheckedModeBanner: false,

              // Açık ve Koyu Tema Tanımları
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,

              // Aktif Dil Ayarı
              locale: currentLocale,

              // Kök Görünüm: Oturum durumunu dinler
              home: const AppRootView(),
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
            );
          },
        );
      },
    );
  }
}
<<<<<<< Updated upstream
=======
<<<<<<< HEAD

/// [AppRootView] widget'ı, kullanıcının oturum açıp açmadığını denetler.
/// Oturum açıksa ana kabuğa (MainShellView), kapalıysa Giriş ekranına yönlendirir.
class AppRootView extends StatefulWidget {
  const AppRootView({super.key});

  @override
  State<AppRootView> createState() => _AppRootViewState();
}

class _AppRootViewState extends State<AppRootView> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AuthController.instance.currentUserNotifier,
      builder: (context, currentUser, _) {
        // Kullanıcı giriş yapmamışsa LoginView gösterilir
        if (currentUser == null) {
          return LoginView(
            onLoginSuccess: () => setState(() {}),
          );
        }

        // Oturum açıksa sekmeli ana kabuk gösterilir
        return MainShellView(
          onLogout: () => setState(() {}),
        );
      },
    );
  }
}

/// [MainShellView] widget'ı, 4 ana sekmeyi barındıran alt navigasyon çubuğu kabuğudur.
class MainShellView extends StatefulWidget {
  final VoidCallback onLogout;

  const MainShellView({super.key, required this.onLogout});

  @override
  State<MainShellView> createState() => _MainShellViewState();
}

class _MainShellViewState extends State<MainShellView> {
  /// Aktif seçili sekme indeksi (0: Keşfet, 1: AraÇek, 2: Profil, 3: Ayarlar)
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isEn = LocaleController.instance.isEnglish;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Sayfaların durumunu (scroll vb.) korumak için IndexedStack kullanılır
    final pages = [
      // 0: Ana Sayfa / Keşfet
      HomeView(
        onNavigateToDamageReport: () {
          setState(() => _currentIndex = 1);
        },
      ),
      // 1: Hasar & Fotoğraf Çekim Ekranı (AraÇek)
      const DamageReportView(),
      // 2: Profil Ekranı
      const ProfileView(),
      // 3: Ayarlar Ekranı
      SettingsView(
        onLogout: widget.onLogout,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        backgroundColor:
            isDark ? AppColors.darkSurface : AppColors.lightSurface,
        indicatorColor: AppColors.primary.withValues(alpha: 0.2),
        elevation: 3,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.directions_car_outlined),
            selectedIcon: const Icon(Icons.directions_car_filled,
                color: AppColors.primary),
            label: AppStrings.navHome(isEn),
          ),
          NavigationDestination(
            icon: const Icon(Icons.camera_alt_outlined),
            selectedIcon: const Icon(Icons.camera_alt_rounded,
                color: AppColors.primary),
            label: AppStrings.navDamage(isEn),
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon:
                const Icon(Icons.person_rounded, color: AppColors.primary),
            label: AppStrings.navProfile(isEn),
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon:
                const Icon(Icons.settings_rounded, color: AppColors.primary),
            label: AppStrings.navSettings(isEn),
          ),
        ],
      ),
    );
  }
}
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
