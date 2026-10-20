import 'package:flutter/foundation.dart';
import '../../../core/constants/app_assets.dart';

/// [Vehicle] sınıfı, kiralanabilir bir aracı tüm teknik ve görsel
/// özellikleriyle temsil eden değişmez (immutable) veri modelidir.
@immutable
class Vehicle {
  /// Benzersiz araç tanımlayıcısı (ID)
  final String id;

  /// Araç modeli adı (Örn: Model S, F-Pace, Clio)
  final String name;

  /// Araç markası (Örn: Tesla, Jaguar, Renault, Porsche)
  final String brand;

  /// Araç gövde/kategori tipi (Sedan, SUV, Spor, Elektrikli, Kompakt)
  final String type;

  /// Vites türü (Otomatik veya Manuel)
  final String transmission;

  /// Günlük kiralama bedeli (Türk Lirası cinsinden)
  final int dailyPrice;

  /// Araç görselinin yerel asset dosya yolu
  final String imagePath;

  /// Yakıt / Güç tipi (Elektrik, Benzin, Hibrit, Dizel)
  final String fuelType;

  /// Koltuk sayısı
  final int seats;

  /// Beygir gücü (HP)
  final int horsepower;

  /// 0-100 km/s hızlanma süresi (Saniye)
  final double acceleration;

  /// Tek depo veya şarj ile menzil (Kilometre cinsinden)
  final int rangeKm;

  /// Öne çıkan araç mı? (Ana sayfa vitrini için)
  final bool isFeatured;

  /// Kurucu metod: Tüm zorunlu araç parametrelerini başlatır
  const Vehicle({
    required this.id,
    required this.name,
    required this.brand,
    required this.type,
    required this.transmission,
    required this.dailyPrice,
    required this.imagePath,
    required this.fuelType,
    required this.seats,
    required this.horsepower,
    required this.acceleration,
    required this.rangeKm,
    this.isFeatured = false,
  });

  /// Marka ve model adını birleştiren pratik getter (Örn: "Tesla Model S Plaid")
  String get fullName => '$brand $name';
}

/// [sampleVehicles] listesi, backend veya veritabanı gerektirmeden
/// AraÇek uygulamasında gösterilmek üzere oluşturulmuş örnek araç veri setidir.
const List<Vehicle> sampleVehicles = [
  Vehicle(
    id: 'veh_01',
    brand: 'Tesla',
    name: 'Model S Plaid',
    type: 'Elektrikli',
    transmission: 'Otomatik',
    dailyPrice: 2850,
    imagePath: AppAssets.carSedan,
    fuelType: 'Elektrik',
    seats: 5,
    horsepower: 1020,
    acceleration: 2.1,
    rangeKm: 600,
    isFeatured: true,
  ),
  Vehicle(
    id: 'veh_02',
    brand: 'Jaguar',
    name: 'F-Pace SVR Carbon',
    type: 'SUV',
    transmission: 'Otomatik',
    dailyPrice: 2450,
    imagePath: AppAssets.carSuv,
    fuelType: 'Benzin',
    seats: 5,
    horsepower: 550,
    acceleration: 4.0,
    rangeKm: 680,
    isFeatured: true,
  ),
  Vehicle(
    id: 'veh_03',
    brand: 'Ferrari',
    name: '720S Spider Performance',
    type: 'Spor',
    transmission: 'Otomatik',
    dailyPrice: 4800,
    imagePath: AppAssets.carCoupe,
    fuelType: 'Benzin V8',
    seats: 2,
    horsepower: 720,
    acceleration: 2.8,
    rangeKm: 520,
    isFeatured: true,
  ),
  Vehicle(
    id: 'veh_04',
    brand: 'Volkswagen',
    name: 'ID.3 Neo Edition',
    type: 'Elektrikli',
    transmission: 'Otomatik',
    dailyPrice: 1450,
    imagePath: AppAssets.carHatchback,
    fuelType: 'Elektrik',
    seats: 5,
    horsepower: 204,
    acceleration: 7.3,
    rangeKm: 420,
    isFeatured: false,
  ),
  Vehicle(
    id: 'veh_05',
    brand: 'Renault',
    name: 'Clio V E-Tech',
    type: 'Sedan',
    transmission: 'Manuel',
    dailyPrice: 1150,
    imagePath: AppAssets.carHatchback,
    fuelType: 'Hibrit',
    seats: 5,
    horsepower: 140,
    acceleration: 9.9,
    rangeKm: 900,
    isFeatured: false,
  ),
  Vehicle(
    id: 'veh_06',
    brand: 'Porsche',
    name: 'Taycan 4S Cross',
    type: 'Spor',
    transmission: 'Otomatik',
    dailyPrice: 3800,
    imagePath: AppAssets.carSedan,
    fuelType: 'Elektrik',
    seats: 4,
    horsepower: 530,
    acceleration: 3.8,
    rangeKm: 512,
    isFeatured: false,
  ),
];
