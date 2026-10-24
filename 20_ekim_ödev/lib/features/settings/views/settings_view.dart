// ==============================================================================
// Dosya: settings_view.dart
// Görev: Uygulama ayarları ekranı (Açık/Koyu tema, Türkçe/İngilizce dil seçimi,
// SSS yardım sayfası ve oturum kapatma aksiyonu).
// Açıklama: ThemeController ve LocaleController ile doğrudan reaktif olarak haberleşir.
// ==============================================================================

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/localization/locale_controller.dart';
import '../../../core/theme/theme_controller.dart';
import '../../authentication/controllers/auth_controller.dart';
import 'faq_view.dart';

/// [SettingsView] widget'ı, tema ve dil tercihleri gibi sistem ayarlarını yönetir.
class SettingsView extends StatefulWidget {
  final VoidCallback onLogout;

  const SettingsView({super.key, required this.onLogout});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    final isEn = LocaleController.instance.isEnglish;
    final isDark = ThemeController.instance.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.navSettings(isEn)),
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
                  // Görünüm & Tema Ayarları
                  // -----------------------------------------------------------
                  Text(
                    isEn ? 'Appearance & Theme' : 'Görünüm ve Tema',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Card(
                    child: SwitchListTile(
                      secondary: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          isDark
                              ? Icons.nightlight_round_outlined
                              : Icons.wb_sunny_outlined,
                          color: AppColors.primary,
                        ),
                      ),
                      title: Text(
                        AppStrings.darkMode(isEn),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        isDark
                            ? (isEn ? 'Obsidian dark palette active' : 'Obsidyen koyu mod devrede')
                            : (isEn ? 'Clean light palette active' : 'Aydınlık mod devrede'),
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                      value: isDark,
                      activeThumbColor: AppColors.primary,
                      onChanged: (val) {
                        ThemeController.instance.toggleTheme();
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // -----------------------------------------------------------
                  // Dil Ayarları (Language Settings)
                  // -----------------------------------------------------------
                  Text(
                    AppStrings.language(isEn),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.language_rounded,
                              color: AppColors.primary),
                          title: const Text('Türkçe (TR)',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          trailing: !isEn
                              ? const Icon(Icons.check_circle_rounded,
                                  color: AppColors.primary)
                              : null,
                          onTap: () {
                            LocaleController.instance.setLocale('tr');
                            setState(() {});
                          },
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.language_rounded,
                              color: AppColors.primary),
                          title: const Text('English (EN)',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          trailing: isEn
                              ? const Icon(Icons.check_circle_rounded,
                                  color: AppColors.primary)
                              : null,
                          onTap: () {
                            LocaleController.instance.setLocale('en');
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // -----------------------------------------------------------
                  // Destek ve Yardım (FAQ)
                  // -----------------------------------------------------------
                  Text(
                    isEn ? 'Support & Legal' : 'Destek ve Bilgi',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Card(
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.help_outline_rounded,
                          color: AppColors.secondary,
                        ),
                      ),
                      title: Text(
                        AppStrings.helpFaq(isEn),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded,
                          size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FaqView(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // -----------------------------------------------------------
                  // AraÇek Hakkında Bilgi Kartı
                  // -----------------------------------------------------------
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              AppAssets.logo,
                              width: 44,
                              height: 44,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.car_rental, size: 40),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'AraÇek Mobil & Web',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Sürüm 1.0.0 • Material 3 • Flutter 3.47',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // -----------------------------------------------------------
                  // Oturumu Kapat Butonu
                  // -----------------------------------------------------------
                  OutlinedButton.icon(
                    onPressed: () {
                      AuthController.instance.logout();
                      widget.onLogout();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(Icons.logout_rounded, size: 18),
                    label: Text(
                      AppStrings.logout(isEn),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
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
