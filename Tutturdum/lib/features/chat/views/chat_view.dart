import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/auxiliary_models.dart';
import '../../../data/repositories/chat_repository.dart';
import '../../../data/repositories/user_repository.dart';

/// Futbol Sohbet Modülü (Simülasyon Botları ile Sohbet)
class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _handleSend() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _messageController.clear();
    final user = UserRepository.instance.currentUser;
    final senderName = user?.fullName ?? 'Ahmet (Sen)';

    await ChatRepository.instance.sendMessage(
      senderName: senderName,
      message: text,
    );

    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final timeFormat = DateFormat('HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.forum_outlined, size: 22),
            SizedBox(width: 8),
            Text('Futbol Sohbet Odası'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Simülasyon Bilgilendirmesi
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            color: (isDark ? AppColors.darkCardSurface : const Color(0xFFE2E8F0)),
            child: const Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Yerel Bot Simülasyonu: Botlar yerel kural motoruyla yanıt verir, gerçek tavsiye niteliği taşımaz.',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

          // Mesajlar Listesi
          Expanded(
            child: ValueListenableBuilder<List<ChatMessage>>(
              valueListenable: ChatRepository.instance.messagesNotifier,
              builder: (context, messages, _) {
                WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = !msg.isBot;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment:
                            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isMe) ...[
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: (isDark
                                      ? AppColors.darkPrimaryAccent
                                      : AppColors.lightPrimaryAccent)
                                  .withValues(alpha: 0.2),
                              child: Text(msg.senderAvatar, style: const TextStyle(fontSize: 16)),
                            ),
                            const SizedBox(width: 8),
                          ],
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? (isDark
                                        ? AppColors.darkPrimaryAccent
                                        : AppColors.lightPrimaryAccent)
                                    : (isDark ? AppColors.darkCardSurface : Colors.white),
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(14),
                                  topRight: const Radius.circular(14),
                                  bottomLeft: Radius.circular(isMe ? 14 : 2),
                                  bottomRight: Radius.circular(isMe ? 2 : 14),
                                ),
                                border: isMe
                                    ? null
                                    : Border.all(
                                        color: isDark
                                            ? AppColors.darkDivider
                                            : AppColors.lightDivider,
                                      ),
                              ),
                              child: Column(
                                crossAxisAlignment: isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  if (!isMe) ...[
                                    Text(
                                      msg.senderName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: isDark
                                            ? AppColors.darkSecondaryAccent
                                            : AppColors.lightSecondaryAccent,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                  ],
                                  Text(
                                    msg.message,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isMe
                                          ? (isDark ? Colors.black : Colors.white)
                                          : (isDark
                                              ? AppColors.darkPrimaryText
                                              : AppColors.lightPrimaryText),
                                      height: 1.3,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    timeFormat.format(msg.timestamp),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isMe
                                          ? (isDark
                                              ? Colors.black54
                                              : Colors.white70)
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (isMe) ...[
                            const SizedBox(width: 8),
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.blueAccent.withValues(alpha: 0.2),
                              child: const Icon(Icons.person, size: 18, color: Colors.blueAccent),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Alt Mesaj Yazma Alanı
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardSurface : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                ),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _handleSend(),
                      decoration: const InputDecoration(
                        hintText: 'Futbol veya maçlar hakkında mesaj yazın...',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
                    ),
                    onPressed: _handleSend,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
