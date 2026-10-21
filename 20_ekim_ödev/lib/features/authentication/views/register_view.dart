import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_strings.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import '../../home/views/main_navigation_shell.dart';

/// [RegisterView] ekranı, yeni bir kullanıcının ad, e-posta, telefon,
/// ehliyet yılı ve şifre bilgilerini girerek sisteme kaydolmasını sağlayan formdur.
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _licenseAgeController = TextEditingController(text: '3');
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _licenseAgeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Kayıt işlemini gerçekleştiren fonksiyon
  void _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(milliseconds: 600));

    final success = AuthController.instance.register(
      fullName: _fullNameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      licenseYears: int.tryParse(_licenseAgeController.text) ?? 1,
      password: _passwordController.text,
    );

    if (mounted) {
      setState(() => _isLoading = false);
      if (success) {
        // Kayıt başarılı olunca doğrudan ana kabuğa yönlendir
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const MainNavigationShell(),
          ),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.get('register')),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'AraÇek Ailesine Katılın',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Birkaç adımda hesabınızı oluşturup dilediğiniz aracı kiralayın.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Ad Soyad
                  AuthTextField(
                    controller: _fullNameController,
                    labelText: AppStrings.get('full_name'),
                    hintText: 'Örn: Mehmet Can',
                    prefixIcon: Icons.badge_outlined,
                    validator: (v) =>
                        AuthController.instance.validateRequired(v, 'Ad Soyad zorunludur'),
                  ),

                  // E-posta
                  AuthTextField(
                    controller: _emailController,
                    labelText: 'E-posta Adresi',
                    hintText: 'ornek@mail.com',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: AuthController.instance.validateIdentifier,
                  ),

                  // Telefon
                  AuthTextField(
                    controller: _phoneController,
                    labelText: AppStrings.get('phone_number'),
                    hintText: '05XX XXX XX XX',
                    prefixIcon: Icons.phone_android_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (v) =>
                        AuthController.instance.validateRequired(v, 'Telefon numarası zorunludur'),
                  ),

                  // Ehliyet Yaşı
                  AuthTextField(
                    controller: _licenseAgeController,
                    labelText: AppStrings.get('driving_license_age'),
                    hintText: 'Kaç yıldır ehliyet sahibisiniz? (Örn: 4)',
                    prefixIcon: Icons.drive_eta_outlined,
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        AuthController.instance.validateRequired(v, 'Ehliyet süresi zorunludur'),
                  ),

                  // Şifre
                  AuthTextField(
                    controller: _passwordController,
                    labelText: AppStrings.get('password'),
                    hintText: 'En az 6 karakter',
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
                  const SizedBox(height: 16),

                  // Kayıt Ol Butonu
                  AuthButton(
                    text: AppStrings.get('register'),
                    isLoading: _isLoading,
                    icon: Icons.person_add_alt_1_rounded,
                    onPressed: _handleRegister,
                  ),
                  const SizedBox(height: 16),

                  // Giriş Yap Bağlantısı
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      AppStrings.get('already_have_account'),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
