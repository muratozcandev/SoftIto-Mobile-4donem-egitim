import '../models/auxiliary_models.dart';

/// Demo bildirimler
abstract class DemoNotifications {
  static List<NotificationItem> getInitialNotifications() {
    return [
      NotificationItem(
        id: 'notif_welcome',
        title: 'Hoş Geldiniz! ⚽',
        message: 'Tutturdum Futbol Bahis Simülasyonuna hoş geldiniz. Hesabınıza 1.000 ₺ sanal demo bakiyesi tanımlandı.',
        date: DateTime.now().subtract(const Duration(hours: 1)),
        isRead: false,
        type: 'wallet',
      ),
      NotificationItem(
        id: 'notif_match',
        title: 'Günün Derbisi Yaklaşıyor 🔥',
        message: 'Süper Lig\'de haftanın maçı için özel simülasyon oranları bültende hazır. Kuponunu oluştur!',
        date: DateTime.now().subtract(const Duration(hours: 4)),
        isRead: false,
        type: 'match',
      ),
      NotificationItem(
        id: 'notif_coupon',
        title: 'Kupon İpucu 💡',
        message: 'Minimum bahis tutarı 50 ₺ dir. Birden fazla ligden maç seçerek kombine oranınızı katlayabilirsiniz.',
        date: DateTime.now().subtract(const Duration(hours: 12)),
        isRead: true,
        type: 'coupon',
      ),
      NotificationItem(
        id: 'notif_system',
        title: 'Sanal Bahis Hatırlatması 🛡️',
        message: 'Bu uygulama yalnızca eğitim ve simülasyon amaçlıdır. Gerçek para veya gerçek bahis içermez.',
        date: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
        type: 'system',
      ),
    ];
  }
}
