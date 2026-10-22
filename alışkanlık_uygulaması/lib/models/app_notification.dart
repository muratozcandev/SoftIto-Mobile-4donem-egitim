import 'package:flutter/material.dart';

enum NotificationType {
  reminder,
  badge,
  cheer,
  advice,
}

class AppNotification {
  final String id;
  final String title;
  final String message;
  final String timeAgo;
  final bool isRead;
  final IconData icon;
  final Color color;
  final NotificationType type;

  const AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.timeAgo,
    this.isRead = false,
    required this.icon,
    required this.color,
    required this.type,
  });

  AppNotification copyWith({
    String? id,
    String? title,
    String? message,
    String? timeAgo,
    bool? isRead,
    IconData? icon,
    Color? color,
    NotificationType? type,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timeAgo: timeAgo ?? this.timeAgo,
      isRead: isRead ?? this.isRead,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      type: type ?? this.type,
    );
  }

  static List<AppNotification> getDefaultNotifications() {
    return [
      const AppNotification(
        id: 'notif_1',
        title: 'Akıllı Hatırlatıcı: Su Vakti 💧',
        message: 'Günlük su hedefinin %80\'ine ulaştın! 1 bardak daha içerek Su Ustası rozetini kazanabilirsin.',
        timeAgo: '15 dk önce',
        isRead: false,
        icon: Icons.water_drop_rounded,
        color: Color(0xFF06B6D4),
        type: NotificationType.reminder,
      ),
      const AppNotification(
        id: 'notif_2',
        title: 'Yapay Zekâ Önerisi: Akşam Yürüyüşü 🚶‍♂️',
        message: 'Bugün harika bir tempo yakaladın. 1.550 adım daha atarsan günlük 10.000 adım hedefin tamamlanıyor.',
        timeAgo: '1 saat önce',
        isRead: false,
        icon: Icons.directions_walk_rounded,
        color: Color(0xFF10B981),
        type: NotificationType.advice,
      ),
      const AppNotification(
        id: 'notif_3',
        title: 'Rozet Kilidi Açıldı! 🏆',
        message: 'Tebrikler! "İlk Adım" rozetini başarıyla kazandın ve profil vitrinine eklendi.',
        timeAgo: 'Dün',
        isRead: true,
        icon: Icons.military_tech_rounded,
        color: Color(0xFFEAB308),
        type: NotificationType.badge,
      ),
      const AppNotification(
        id: 'notif_4',
        title: 'Haftalık Motivasyon Sözü ✨',
        message: '"Büyük başarılar, her gün tekrarlanan küçük disiplinlerin toplamıdır."',
        timeAgo: '2 gün önce',
        isRead: true,
        icon: Icons.auto_awesome_rounded,
        color: Color(0xFF8B5CF6),
        type: NotificationType.cheer,
      ),
    ];
  }
}
