import 'package:flutter/foundation.dart';
import '../models/auxiliary_models.dart';
import '../demo/demo_notifications.dart';

/// Bildirimler Repository
class NotificationRepository {
  static final NotificationRepository instance = NotificationRepository._internal();
  NotificationRepository._internal();

  final ValueNotifier<List<NotificationItem>> notificationsNotifier =
      ValueNotifier<List<NotificationItem>>([]);

  List<NotificationItem> get notifications => notificationsNotifier.value;

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  void init() {
    notificationsNotifier.value = DemoNotifications.getInitialNotifications();
  }

  void markAsRead(String id) {
    final updated = notifications.map((n) {
      if (n.id == id) {
        return n.copyWith(isRead: true);
      }
      return n;
    }).toList();
    notificationsNotifier.value = updated;
  }

  void markAllAsRead() {
    final updated = notifications.map((n) => n.copyWith(isRead: true)).toList();
    notificationsNotifier.value = updated;
  }

  void addNotification(NotificationItem item) {
    final updated = List<NotificationItem>.from(notifications)..insert(0, item);
    notificationsNotifier.value = updated;
  }
}
