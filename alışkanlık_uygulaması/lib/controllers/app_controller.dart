import 'package:flutter/material.dart';
import '../models/habit_goal.dart';
import '../models/badge_item.dart';
import '../models/app_notification.dart';

class AppController extends ChangeNotifier {
  static final AppController instance = AppController._internal();
  AppController._internal() {
    _habits = HabitGoal.getDefaultHabits();
    _badges = BadgeItem.getDefaultBadges();
    _notifications = AppNotification.getDefaultNotifications();
  }

  late List<HabitGoal> _habits;
  late List<BadgeItem> _badges;
  late List<AppNotification> _notifications;
  DateTime _selectedCalendarDate = DateTime.now();

  List<HabitGoal> get habits => List.unmodifiable(_habits);
  List<BadgeItem> get badges => List.unmodifiable(_badges);
  List<AppNotification> get notifications => List.unmodifiable(_notifications);
  DateTime get selectedCalendarDate => _selectedCalendarDate;

  int get unreadNotificationCount =>
      _notifications.where((n) => !n.isRead).length;

  int get unlockedBadgeCount =>
      _badges.where((b) => b.isUnlocked).length;

  double get overallCompletionRate {
    if (_habits.isEmpty) return 0.0;
    final totalPercentage =
        _habits.fold<double>(0.0, (sum, habit) => sum + habit.percentage);
    return (totalPercentage / _habits.length).clamp(0.0, 100.0);
  }

  void setSelectedDate(DateTime date) {
    _selectedCalendarDate = date;
    notifyListeners();
  }

  /// Hedef veya gerçekleşen değerleri güncelleme
  /// Negatif değerler sıfıra çekilir (hatalı veri engelleme)
  bool updateHabit({
    required String id,
    double? newTarget,
    double? newCurrent,
  }) {
    final index = _habits.indexWhere((h) => h.id == id);
    if (index == -1) return false;

    final habit = _habits[index];
    final validatedTarget = (newTarget != null && newTarget >= 0)
        ? newTarget
        : habit.targetValue;
    final validatedCurrent = (newCurrent != null && newCurrent >= 0)
        ? newCurrent
        : habit.currentValue;

    final updatedHabit = habit.copyWith(
      targetValue: validatedTarget,
      currentValue: validatedCurrent,
    );

    _habits[index] = updatedHabit;

    // Hedef %100 veya üzerine çıktığında rozet kontrolü
    if (updatedHabit.isCompleted) {
      _checkAndAwardBadge(updatedHabit);
    }

    notifyListeners();
    return true;
  }

  /// Hızlı değer ekleme (örneğin +250 ml su, +500 adım)
  void quickAddValue(String id, double delta) {
    if (delta <= 0) return;
    final habit = _habits.firstWhere((h) => h.id == id);
    final newCurrent = habit.currentValue + delta;
    updateHabit(id: id, newCurrent: newCurrent);
  }

  /// Rozet kazanım kontrolü
  void _checkAndAwardBadge(HabitGoal completedHabit) {
    final badgeIndex = _badges.indexWhere(
      (b) => b.targetCategory == completedHabit.category,
    );

    if (badgeIndex != -1) {
      final badge = _badges[badgeIndex];
      // Aynı rozet daha önce verilmemişse kilidi aç
      if (!badge.isUnlocked) {
        _badges[badgeIndex] = badge.copyWith(
          isUnlocked: true,
          unlockedAt: DateTime.now(),
        );

        // Bildirim oluştur
        _notifications.insert(
          0,
          AppNotification(
            id: 'badge_${badge.id}_${DateTime.now().millisecondsSinceEpoch}',
            title: 'Yeni Rozet Kazanıldı! 🎖️',
            message: 'Tebrikler! "${completedHabit.title}" hedefini %100 tamamlayarak "${badge.title}" rozetini kazandın!',
            timeAgo: 'Şimdi',
            isRead: false,
            icon: Icons.emoji_events_rounded,
            color: badge.color,
            type: NotificationType.badge,
          ),
        );
      }
    }
  }

  void markNotificationAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1 && !_notifications[index].isRead) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void markAllNotificationsAsRead() {
    _notifications = _notifications
        .map((n) => n.copyWith(isRead: true))
        .toList();
    notifyListeners();
  }

  void clearAllNotifications() {
    _notifications.clear();
    notifyListeners();
  }
}
