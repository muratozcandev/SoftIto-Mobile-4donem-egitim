<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: profile_view.dart
// Görev: Kullanıcının profil bilgilerini, sanal kayıtlı kartlarını ve üyelik rozetini sunar.
// Açıklama: İn-memory kullanıcı modeli ile entegre çalışır; kiralama istatistiklerini listeler.
// ==============================================================================

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/localization/locale_controller.dart';
import '../../authentication/controllers/auth_controller.dart';

/// [ProfileView] widget'ı, kullanıcı profil yönetim ve özet ekranıdır.
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final isEn = LocaleController.instance.isEnglish;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = AuthController.instance.currentUserNotifier.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.profileTitle(isEn)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 550),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // -----------------------------------------------------------
                  // Profil Başlık Kartı (Avatar, İsim, Rozet)
                  // -----------------------------------------------------------
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Profil Avatarı
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 42,
                              backgroundColor:
                                  AppColors.primary.withValues(alpha: 0.15),
                              child: const Icon(
                                Icons.person,
                                size: 48,
                                color: AppColors.primary,
                              ),
                            ),
                            const CircleAvatar(
                              radius: 13,
                              backgroundColor: AppColors.success,
                              child: Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Kullanıcı Adı
                        Text(
                          user?.fullName ?? 'Murat Yılmaz',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // E-posta ve Telefon
                        Text(
                          '${user?.email ?? "murat@aracek.com"} • ${user?.phone ?? "0555 123 45 67"}',
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Üyelik Rozeti
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.secondary.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.workspace_premium_rounded,
                                size: 16,
                                color: AppColors.secondary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                user?.membershipTier ?? 'AraÇek VIP Üye',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // -----------------------------------------------------------
                  // İstatistik Özet Kartları
                  // -----------------------------------------------------------
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.directions_car_rounded,
                          title: isEn ? 'Rented' : 'Kiralanan',
                          value: '14 Araç',
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.calendar_month_rounded,
                          title: isEn ? 'Total Days' : 'Sürüş Süresi',
                          value: '42 Gün',
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.star_rounded,
                          title: isEn ? 'Trust Score' : 'Güven Puanı',
                          value: '4.98',
                          isDark: isDark,
                          isWarning: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // -----------------------------------------------------------
                  // Kayıtlı Sanal Kartlar
                  // -----------------------------------------------------------
                  Text(
                    AppStrings.savedCards(isEn),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildCardItem(
                    cardTitle: 'AraÇek Platinum Visa',
                    cardNumber: '•••• •••• •••• 5678',
                    expiry: '12/28',
                    isDark: isDark,
                  ),
                  const SizedBox(height: 10),
                  _buildCardItem(
                    cardTitle: 'Mastercard Bonus Sanal',
                    cardNumber: '•••• •••• •••• 1042',
                    expiry: '09/27',
                    isDark: isDark,
=======
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/localization/locale_controller.dart';
import '../../authentication/controllers/auth_controller.dart';
import '../../authentication/views/login_view.dart';
import '../../settings/views/faq_view.dart';

/// [ProfileView] ekranı, kullanıcının hesap detaylarını, ehliyet durumunu,
/// sanal cüzdan bakiyesini, tema ve dil tercihlerini yönettiği profil sayfasıdır.
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int _virtualBalance = 50000;

  /// Sanal bakiye ekleme simülasyonu
  void _addBalanceDialog() {
    final amountController = TextEditingController(text: '5000');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sanal Bakiye Ekle'),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Miktar (₺)',
            prefixIcon: Icon(Icons.account_balance_wallet_outlined),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              final added = int.tryParse(amountController.text) ?? 0;
              if (added > 0) {
                setState(() {
                  _virtualBalance += added;
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$added ₺ sanal bakiye başarıyla yüklendi!'),
                    backgroundColor: AppColors.success,
                  ),
                );
              }
            },
            child: const Text('Yükle'),
          ),
        ],
      ),
    );
  }

  /// Canlı Destek simülasyonu
  void _openSupportDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.headset_mic_rounded, color: AppColors.primary),
            SizedBox(width: 8),
            Text('7/24 AraÇek Destek'),
          ],
        ),
        content: const Text(
          'Müşteri temsilcimize 0850 444 00 24 numarasından veya canlı chat üzerinden 7/24 ulaşabilirsiniz.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Anladım'),
          ),
        ],
      ),
    );
  }

  /// Çıkış yapma işlemi
  void _logout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Çıkış Yap'),
        content: const Text('Oturumunuzu kapatmak istediğinize emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Vazgeç'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () {
              Navigator.pop(ctx);
              AuthController.instance.logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginView()),
                (route) => false,
              );
            },
            child: const Text('Çıkış Yap', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthController.instance.currentUser;
    final isDark = ThemeController.instance.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hesabım & Profil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. Kullanıcı Başlık Kartı
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
                      child: ClipOval(
                        child: Image.asset(AppAssets.appLogo, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                currentUser.fullName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.verified_rounded, size: 18, color: AppColors.primary),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            currentUser.email,
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withAlpha(35),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${currentUser.memberLevel} • ${currentUser.licenseYears} Yıllık Ehliyet',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. Sanal Cüzdan Kartı
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF023E8A), Color(0xFF0077B6), Color(0xFF00B4D8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0077B6).withAlpha(80),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'AraÇek Sanal Cüzdan',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_card_rounded, color: Colors.white),
                        tooltip: 'Para Ekle',
                        onPressed: _addBalanceDialog,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_virtualBalance ₺',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '•••• •••• •••• 9812 | Ahmet Yılmaz',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
                  ),
                ],
              ),
            ),
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required bool isDark,
    bool isWarning = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 22,
            color: isWarning ? AppColors.warning : AppColors.primary,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardItem({
    required String cardTitle,
    required String cardNumber,
    required String expiry,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.credit_card, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardTitle,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  '$cardNumber • Son Kullanma: $expiry',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle_outline,
              size: 20, color: AppColors.success),
        ],
=======
>>>>>>> Stashed changes
            const SizedBox(height: 20),

            // 3. Ayarlar ve Seçenekler Listesi
            Card(
              child: Column(
                children: [
                  // Karanlık / Aydınlık Mod Geçişi
                  ListTile(
                    leading: Icon(
                      isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      color: AppColors.primary,
                    ),
                    title: const Text('Karanlık Mod'),
                    subtitle: Text(isDark ? 'Koyu tema aktif' : 'Aydınlık tema aktif'),
                    trailing: Switch(
                      value: isDark,
                      activeThumbColor: AppColors.primary,
                      onChanged: (val) {
                        setState(() {
                          ThemeController.instance.toggleTheme();
                        });
                      },
                    ),
                  ),
                  const Divider(indent: 16, endIndent: 16),

                  // Uygulama Dili
                  ListTile(
                    leading: const Icon(Icons.language_rounded, color: AppColors.accent),
                    title: const Text('Uygulama Dili'),
                    subtitle: Text(LocaleController.instance.isTurkish ? 'Türkçe (TR)' : 'English (EN)'),
                    trailing: TextButton(
                      onPressed: () {
                        setState(() {
                          LocaleController.instance.toggleLocale();
                        });
                      },
                      child: Text(
                        LocaleController.instance.isTurkish ? 'Değiştir (EN)' : 'Change (TR)',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const Divider(indent: 16, endIndent: 16),

                  // Sıkça Sorulan Sorular
                  ListTile(
                    leading: const Icon(Icons.help_outline_rounded, color: AppColors.info),
                    title: const Text('Sıkça Sorulan Sorular (SSS)'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const FaqView()),
                      );
                    },
                  ),
                  const Divider(indent: 16, endIndent: 16),

                  // Canlı Destek
                  ListTile(
                    leading: const Icon(Icons.headset_mic_outlined, color: AppColors.success),
                    title: const Text('7/24 Canlı Destek'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: _openSupportDialog,
                  ),
                  const Divider(indent: 16, endIndent: 16),

                  // Çıkış Yap
                  ListTile(
                    leading: const Icon(Icons.logout_rounded, color: AppColors.error),
                    title: const Text(
                      'Oturumu Kapat',
                      style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w700),
                    ),
                    onTap: _logout,
                  ),
                ],
              ),
            ),
          ],
        ),
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
      ),
    );
  }
}
