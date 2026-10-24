<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: vehicle_model.dart
// Görev: AraÇek platformunda kiralanabilen araçların veri modelini ve örnek
// bellek içi (in-memory) araç kataloğunu tanımlar.
// Açıklama: Proje şartnamesi gereğince harici veritabanı veya API kullanılmaz;
// tüm araç özellikleri bu model üzerinden sağlanır.
// ==============================================================================

import 'package:flutter/material.dart';

/// [Vehicle] sınıfı, kiralık bir aracın tüm teknik, ticari ve görsel niteliklerini barındırır.
@immutable
class Vehicle {
  /// Benzersiz araç kimlik numarası (ID)
  final String id;

  /// Model adı (Örn: Model Y, 320i M Sport, Taycan)
  final String name;

  /// Araç üretici markası (Örn: Tesla, BMW, Porsche, Mercedes)
  final String brand;

  /// Kasa / Araç gövde türü (SUV, Sedan, Elektrikli, Spor, Hatchback)
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
  final String type;

  /// Vites türü (Otomatik veya Manuel)
  final String transmission;

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
  /// Yakıt / Tahrik türü (Elektrik, Benzin, Hibrit, Dizel)
  final String fuelType;

  /// Koltuk sayısı (Örn: 5 Kişilik)
  final int seats;

  /// Motor gücü veya beygir gücü (Örn: 300 HP, 450 HP)
  final String enginePower;

  /// Ortalama menzil veya depo menzili (Örn: 540 km, 850 km)
  final String range;

  /// Günlük kiralama bedeli (Türk Lirası cinsinden)
  final int dailyPrice;

  /// Kullanıcı memnuniyet puanı (1.0 - 5.0)
  final double rating;

  /// Gerçekleştirilen kiralama tur sayısı
  final int tripCount;

  /// Öne çıkan / popüler araç bayrağı
  final bool isPopular;

  /// Aracın yüksek çözünürlüklü görsel yolu (Asset veya Web URL)
  final String imageUrl;

  /// Aracın görseli veya temsil eden Material Icon verisi
  final IconData displayIcon;

  /// Kart ve detay ekranı için özel renk vurgusu
  final Color accentColor;

  /// Sabit kurucu metot
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
  const Vehicle({
    required this.id,
    required this.name,
    required this.brand,
    required this.type,
    required this.transmission,
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
    required this.fuelType,
    required this.seats,
    required this.enginePower,
    required this.range,
    required this.dailyPrice,
    required this.rating,
    required this.tripCount,
    required this.imageUrl,
    required this.displayIcon,
    this.isPopular = false,
    this.accentColor = const Color(0xFF00D2FF),
  });

  /// Marka ve model adını birleştiren pratik başlık getter'ı
  String get fullName => '$brand $name';
}

/// Bellek içi (in-memory) örnek zengin araç listesi
const List<Vehicle> sampleVehicles = [
  Vehicle(
    id: 'veh_1',
    name: 'Model Y Long Range',
    brand: 'Tesla',
    type: 'Elektrikli',
    transmission: 'Otomatik',
    fuelType: 'Elektrik',
    seats: 5,
    enginePower: '514 HP',
    range: '533 km',
    dailyPrice: 3200,
    rating: 4.95,
    tripCount: 84,
    imageUrl: 'assets/images/cars/tesla_model_y.jpg',
    isPopular: true,
    displayIcon: Icons.electric_car,
    accentColor: Color(0xFF00D2FF),
  ),
  Vehicle(
    id: 'veh_2',
    name: 'Taycan 4S Cross',
    brand: 'Porsche',
    type: 'Spor',
    transmission: 'Otomatik',
    fuelType: 'Elektrik',
    seats: 4,
    enginePower: '530 HP',
    range: '490 km',
    dailyPrice: 7500,
    rating: 4.98,
    tripCount: 42,
    imageUrl: 'assets/images/cars/porsche_taycan.jpg',
    isPopular: true,
    displayIcon: Icons.sports_motorsports,
    accentColor: Color(0xFFFF3366),
  ),
  Vehicle(
    id: 'veh_3',
    name: '320i M Sport',
    brand: 'BMW',
    type: 'Sedan',
    transmission: 'Otomatik',
    fuelType: 'Benzin',
    seats: 5,
    enginePower: '170 HP',
    range: '750 km',
    dailyPrice: 3800,
    rating: 4.88,
    tripCount: 112,
    imageUrl: 'assets/images/cars/bmw_320i.jpg',
    isPopular: true,
    displayIcon: Icons.directions_car,
    accentColor: Color(0xFF0066FF),
  ),
  Vehicle(
    id: 'veh_4',
    name: 'C200 4MATIC AMG',
    brand: 'Mercedes-Benz',
    type: 'Sedan',
    transmission: 'Otomatik',
    fuelType: 'Hibrit',
    seats: 5,
    enginePower: '204 HP',
    range: '820 km',
    dailyPrice: 4100,
    rating: 4.91,
    tripCount: 96,
    imageUrl: 'assets/images/cars/mercedes_c200.jpg',
    isPopular: false,
    displayIcon: Icons.directions_car_filled,
    accentColor: Color(0xFF6C5CE7),
  ),
  Vehicle(
    id: 'veh_5',
    name: 'XC90 Recharge Ultimate',
    brand: 'Volvo',
    type: 'SUV',
    transmission: 'Otomatik',
    fuelType: 'Hibrit',
    seats: 7,
    enginePower: '455 HP',
    range: '880 km',
    dailyPrice: 5200,
    rating: 4.94,
    tripCount: 65,
    imageUrl: 'assets/images/cars/volvo_xc90.jpg',
    isPopular: false,
    displayIcon: Icons.airport_shuttle,
    accentColor: Color(0xFF00B4D8),
  ),
  Vehicle(
    id: 'veh_6',
    name: 'Megane E-Tech Iconic',
    brand: 'Renault',
    type: 'Hatchback',
    transmission: 'Otomatik',
    fuelType: 'Elektrik',
    seats: 5,
    enginePower: '220 HP',
    range: '450 km',
    dailyPrice: 2100,
    rating: 4.79,
    tripCount: 130,
    imageUrl: 'assets/images/cars/renault_megane.jpg',
    isPopular: false,
    displayIcon: Icons.ev_station,
    accentColor: Color(0xFFFFB703),
  ),
  Vehicle(
    id: 'veh_7',
    name: 'Golf 8 R-Line',
    brand: 'Volkswagen',
    type: 'Hatchback',
    transmission: 'Manuel',
    fuelType: 'Benzin',
    seats: 5,
    enginePower: '150 HP',
    range: '780 km',
    dailyPrice: 1750,
    rating: 4.75,
    tripCount: 154,
    imageUrl: 'assets/images/cars/volkswagen_golf.jpg',
    isPopular: false,
    displayIcon: Icons.directions_car,
    accentColor: Color(0xFF10E775),
  ),
  Vehicle(
    id: 'veh_8',
    name: 'Tucson N Line',
    brand: 'Hyundai',
    type: 'SUV',
    transmission: 'Otomatik',
    fuelType: 'Benzin',
    seats: 5,
    enginePower: '180 HP',
    range: '710 km',
    dailyPrice: 2450,
    rating: 4.82,
    tripCount: 88,
    imageUrl: 'assets/images/cars/hyundai_tucson.jpg',
    isPopular: false,
    displayIcon: Icons.directions_car,
    accentColor: Color(0xFFE63946),
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
  ),
];
