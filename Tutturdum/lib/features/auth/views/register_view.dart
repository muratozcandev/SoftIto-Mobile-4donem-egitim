import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/input_validators.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/repositories/user_repository.dart';

/// Kayıt Ekranı
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _tcController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _fullNameController.dispose();
    _tcController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await UserRepository.instance.register(
        fullName: _fullNameController.text,
        tcNo: _tcController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kayıt başarılı! Şimdi giriş yapabilirsiniz.'),
          backgroundColor: AppColors.success,
        ),
      );

      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
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
      appBar: AppBar(
        title: const Text('Yeni Hesap Oluştur'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Gizlilik ve Demo Bilgilendirmesi
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
                      child: const Row(
                        children: [
                          Icon(Icons.shield_outlined, size: 20, color: AppColors.darkSecondaryAccent),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Gizlilik Bildirimi: Bilgileriniz yalnızca yerel prototipte saklanır, hiçbir harici sunucuya veya üçüncü tarafa gönderilmez.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

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

                    // Ad Soyad
                    AppTextField(
                      controller: _fullNameController,
                      label: 'Ad Soyad',
                      hint: 'Örn: Ahmet Yılmaz',
                      prefixIcon: Icons.person_outline,
                      validator: (val) => InputValidators.validateRequired(val, 'Ad Soyad'),
                    ),
                    const SizedBox(height: 14),

                    // TC Kimlik No
                    AppTextField(
                      controller: _tcController,
                      label: 'TC Kimlik Numarası (Demo)',
                      hint: '11 haneli TC No giriniz',
                      prefixIcon: Icons.badge_outlined,
                      keyboardType: TextInputType.number,
                      validator: InputValidators.validateTcNo,
                    ),
                    const SizedBox(height: 14),

                    // Telefon Numarası
                    AppTextField(
                      controller: _phoneController,
                      label: 'Telefon Numarası',
                      hint: '05xx xxx xx xx',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: InputValidators.validatePhone,
                    ),
                    const SizedBox(height: 14),

                    // E-Posta
                    AppTextField(
                      controller: _emailController,
                      label: 'E-Posta Adresi',
                      hint: 'ornek@eposta.com',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: InputValidators.validateEmail,
                    ),
                    const SizedBox(height: 14),

                    // Şifre
                    AppTextField(
                      controller: _passwordController,
                      label: 'Şifre',
                      hint: 'En az 6 karakter',
                      prefixIcon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          size: 20,
                        ),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      validator: InputValidators.validatePassword,
                    ),
                    const SizedBox(height: 14),

                    // Şifre Doğrulama
                    AppTextField(
                      controller: _confirmPasswordController,
                      label: 'Şifre Tekrarı',
                      hint: 'Şifrenizi tekrar giriniz',
                      prefixIcon: Icons.lock_reset_outlined,
                      obscureText: _obscureConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          size: 20,
                        ),
                        onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                      ),
                      validator: (val) => InputValidators.validateConfirmPassword(val, _passwordController.text),
                    ),
                    const SizedBox(height: 24),

                    // Kaydı Tamamla Butonu
                    AppButton(
                      label: 'Kayıt İşlemini Tamamla',
                      icon: Icons.check_circle_outline,
                      isLoading: _isLoading,
                      onPressed: _handleRegister,
                    ),
                    const SizedBox(height: 16),
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
