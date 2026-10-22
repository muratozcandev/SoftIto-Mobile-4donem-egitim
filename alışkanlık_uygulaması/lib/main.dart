import 'package:flutter/material.dart';
import 'controllers/auth_controller.dart';
import 'controllers/theme_controller.dart';
import 'core/theme/app_theme.dart';
import 'views/auth/login_view.dart';
import 'views/navigation/main_navigation_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AliskanlikTakibiApp());
}

class AliskanlikTakibiApp extends StatelessWidget {
  const AliskanlikTakibiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.instance;
    final authController = AuthController.instance;

    return AnimatedBuilder(
      animation: Listenable.merge([themeController, authController]),
      builder: (context, _) {
        return MaterialApp(
          title: 'Alışkanlık Takibi',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode,
          home: authController.isLoggedIn
              ? const MainNavigationWrapper(initialIndex: 0)
              : const LoginView(),
        );
      },
    );
  }
}
