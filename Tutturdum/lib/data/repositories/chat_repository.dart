import 'package:flutter/foundation.dart';
import '../models/auxiliary_models.dart';
import '../demo/demo_chat_messages.dart';

/// Futbol Sohbeti Repository
class ChatRepository {
  static final ChatRepository instance = ChatRepository._internal();
  ChatRepository._internal();

  final ValueNotifier<List<ChatMessage>> messagesNotifier =
      ValueNotifier<List<ChatMessage>>([]);

  List<ChatMessage> get messages => messagesNotifier.value;

  void init() {
    messagesNotifier.value = DemoChatMessages.getInitialMessages();
  }

  /// Kullanıcı mesajı gönderir ve otomatik bot yanıtı simüle eder
  Future<void> sendMessage({required String senderName, required String message}) async {
    final userMsg = ChatMessage(
      id: 'user_msg_${DateTime.now().millisecondsSinceEpoch}',
      senderName: senderName,
      senderAvatar: '👤',
      message: message.trim(),
      timestamp: DateTime.now(),
      isBot: false,
    );

    // Kullanıcı mesajını ekle
    messagesNotifier.value = List<ChatMessage>.from(messages)..add(userMsg);

    // Kısa bir gecikmeyle bot yanıtı simüle et
    await Future.delayed(const Duration(milliseconds: 600));
    final botReply = DemoChatMessages.generateBotReply(message);
    messagesNotifier.value = List<ChatMessage>.from(messages)..add(botReply);
  }
}
