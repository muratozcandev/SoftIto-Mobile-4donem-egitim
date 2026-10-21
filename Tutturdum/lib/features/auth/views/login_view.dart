import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/repositories/user_repository.dart';
import 'register_view.dart';
import '../../navigation/views/main_scaffold_view.dart';

/// Giriş Ekranı
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = await UserRepository.instance.login(
        identifier: _identifierController.text,
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainScaffoldView()),
        );
      } else {
        setState(() {
          _errorMessage = 'Geçersiz TC No / E-posta veya şifre! (Demo: 12345678901 / 123456)';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleDemoLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await UserRepository.instance.loginWithDemoAccount();
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainScaffoldView()),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Marka ve Logo Alanı
                    Center(
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.darkPrimaryAccent.withValues(alpha: 0.35),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/icons/app_icon.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.sports_soccer,
                              size: 56,
                              color: AppColors.darkPrimaryAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppConstants.appName,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineLarge?.copyWith(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppConstants.appSubtitle,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark ? AppColors.darkSecondaryAccent : AppColors.lightSecondaryAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Demo Uyarısı
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (isDark ? AppColors.darkSecondaryAccent : AppColors.lightSecondaryAccent)
                            .withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: (isDark ? AppColors.darkSecondaryAccent : AppColors.lightSecondaryAccent)
                              .withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 20,
                            color: isDark ? AppColors.darkSecondaryAccent : AppColors.lightSecondaryAccent,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'Bu uygulama eğitim simülasyonudur. Gerçek para ve bahis işlemi yapılmaz.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    if (_errorMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.red.withValues(alpha: 0.4)),
                        ),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.redAccent, fontSize: 13),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // TC No veya E-posta
                    AppTextField(
                      controller: _identifierController,
                      label: 'TC Kimlik Numarası veya E-Posta',
                      hint: '11 haneli TC No veya e-posta giriniz',
                      prefixIcon: Icons.badge_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Lütfen TC No veya E-posta giriniz';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Şifre
                    AppTextField(
                      controller: _passwordController,
                      label: 'Şifre',
                      hint: 'Şifrenizi giriniz',
                      prefixIcon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          size: 20,
                        ),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Lütfen şifrenizi giriniz';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Giriş Butonu
                    AppButton(
                      label: 'Giriş Yap',
                      icon: Icons.login,
                      isLoading: _isLoading,
                      onPressed: _handleLogin,
                    ),
                    const SizedBox(height: 12),

                    // Demo Hesapla Giriş Butonu
                    AppButton(
                      label: 'Hızlı Demo Hesabıyla Giriş Yap',
                      icon: Icons.flash_on,
                      isOutlined: true,
                      onPressed: _isLoading ? null : _handleDemoLogin,
                    ),
                    const SizedBox(height: 24),

                    // Kayıt Ol Yönlendirmesi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hesabınız yok mu?',
                          style: theme.textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const RegisterView()),
                            );
                          },
                          child: Text(
                            'Kayıt Ol',
                            style: TextStyle(
                              color: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
