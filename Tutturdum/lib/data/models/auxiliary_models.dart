/// Bildirim öğesi modeli
class NotificationItem {
  final String id;
  final String title;
  final String message;
  final DateTime date;
  final bool isRead;
  final String type; // 'match', 'coupon', 'wallet', 'system'

  const NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    this.isRead = false,
    this.type = 'system',
  });

  NotificationItem copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? date,
    bool? isRead,
    String? type,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      date: date ?? this.date,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'date': date.toIso8601String(),
      'isRead': isRead,
      'type': type,
    };
  }

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      date: DateTime.parse(json['date'] as String),
      isRead: json['isRead'] as bool? ?? false,
      type: json['type'] as String? ?? 'system',
    );
  }
}

/// Futbol sohbet botu mesaj modeli
class ChatMessage {
  final String id;
  final String senderName;
  final String senderAvatar;
  final String message;
  final DateTime timestamp;
  final bool isBot;

  const ChatMessage({
    required this.id,
    required this.senderName,
    required this.senderAvatar,
    required this.message,
    required this.timestamp,
    required this.isBot,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderName': senderName,
      'senderAvatar': senderAvatar,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isBot': isBot,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      senderName: json['senderName'] as String,
      senderAvatar: json['senderAvatar'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isBot: json['isBot'] as bool? ?? true,
    );
  }
}

/// Günün bülteni futbol haber kartı modeli
class NewsItem {
  final String id;
  final String title;
  final String summary;
  final String category;
  final String date;
  final String badgeText;

  const NewsItem({
    required this.id,
    required this.title,
    required this.summary,
    required this.category,
    required this.date,
    required this.badgeText,
  });
}
