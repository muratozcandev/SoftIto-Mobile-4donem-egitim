<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: rental_controller.dart
// Görev: Kiralama süresi (1-31 gün), anlık toplam ücret hesabı, kasko seçeneği,
// indirim kuponu ve simüle edilmiş ödeme sürecini yönetir.
// Açıklama: Proje ve skill kılavuzuna birebir uygun şekilde ValueNotifier ile
// reaktif olarak çalışır; harici sunucu veya gerçek kart işlemi yapmaz.
// ==============================================================================

import 'package:flutter/material.dart';
import '../../vehicles/models/vehicle_model.dart';
import '../../vehicles/controllers/vehicle_controller.dart';

/// [RentalController] sınıfı, araç kiralama rezervasyonu ve ödeme hesaplamalarını yönetir.
class RentalController {
  /// Kiralanmak istenen araç
  final Vehicle vehicle;

  // ---------------------------------------------------------------------------
  // Reaktif Durum Değişkenleri
  // ---------------------------------------------------------------------------
  /// Kiralama gün sayısı (Kılavuza göre 1 ile 31 gün arasında sınırlandırılmıştır)
  final ValueNotifier<int> daysNotifier = ValueNotifier<int>(3);

  /// Tam kasko ve yol yardım güvencesinin eklenip eklenmediği
  final ValueNotifier<bool> insuranceNotifier = ValueNotifier<bool>(true);

  /// Uygulanan indirim yüzdesi (Kupon kodu ile %15 veya %20)
  final ValueNotifier<int> discountPercentNotifier = ValueNotifier<int>(0);

  /// Uygulanan aktif kupon kodu
  final ValueNotifier<String?> appliedCouponNotifier =
      ValueNotifier<String?>(null);

  /// Kiralama işleminin tamamlanıp tamamlanmadığını belirten bayrak
  final ValueNotifier<bool> isCompletedNotifier = ValueNotifier<bool>(false);

  RentalController({required this.vehicle});

  // ---------------------------------------------------------------------------
  // Fiyat Hesaplama Mantığı
  // ---------------------------------------------------------------------------
  /// Günlük kasko ve güvence paketi bedeli (Sabit 250 TL/gün)
  static const int dailyInsurancePrice = 250;

  /// Ham araç kiralama bedeli (Gün x Günlük Ücret)
  int get rawRentalPrice => vehicle.dailyPrice * daysNotifier.value;

  /// Toplam kasko bedeli
  int get totalInsurancePrice =>
      insuranceNotifier.value ? dailyInsurancePrice * daysNotifier.value : 0;

  /// İndirim tutarı
  int get discountAmount {
    final subtotal = rawRentalPrice + totalInsurancePrice;
    return (subtotal * discountPercentNotifier.value) ~/ 100;
  }

  /// Ödenecek nihai toplam tutar (Anlık hesaplanır)
  int get totalPrice {
    final subtotal = rawRentalPrice + totalInsurancePrice;
    return subtotal - discountAmount;
  }

  // ---------------------------------------------------------------------------
  // Süre Değiştirme Metotları (1 - 31 Gün Sınırı)
  // ---------------------------------------------------------------------------
  /// Gün sayısını belirli bir değere ayarlar (1-31 aralığı kontrolü ile)
  void setDays(int value) {
    if (value < 1) {
      daysNotifier.value = 1;
    } else if (value > 31) {
      daysNotifier.value = 31;
    } else {
      daysNotifier.value = value;
    }
  }

  /// Gün sayısını 1 arttırır (Maksimum 31)
  void incrementDays() {
    if (daysNotifier.value < 31) {
      daysNotifier.value++;
    }
  }

  /// Gün sayısını 1 azaltır (Minimum 1)
  void decrementDays() {
    if (daysNotifier.value > 1) {
      daysNotifier.value--;
    }
  }

  /// Kasko tercihini açar/kapatır
  void toggleInsurance() {
    insuranceNotifier.value = !insuranceNotifier.value;
  }

  // ---------------------------------------------------------------------------
  // Kupon Kodu Uygulama
  // ---------------------------------------------------------------------------
  /// Örnek kupon kodlarını doğrular ('ARACEK15' veya 'SOFTITO')
  bool applyCoupon(String code) {
    final trimmed = code.trim().toUpperCase();
    if (trimmed == 'ARACEK15') {
      discountPercentNotifier.value = 15;
      appliedCouponNotifier.value = trimmed;
      return true;
    } else if (trimmed == 'SOFTITO') {
      discountPercentNotifier.value = 20;
      appliedCouponNotifier.value = trimmed;
      return true;
    }
    return false;
  }

  // ---------------------------------------------------------------------------
  // Kiralama Onay Simülasyonu
  // ---------------------------------------------------------------------------
  /// Ödemeyi onaylar, aracı ana sayfadaki aktif kiralama listesine ekler
  void completeRental() {
    isCompletedNotifier.value = true;
    VehicleController.instance.setActiveRental(vehicle, daysNotifier.value);
  }

  /// Kaynak temizliği
  void dispose() {
    daysNotifier.dispose();
    insuranceNotifier.dispose();
    discountPercentNotifier.dispose();
    appliedCouponNotifier.dispose();
    isCompletedNotifier.dispose();
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
  }
}
