import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../core/constants/app_colors.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _termsAccepted = false;
  bool _kvkkAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _identifierController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Şifreler birbiriyle uyuşmuyor.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final error = AuthController.instance.register(
      fullName: _nameController.text,
      identifier: _identifierController.text,
      password: _passwordController.text,
      termsAccepted: _termsAccepted,
      kvkkAccepted: _kvkkAccepted,
    );

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // Kayıt oluşturulduktan sonra giriş ekranına dönülür
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Kayıt başarıyla tamamlandı! Lütfen giriş yapınız.'),
        backgroundColor: AppColors.success,
      ),
    );

    Navigator.pop(context);
  }

  void _showModalInfo(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(content, style: const TextStyle(fontSize: 13, height: 1.5)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Anladım'),
          ),
        ],
      ),
    );
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Alışkanlık Takibi\'ne Katıl! 🌟',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Kişiselleştirilmiş sağlık ve alışkanlık hedeflerini hemen belirle.',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 24),

                // Ad Soyad
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Ad Soyad',
                    hintText: 'Örn. Ahmet Yılmaz',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Lütfen adınızı ve soyadınızı giriniz.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // E-posta veya Telefon
                TextFormField(
                  controller: _identifierController,
                  decoration: const InputDecoration(
                    labelText: 'E-posta veya Telefon Numarası',
                    hintText: 'ornek@email.com / 0555...',
                    prefixIcon: Icon(Icons.alternate_email_rounded),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Lütfen e-posta veya telefon giriniz.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Şifre
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Lütfen şifrenizi giriniz.';
                    }
                    if (val.length < 4) {
                      return 'Şifre en az 4 karakter olmalıdır.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Şifre Tekrar
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscurePassword,
                  decoration: const InputDecoration(
                    labelText: 'Şifre Tekrar',
                    prefixIcon: Icon(Icons.lock_reset_rounded),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Lütfen şifrenizi tekrar giriniz.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Sözleşme Onayları
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _termsAccepted,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Kullanıcı Sözleşmesini okudum ve onaylıyorum.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.info_outline, size: 18),
                        onPressed: () => _showModalInfo(
                          'Kullanıcı Sözleşmesi',
                          'Bu uygulama bir prototip olup kullanıcı verilerini yerel bellek üzerinde simüle eder. Gerçek ticari işlem barındırmaz.',
                        ),
                      ),
                    ],
                  ),
                  onChanged: (val) => setState(() => _termsAccepted = val ?? false),
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _kvkkAccepted,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'KVKK Aydınlatma Metnini okudum ve onaylıyorum.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.info_outline, size: 18),
                        onPressed: () => _showModalInfo(
                          'KVKK Aydınlatma Metni',
                          'Kişisel verileriniz hiçbir üçüncü parti sunucuya aktarılmaz, yalnızca cihazınızda demo hedeflerini kaydetmek amacıyla işlenir.',
                        ),
                      ),
                    ],
                  ),
                  onChanged: (val) => setState(() => _kvkkAccepted = val ?? false),
                ),
                const SizedBox(height: 24),

                // Kayıt Ol Butonu
                ElevatedButton(
                  onPressed: _handleRegister,
                  child: const Text('Hesap Oluştur ve Giriş Yap'),
                ),
                const SizedBox(height: 20),

                // Zaten hesabım var
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Zaten hesabın var mı?',
                      style: TextStyle(
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Giriş Yap',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
