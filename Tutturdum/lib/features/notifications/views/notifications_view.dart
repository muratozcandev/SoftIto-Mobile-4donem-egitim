import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../data/models/auxiliary_models.dart';
import '../../../data/repositories/notification_repository.dart';

/// Bildirimler Ekranı
class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final repo = NotificationRepository.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildirimler'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: 'Tümünü Okundu İşaretle',
            onPressed: () {
              repo.markAllAsRead();
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<List<NotificationItem>>(
        valueListenable: repo.notificationsNotifier,
        builder: (context, notifications, _) {
          if (notifications.isEmpty) {
            return const EmptyState(
              icon: Icons.notifications_none,
              title: 'Bildirim Yok',
              message: 'Şu anda gösterilecek yeni bir bildirim bulunmuyor.',
            );
          }

          final dateFormat = DateFormat('dd.MM.yyyy HH:mm');

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notif = notifications[index];
              IconData icon = Icons.info_outline;
              Color iconColor = isDark ? AppColors.darkSecondaryAccent : AppColors.lightSecondaryAccent;

              if (notif.type == 'wallet') {
                icon = Icons.account_balance_wallet_outlined;
                iconColor = isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent;
              } else if (notif.type == 'match') {
                icon = Icons.sports_soccer;
                iconColor = AppColors.gold;
              } else if (notif.type == 'coupon') {
                icon = Icons.receipt_long;
                iconColor = Colors.purpleAccent;
              }

              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    repo.markAsRead(notif.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Simge
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: iconColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(icon, color: iconColor, size: 22),
                        ),
                        const SizedBox(width: 14),

                        // Metin İçeriği
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      notif.title,
                                      style: TextStyle(
                                        fontWeight: notif.isRead ? FontWeight.w600 : FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  if (!notif.isRead)
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: AppColors.darkPrimaryAccent,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notif.message,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: theme.textTheme.bodyMedium?.color,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                dateFormat.format(notif.date),
                                style: const TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
