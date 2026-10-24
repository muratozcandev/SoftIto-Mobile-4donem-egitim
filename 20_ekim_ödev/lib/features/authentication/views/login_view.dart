<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: login_view.dart
// Görev: Kullanıcının sisteme giriş yaptığı modern ve görsel açıdan zengin ekran.
// Açıklama: AraÇek logosu, doğrulama destekli form alanları, dil ve tema değiştirici
// butonları içerir. Misafir girişi kural gereği bulunmaz.
// ==============================================================================

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/localization/locale_controller.dart';
import '../../../core/theme/theme_controller.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_text_field.dart';
import 'register_view.dart';

/// [LoginView] widget'ı, kullanıcı giriş ekranını temsil eder.
class LoginView extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginView({super.key, required this.onLoginSuccess});
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
  /// Formun geçerlilik durumunu denetlemek için kullanılan global anahtar
  final _formKey = GlobalKey<FormState>();

  /// E-posta veya telefon girdisini kontrol eden controller
  final _emailPhoneController =
      TextEditingController(text: 'murat@aracek.com');

  /// Şifre girdisini kontrol eden controller
  final _passwordController =
      TextEditingController(text: '123456');

  /// Giriş butonunun yüklenme durumunu gösteren yerel bayrak
=======
>>>>>>> Stashed changes
  // Form doğrulama anahtarı
  final _formKey = GlobalKey<FormState>();

  // Metin girdi kontrolcüleri
  final _identifierController =
      TextEditingController(text: 'demo@aracek.com');
  final _passwordController = TextEditingController(text: '123456');

  // Şifre gizlilik durumu
  bool _obscurePassword = true;

  // Yüklenme durumu
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
  bool _isLoading = false;

  @override
  void dispose() {
<<<<<<< Updated upstream
    _identifierController.dispose();
=======
<<<<<<< HEAD
    // Bellek sızıntılarını önlemek için controller'lar serbest bırakılır
    _emailPhoneController.dispose();
=======
    _identifierController.dispose();
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
    _passwordController.dispose();
    super.dispose();
  }

<<<<<<< Updated upstream
  /// Giriş formunu doğrulayıp ana ekrana yönlendiren işlem
  void _handleLogin() async {
=======
<<<<<<< HEAD
  /// Giriş işlemini tetikleyen fonksiyon
  void _handleLogin() {
    // Formdaki validatörler çalıştırılır
=======
  /// Giriş formunu doğrulayıp ana ekrana yönlendiren işlem
  void _handleLogin() async {
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
    // Gerçekçi bir etkileşim hissi için hafif bir gecikme simülasyonu
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;

      final success = AuthController.instance.login(
        emailOrPhone: _emailPhoneController.text,
        password: _passwordController.text,
      );

      setState(() => _isLoading = false);

      if (success) {
        widget.onLoginSuccess();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.error,
            content: Text('Lütfen geçerli giriş bilgileri giriniz.'),
          ),
        );
      }
    });
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
    // Dil durumunu dinleyerek arayüzü günceller
    final isEn = LocaleController.instance.isEnglish;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: ConstrainedBox(
              // Geniş ekranlarda (Web / Masaüstü) formun çok genişlemesini engeller
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ---------------------------------------------------------
                    // Üst Hızlı Butonlar: Dil ve Tema Değiştirici
                    // ---------------------------------------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Dil Değiştirme Butonu (TR / EN)
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              LocaleController.instance.toggleLocale();
                            });
                          },
                          icon: const Icon(Icons.language, size: 18),
                          label: Text(
                            isEn ? 'EN' : 'TR',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Tema Değiştirme Butonu (Açık / Koyu)
                        IconButton(
                          tooltip: 'Temayı Değiştir',
                          onPressed: () {
                            ThemeController.instance.toggleTheme();
                          },
                          icon: Icon(
                            ThemeController.instance.isDarkMode
                                ? Icons.wb_sunny_outlined
                                : Icons.nightlight_round_outlined,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // ---------------------------------------------------------
                    // AraÇek Özel Logo ve Başlık Alanı
                    // ---------------------------------------------------------
                    Center(
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.35),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: Image.asset(
                            AppAssets.logo,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.darkSurface,
                                child: const Icon(
                                  Icons.car_rental,
                                  size: 45,
                                  color: AppColors.primary,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Uygulama Adı
                    Text(
                      AppStrings.appName(isEn),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Slogan
                    Text(
                      AppStrings.slogan(isEn),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(height: 36),

                    // ---------------------------------------------------------
                    // Giriş Form Alanları
                    // ---------------------------------------------------------
                    // E-posta veya Telefon Alanı
                    AuthTextField(
                      controller: _emailPhoneController,
                      label: AppStrings.emailOrPhone(isEn),
                      hint: AppStrings.emailOrPhoneHint(isEn),
                      prefixIcon: Icons.person_outline,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => AuthController.validateEmailOrPhone(
                        value,
                        AppStrings.invalidEmail(isEn),
                      ),
                    ),

                    // Şifre Alanı
                    AuthTextField(
                      controller: _passwordController,
                      label: AppStrings.password(isEn),
                      hint: AppStrings.passwordHint(isEn),
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      validator: (value) => AuthController.validatePassword(
                        value,
                        AppStrings.passwordTooShort(isEn),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ---------------------------------------------------------
                    // Giriş Yap Butonu
                    // ---------------------------------------------------------
                    ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      child: _isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.black,
                              ),
                            )
                          : Text(AppStrings.login(isEn)),
                    ),
                    const SizedBox(height: 20),

                    // ---------------------------------------------------------
                    // Kayıt Ol Yönlendirmesi
                    // ---------------------------------------------------------
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Kayıt ekranına geçiş yapılır
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterView(
                                onRegisterSuccess: widget.onLoginSuccess,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          AppStrings.noAccount(isEn),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
              ),
            ),
          ),
        ),
      ),
    );
  }
}
