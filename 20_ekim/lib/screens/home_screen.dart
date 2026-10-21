import 'package:flutter/material.dart';
import '../controllers/app_controller.dart';
import '../core/constants/app_colors.dart';
import '../core/theme/theme_controller.dart';
import '../models/business_idea_model.dart';
import '../models/user_model.dart';
import '../widgets/balance_card.dart';
import '../widgets/business_card.dart';
import 'add_money_screen.dart';
import 'business_detail_screen.dart';
import 'investments_screen.dart';
import 'my_ideas_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'transfer_screen.dart';
import 'wallet_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'Tümü';

  final List<String> _categories = [
    'Tümü',
    'AgriTech & IoT',
    'Lojistik & Çevre',
    'HealthTech & AI',
    'EdTech & Gamification',
    'CleanTech & Sürdürülebilirlik',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: ValueListenableBuilder<UserModel?>(
          valueListenable: AppController.instance.currentUser,
          builder: (context, user, _) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
              borderRadius: BorderRadius.circular(30),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: isDark
                          ? AppColors.primaryMint.withOpacity(0.2)
                          : AppColors.primaryEmerald.withOpacity(0.15),
                      child: Text(
                        user?.avatarInitials ?? 'G',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.primaryMint
                              : AppColors.primaryEmerald,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          user?.name ?? 'Girişimci',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.3,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                          ),
                        ),
                        Text(
                          'Profil ve Ayarlar',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? AppColors.darkTextMuted
                                : AppColors.lightTextMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        actions: [
          // Koyu / Açık Tema Değiştirme Butonu
          IconButton(
            onPressed: () => ThemeController.instance.toggleTheme(),
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: isDark ? AppColors.primaryMint : AppColors.primaryEmerald,
            ),
            tooltip: 'Temayı Değiştir',
          ),
          // Ayarlar Butonu
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
            icon: Icon(
              Icons.settings_outlined,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
            tooltip: 'Ayarlar',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Kategori Filtreleri
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = cat == _selectedCategory;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected
                          ? (isDark ? AppColors.darkBackground : Colors.white)
                          : (isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary),
                    ),
                    selectedColor: isDark
                        ? AppColors.primaryMint
                        : AppColors.primaryEmerald,
                    backgroundColor: isDark
                        ? AppColors.darkCard
                        : AppColors.lightCard,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isSelected
                            ? Colors.transparent
                            : (isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder),
                      ),
                    ),
                    onSelected: (val) {
                      setState(() {
                        _selectedCategory = cat;
                      });
                    },
                  );
                },
              ),
            ),

            // Orta Alan: İş Fikirleri Listesi
            Expanded(
              child: ValueListenableBuilder<List<BusinessIdeaModel>>(
                valueListenable: AppController.instance.businessIdeas,
                builder: (context, ideas, _) {
                  final filteredIdeas = _selectedCategory == 'Tümü'
                      ? ideas
                      : ideas
                          .where((i) => i.category == _selectedCategory)
                          .toList();

                  if (filteredIdeas.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lightbulb_outline_rounded,
                            size: 48,
                            color: isDark
                                ? AppColors.darkTextMuted
                                : AppColors.lightTextMuted,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Bu kategoride henüz iş fikri yok',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                    itemCount: filteredIdeas.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final idea = filteredIdeas[index];
                      return BusinessCard(
                        idea: idea,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  BusinessDetailScreen(idea: idea),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),

            // Alt Alan: Sol Alt Sanal Bakiye + Sağ Alt Portföy & Fikirler Butonları
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightCard,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                border: Border(
                  top: BorderSide(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    width: 1,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tıklanabilir Bakiye Kartı (Sol Alt / Merkez)
                  BalanceCard(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const WalletScreen(),
                        ),
                      );
                    },
                    onAddMoneyTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const AddMoneyScreen(),
                        ),
                      );
                    },
                    onTransferTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const TransferScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  // Sağ Alt Kısım: Yatırımlarım & Kendi İş Fikirlerim Hızlı Erişim
                  Row(
                    children: [
                      // Yatırımlarım Butonu
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const InvestmentsScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.pie_chart_outline_rounded, size: 18),
                          label: ValueListenableBuilder(
                            valueListenable: AppController.instance.investments,
                            builder: (context, invs, _) {
                              return Text(
                                'Yatırımlarım (${invs.length})',
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Kendi İş Fikirlerim Butonu
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const MyIdeasScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add_task_rounded, size: 18),
                          label: const Text(
                            'İş Fikirlerim',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
