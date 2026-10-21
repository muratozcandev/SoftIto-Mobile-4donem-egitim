import '../models/auxiliary_models.dart';

/// Futbol Sohbet Modülü demo mesaj havuzu ve yerel yanıt motoru
abstract class DemoChatMessages {
  static List<ChatMessage> getInitialMessages() {
    final now = DateTime.now();
    return [
      ChatMessage(
        id: 'msg_1',
        senderName: 'Futbol Gurmesi Bot',
        senderAvatar: '⚽',
        message: 'Selamlar beyler! Bu hafta Süper Lig\'de Beşiktaş\'ın serisi devam eder mi ne diyorsunuz?',
        timestamp: now.subtract(const Duration(minutes: 45)),
        isBot: true,
      ),
      ChatMessage(
        id: 'msg_2',
        senderName: 'İstatistikçi Bot',
        senderAvatar: '📊',
        message: 'İstatistiklere göre Beşiktaş iç sahada %85 topla oynama ve maç başına 2.4 gol ortalamasıyla oynuyor. Favori olmaları çok doğal.',
        timestamp: now.subtract(const Duration(minutes: 32)),
        isBot: true,
      ),
      ChatMessage(
        id: 'msg_3',
        senderName: 'Kupon Ustası Bot',
        senderAvatar: '🎯',
        message: 'Ben bugün kupona 2.5 Üst ve KG Var yazdım, kombine oranı 3.40 oldu. Simülasyon bülteni gayet keyifli!',
        timestamp: now.subtract(const Duration(minutes: 18)),
        isBot: true,
      ),
      ChatMessage(
        id: 'msg_4',
        senderName: 'Tribün Sesi Bot',
        senderAvatar: '📣',
        message: 'Premier Lig\'de bu akşam Londra derbisi var, oradan da sürpriz bir beraberlik çıkabilir.',
        timestamp: now.subtract(const Duration(minutes: 5)),
        isBot: true,
      ),
    ];
  }

  /// Kullanıcı mesajına yerel ve eğlenceli bot yanıtı üretir
  static ChatMessage generateBotReply(String userMessage) {
    final lower = userMessage.toLowerCase();
    String reply;
    String botName;
    String avatar;

    if (lower.contains('beşiktaş') || lower.contains('bjk') || lower.contains('lider')) {
      botName = 'Tribün Sesi Bot';
      avatar = '🦅';
      reply = 'Beşiktaş bu sezon ligi domine ediyor! 20 galibiyetle zirvedeler, maçları kupona yazarken hiç düşünmüyorum.';
    } else if (lower.contains('kupon') || lower.contains('oran') || lower.contains('tahmin') || lower.contains('tuttur')) {
      botName = 'Kupon Ustası Bot';
      avatar = '🎯';
      reply = 'Benim tavsiyem: 50 TL minimum bahisle 3 maçlık kombine yapıp 4.50 civarı çarpan yakalamak! Sepete bakmayı unutma.';
    } else if (lower.contains('galatasaray') || lower.contains('gs')) {
      botName = 'İstatistikçi Bot';
      avatar = '📊';
      reply = 'Galatasaray bu sezon simülasyon tablosunda 0 puanla son sırada! Toparlanmaları için büyük bir mucize gerekiyor.';
    } else if (lower.contains('gol') || lower.contains('üst') || lower.contains('alt')) {
      botName = 'Futbol Gurmesi Bot';
      avatar = '⚽';
      reply = 'Bundesliga ve Eredivisie maçlarında 2.5 Üst her zaman yüksek yüzdeyle geliyor. Bültendeki oranları incele derim!';
    } else if (lower.contains('merhaba') || lower.contains('selam') || lower.contains('naber')) {
      botName = 'Futbol Gurmesi Bot';
      avatar = '⚽';
      reply = 'Aleyküm selam dostum! Tutturdum futbol sohbetine hoş geldin. Bugün hangi maçlara kupon yapıyorsun?';
    } else {
      botName = 'Kupon Ustası Bot';
      avatar = '💡';
      reply = 'Güzel tespit! Simülasyon bültenindeki oranları takip edip riskleri dağıtmak her zaman en akıllıca stratejidir.';
    }

    return ChatMessage(
      id: 'bot_reply_${DateTime.now().millisecondsSinceEpoch}',
      senderName: botName,
      senderAvatar: avatar,
      message: reply,
      timestamp: DateTime.now(),
      isBot: true,
    );
  }
}
