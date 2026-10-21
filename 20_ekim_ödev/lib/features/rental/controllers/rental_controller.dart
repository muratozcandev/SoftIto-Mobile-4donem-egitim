import 'package:flutter/foundation.dart';
import '../models/rental_order_model.dart';
import '../../vehicles/models/vehicle_model.dart';

/// [RentalController] sınıfı, kiralama gün süresi seçimini,
/// dinamik fiyat hesaplamalarını, aktif kiralamaları ve teslimat durumunu yönetir.
class RentalController {
  // Singleton deseni
  RentalController._internal() {
    // Başlangıçta örnek bir aktif kiralama eklenerek uygulamanın dolu görünmesi sağlanır
    _initDefaultRentals();
  }
  static final RentalController instance = RentalController._internal();

  /// Seçilen kiralama gün sayısını tutan bildirim (1 ile 31 gün arası)
  final ValueNotifier<int> rentalDaysNotifier = ValueNotifier<int>(3);

  /// Aktif kiralama siparişleri listesi
  final ValueNotifier<List<RentalOrder>> activeRentalsNotifier =
      ValueNotifier<List<RentalOrder>>([]);

  /// Geçmiş / Teslim edilmiş kiralamalar listesi
  final ValueNotifier<List<RentalOrder>> pastRentalsNotifier =
      ValueNotifier<List<RentalOrder>>([]);

  /// Başlangıçta bir adet aktif kiralama siparişi simüle eder
  void _initDefaultRentals() {
    final defaultVehicle = sampleVehicles.first;
    final defaultOrder = RentalOrder(
      id: 'RENT-7041',
      vehicle: defaultVehicle,
      days: 4,
      dailyPrice: defaultVehicle.dailyPrice,
      totalPrice: defaultVehicle.dailyPrice * 4,
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      endDate: DateTime.now().add(const Duration(days: 3)),
      location: 'İstanbul Havalimanı (IST) - Dış Hatlar',
      isCompleted: false,
    );
    activeRentalsNotifier.value = [defaultOrder];
  }

  /// Kiralama süresini 1 ile 31 gün arasında güncelleyen metod
  void setDays(int days) {
    if (days >= 1 && days <= 31) {
      rentalDaysNotifier.value = days;
    }
  }

  /// Gün sayısını bir artıran metod (Maksimum 31 gün)
  void incrementDays() {
    if (rentalDaysNotifier.value < 31) {
      rentalDaysNotifier.value++;
    }
  }

  /// Gün sayısını bir azaltan metod (Minimum 1 gün)
  void decrementDays() {
    if (rentalDaysNotifier.value > 1) {
      rentalDaysNotifier.value--;
    }
  }

  /// Günlük ücrete ve gün sayısına göre toplam tutarı hesaplar
  int calculateTotal(int dailyPrice, int days) {
    return dailyPrice * days;
  }

  /// Yeni bir kiralama işlemi oluşturan simülasyon fonksiyonu
  RentalOrder rentVehicle({
    required Vehicle vehicle,
    required int days,
    required String location,
  }) {
    final now = DateTime.now();
    final newOrder = RentalOrder(
      id: 'RENT-${now.millisecondsSinceEpoch.toString().substring(7)}',
      vehicle: vehicle,
      days: days,
      dailyPrice: vehicle.dailyPrice,
      totalPrice: calculateTotal(vehicle.dailyPrice, days),
      startDate: now,
      endDate: now.add(Duration(days: days)),
      location: location,
      isCompleted: false,
    );

    // Aktif kiralamalar listesine ekle
    final updatedList = List<RentalOrder>.from(activeRentalsNotifier.value)
      ..insert(0, newOrder);
    activeRentalsNotifier.value = updatedList;

    return newOrder;
  }

  /// Aracı teslim etme / iade etme aksiyonunu simüle eder
  void deliverVehicle(RentalOrder order) {
    order.isCompleted = true;

    // Aktif kiralamalardan çıkar
    final updatedActive = List<RentalOrder>.from(activeRentalsNotifier.value)
      ..removeWhere((item) => item.id == order.id);
    activeRentalsNotifier.value = updatedActive;

    // Geçmiş kiralamalara ekle
    final updatedPast = List<RentalOrder>.from(pastRentalsNotifier.value)
      ..insert(0, order);
    pastRentalsNotifier.value = updatedPast;
  }
}
