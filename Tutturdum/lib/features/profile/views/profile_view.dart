import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../data/repositories/user_repository.dart';
import '../../auth/views/login_view.dart';
import '../../wallet/views/card_info_view.dart';

/// Profil ve Ayarlar Ekranı
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final user = UserRepository.instance.currentUser;
    final themeController = ThemeController.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil ve Ayarlar'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Profil Başlık Kartı
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardSurface : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: (isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent)
                      .withValues(alpha: 0.2),
                  child: Icon(
                    Icons.person,
                    size: 34,
                    color: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.fullName ?? 'Ahmet Yılmaz (Demo)',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? 'demo@tutturdum.com',
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'DEMO HESAP',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.gold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Hesap Detayları Kartı
          Card(
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.badge_outlined),
                  title: const Text('TC Kimlik No'),
                  subtitle: Text(user?.maskedTcNo ?? '123*****901'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.phone_outlined),
                  title: const Text('Telefon Numarası'),
                  subtitle: Text(user?.maskedPhone ?? '0555*** **67'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // İşlemler ve Ayarlar
          Card(
            elevation: 0,
            child: Column(
              children: [
                // Kart Bilgileri
                ListTile(
                  leading: const Icon(Icons.credit_card),
                  title: const Text('Kart Bilgileri & Bakiye'),
                  subtitle: const Text('Sanal bakiye yükleme simülasyonu'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const CardInfoView()),
                    );
                  },
                ),
                const Divider(height: 1),

                // Tema Seçimi
                ListTile(
                  leading: const Icon(Icons.palette_outlined),
                  title: const Text('Görsel Tema'),
                  subtitle: AnimatedBuilder(
                    animation: themeController,
                    builder: (context, _) {
                      String label = 'Koyu Tema (Football Night)';
                      if (themeController.themeMode == ThemeMode.light) {
                        label = 'Açık Tema (Stadium Light)';
                      } else if (themeController.themeMode == ThemeMode.system) {
                        label = 'Sistem Varsayılanı';
                      }
                      return Text(label);
                    },
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showThemeDialog(context, themeController);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Oturumu Kapat
          OutlinedButton.icon(
            onPressed: () async {
              await UserRepository.instance.logout();
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginView()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            label: const Text('Oturumu Kapat', style: TextStyle(color: Colors.redAccent)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.redAccent),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showThemeDialog(BuildContext context, ThemeController controller) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Tema Seçimi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Koyu Tema (Football Night)'),
                trailing: controller.themeMode == ThemeMode.dark ? const Icon(Icons.check, color: AppColors.darkPrimaryAccent) : null,
                onTap: () {
                  controller.setThemeMode(ThemeMode.dark);
                  Navigator.of(ctx).pop();
                },
              ),
              ListTile(
                title: const Text('Açık Tema (Stadium Light)'),
                trailing: controller.themeMode == ThemeMode.light ? const Icon(Icons.check, color: AppColors.lightPrimaryAccent) : null,
                onTap: () {
                  controller.setThemeMode(ThemeMode.light);
                  Navigator.of(ctx).pop();
                },
              ),
              ListTile(
                title: const Text('Sistem Varsayılanı'),
                trailing: controller.themeMode == ThemeMode.system ? const Icon(Icons.check) : null,
                onTap: () {
                  controller.setThemeMode(ThemeMode.system);
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
