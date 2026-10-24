<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: register_view.dart
// Görev: Kullanıcının sisteme yeni hesap oluşturduğu kayıt olma ekranı.
// Açıklama: İsim, e-posta, telefon ve şifre doğrulamalarını içeren şık form yapısı.
// ==============================================================================

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/localization/locale_controller.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_text_field.dart';

/// [RegisterView] widget'ı, yeni kullanıcı kayıt formunu barındırır.
class RegisterView extends StatefulWidget {
  final VoidCallback onRegisterSuccess;

  const RegisterView({super.key, required this.onRegisterSuccess});
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
  /// Form validasyon kontrol anahtarı
  final _formKey = GlobalKey<FormState>();

  /// Ad Soyad girdi kontrolcüsü
  final _nameController = TextEditingController();

  /// E-posta girdi kontrolcüsü
  final _emailController = TextEditingController();

  /// Telefon numarası girdi kontrolcüsü
  final _phoneController = TextEditingController();

  /// Şifre girdi kontrolcüsü
  final _passwordController = TextEditingController();

  /// Yükleniyor durumu bayrağı
=======
>>>>>>> Stashed changes
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _licenseAgeController = TextEditingController(text: '3');
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
  bool _isLoading = false;

  @override
  void dispose() {
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
=======
>>>>>>> Stashed changes
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _licenseAgeController.dispose();
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
    _passwordController.dispose();
    super.dispose();
  }

  /// Kayıt işlemini gerçekleştiren fonksiyon
<<<<<<< Updated upstream
  void _handleRegister() async {
=======
<<<<<<< HEAD
  void _handleRegister() {
=======
  void _handleRegister() async {
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;

      final success = AuthController.instance.register(
        fullName: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
      );

      setState(() => _isLoading = false);

      if (success) {
        Navigator.pop(context); // Kayıt ekranını kapat
        widget.onRegisterSuccess(); // Ana akışa geç
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.error,
            content: Text('Lütfen tüm alanları eksiksiz ve geçerli doldurunuz.'),
          ),
        );
      }
    });
=======
>>>>>>> Stashed changes
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
    final isEn = LocaleController.instance.isEnglish;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.register(isEn)),
=======
>>>>>>> Stashed changes
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.get('register')),
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Açıklayıcı Başlık
                    Text(
                      isEn ? 'Create Your Account' : 'Hesabınızı Oluşturun',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isEn
                          ? 'Start renting and inspecting vehicles today'
                          : 'Hemen kaydolun, güvenli araç kiralama deneyimine başlayın',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Ad Soyad Alanı
                    AuthTextField(
                      controller: _nameController,
                      label: AppStrings.fullName(isEn),
                      hint: AppStrings.fullNameHint(isEn),
                      prefixIcon: Icons.badge_outlined,
                      validator: (value) => AuthController.validateRequired(
                        value,
                        AppStrings.fieldRequired(isEn),
                      ),
                    ),

                    // E-posta Alanı
                    AuthTextField(
                      controller: _emailController,
                      label: 'E-posta',
                      hint: 'ornek@aracek.com',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => AuthController.validateEmailOrPhone(
                        value,
                        AppStrings.invalidEmail(isEn),
                      ),
                    ),

                    // Telefon Alanı
                    AuthTextField(
                      controller: _phoneController,
                      label: AppStrings.phone(isEn),
                      hint: '0555 123 45 67',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) => AuthController.validateRequired(
                        value,
                        AppStrings.fieldRequired(isEn),
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
                    const SizedBox(height: 16),

                    // Kayıt Ol Butonu
                    ElevatedButton(
                      onPressed: _isLoading ? null : _handleRegister,
                      child: _isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.black,
                              ),
                            )
                          : Text(AppStrings.register(isEn)),
                    ),
                    const SizedBox(height: 20),

                    // Giriş Yap Ekranına Geri Dönüş
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          AppStrings.alreadyHaveAccount(isEn),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
=======
>>>>>>> Stashed changes
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
