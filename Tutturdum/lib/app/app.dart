import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/theme_controller.dart';
import '../core/constants/app_constants.dart';
import '../data/repositories/user_repository.dart';
import '../features/auth/views/login_view.dart';
import '../features/navigation/views/main_scaffold_view.dart';

/// Tutturdum Ana Uygulama Widget'ı
class TutturdumApp extends StatelessWidget {
  const TutturdumApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.instance;
    final isAuthenticated = UserRepository.instance.isAuthenticated;

    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        return MaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode,
          home: isAuthenticated ? const MainScaffoldView() : const LoginView(),
        );
      },
    );
  }
}
