import '../../vehicles/models/vehicle_model.dart';

/// [RentalOrder] sınıfı, kullanıcının kiraladığı aracı, kiralama süresini,
/// toplam tutarını ve teslimat durumunu tutan veri modelidir.
class RentalOrder {
  /// Sipariş / Kiralama numarası (Örn: RENT-1042)
  final String id;

  /// Kiralanan aracın detaylı nesnesi
  final Vehicle vehicle;

  /// Kiralama süresi (1 ile 31 gün arası)
  final int days;

  /// Kiralama tarihindeki günlük ücret
  final int dailyPrice;

  /// Hesaplanmış toplam kira bedeli (gün * günlük ücret)
  final int totalPrice;

  /// Kiralama başlangıç tarihi
  final DateTime startDate;

  /// Kiralama bitiş / teslimat tarihi
  final DateTime endDate;

  /// Teslim alınacak veya bırakılacak lokasyon (Örn: İstanbul Havalimanı)
  final String location;

  /// Kiralama aktif mi, yoksa teslim edildi mi?
  bool isCompleted;

  /// Kurucu metod: Kiralama bilgilerini başlatır
  RentalOrder({
    required this.id,
    required this.vehicle,
    required this.days,
    required this.dailyPrice,
    required this.totalPrice,
    required this.startDate,
    required this.endDate,
    required this.location,
    this.isCompleted = false,
  });

  /// Kalan gün sayısını hesaplayan dinamik getter
  int get remainingDays {
    final now = DateTime.now();
    final difference = endDate.difference(now).inDays;
    return difference > 0 ? difference : 1;
  }
}
