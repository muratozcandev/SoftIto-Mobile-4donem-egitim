import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/localization/locale_controller.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import 'register_view.dart';
import '../../home/views/main_navigation_shell.dart';

/// [LoginView] ekranı, kullanıcının e-posta veya telefon numarası ve şifresiyle
/// AraÇek uygulamasına giriş yapmasını sağlayan güvenli form arayüzüdür.
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Form doğrulama anahtarı
  final _formKey = GlobalKey<FormState>();

  // Metin girdi kontrolcüleri
  final _identifierController =
      TextEditingController(text: 'demo@aracek.com');
  final _passwordController = TextEditingController(text: '123456');

  // Şifre gizlilik durumu
  bool _obscurePassword = true;

  // Yüklenme durumu
  bool _isLoading = false;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Giriş formunu doğrulayıp ana ekrana yönlendiren işlem
  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    // Kısa bir yapay gecikme simülasyonu
    await Future.delayed(const Duration(milliseconds: 600));

    final success = AuthController.instance.login(
      identifier: _identifierController.text,
      password: _passwordController.text,
    );

    if (mounted) {
      setState(() => _isLoading = false);
      if (success) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const MainNavigationShell(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = ThemeController.instance.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          // Hızlı Tema Değiştirme Butonu
          IconButton(
            tooltip: 'Temayı Değiştir',
            icon: Icon(
              isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              color: AppColors.primary,
            ),
            onPressed: () {
              setState(() {
                ThemeController.instance.toggleTheme();
              });
            },
          ),
          // Hızlı Dil Değiştirme Butonu (TR / EN)
          TextButton(
            onPressed: () {
              setState(() {
                LocaleController.instance.toggleLocale();
              });
            },
            child: Text(
              LocaleController.instance.isTurkish ? 'EN' : 'TR',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.accent,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // AraÇek Logosu ve Animasyonlu Çerçevesi
                  Container(
                    width: 105,
                    height: 105,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withAlpha(90),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        AppAssets.appLogo,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Uygulama Başlığı ve Slogan
                  Text(
                    AppStrings.get('app_name'),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.get('app_slogan'),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 36),

                  // E-posta / Telefon Giriş Alanı
                  AuthTextField(
                    controller: _identifierController,
                    labelText: AppStrings.get('email_or_phone'),
                    hintText: 'ornek@aracek.com veya 0532...',
                    prefixIcon: Icons.person_outline,
                    keyboardType: TextInputType.emailAddress,
                    validator: AuthController.instance.validateIdentifier,
                  ),

                  // Şifre Giriş Alanı
                  AuthTextField(
                    controller: _passwordController,
                    labelText: AppStrings.get('password'),
                    hintText: '••••••',
                    prefixIcon: Icons.lock_outline,
                    obscureText: _obscurePassword,
                    validator: AuthController.instance.validatePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Giriş Yap Butonu
                  AuthButton(
                    text: AppStrings.get('login'),
                    isLoading: _isLoading,
                    icon: Icons.login_rounded,
                    onPressed: _handleLogin,
                  ),
                  const SizedBox(height: 24),

                  // Kayıt Ol Yönlendirme Bağlantısı
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.get('dont_have_account'),
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const RegisterView(),
                        ),
                      );
                    },
                    child: Text(
                      AppStrings.get('register'),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
