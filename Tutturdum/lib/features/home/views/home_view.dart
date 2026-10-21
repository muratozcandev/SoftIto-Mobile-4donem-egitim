import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../data/demo/demo_matches.dart';
import '../../../data/demo/demo_news.dart';
import '../../../data/repositories/wallet_repository.dart';
import '../../../data/repositories/notification_repository.dart';
import '../widgets/featured_match_card.dart';
import '../widgets/news_card.dart';
import '../../wallet/views/card_info_view.dart';
import '../../notifications/views/notifications_view.dart';
import '../../profile/views/profile_view.dart';

/// Günün Bülteni Ana Sayfası
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final featuredMatches = DemoMatches.getFeaturedMatches();
    final newsList = DemoNews.news;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            icon: CircleAvatar(
              radius: 16,
              backgroundColor: (isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent)
                  .withValues(alpha: 0.2),
              child: const Icon(Icons.person, size: 20),
            ),
            tooltip: 'Profil ve Ayarlar',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProfileView()),
              );
            },
          ),
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/icons/app_icon.jpg',
              height: 28,
              width: 28,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.sports_soccer, size: 24),
            ),
            const SizedBox(width: 8),
            Text(
              'Tutturdum',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
        actions: [
          // Bildirimler Butonu & Okunmamış Rozeti
          ValueListenableBuilder(
            valueListenable: NotificationRepository.instance.notificationsNotifier,
            builder: (context, notifications, _) {
              final unread = NotificationRepository.instance.unreadCount;
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    tooltip: 'Bildirimler',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const NotificationsView()),
                      );
                    },
                  ),
                  if (unread > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.darkError,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$unread',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Yerel yenileme simülasyonu
          await Future.delayed(const Duration(milliseconds: 300));
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // Sanal Bakiye ve Hızlı Yükleme Kartı
            ValueListenableBuilder<double>(
              valueListenable: WalletRepository.instance.balanceNotifier,
              builder: (context, balance, _) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [
                              const Color(0xFF13221B),
                              const Color(0xFF19232D),
                            ]
                          : [
                              const Color(0xFFDCFCE7),
                              Colors.white,
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? AppColors.darkPrimaryAccent.withValues(alpha: 0.3) : AppColors.lightDivider,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Sanal Bakiye',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: theme.textTheme.bodyMedium?.color,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent)
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'DEMO',
                                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            CurrencyFormatter.format(balance),
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const CardInfoView()),
                          );
                        },
                        icon: const Icon(Icons.add_card, size: 18),
                        label: const Text('Bakiye Yükle'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Öne Çıkan Maçlar Başlığı
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('🔥', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Text(
                      'Günün Öne Çıkan Maçları',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  '${featuredMatches.length} Maç',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Maç Kartları
            ...featuredMatches.map((m) => FeaturedMatchCard(match: m)),

            const SizedBox(height: 16),

            // Futbol Haberleri Başlığı
            Row(
              children: [
                const Text('📰', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Text(
                  'Futbol Gündemi & Haberler',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Haber Kartları
            ...newsList.map((n) => NewsCard(news: n)),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
