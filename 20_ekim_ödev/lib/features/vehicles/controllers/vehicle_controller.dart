<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: vehicle_controller.dart
// Görev: Araç listeleme, kategori filtreleme, arama, fiyata göre sıralama ve
// aktif kiralanan aracın durumunu reaktif olarak yönetir.
// Açıklama: ValueNotifier kullanarak arayüzde gereksiz sayfa yenilemeleri olmadan
// doğrudan filtrelenmiş verinin dinlenmesini sağlar.
// ==============================================================================

import 'package:flutter/material.dart';
import '../models/vehicle_model.dart';

/// [VehicleController] sınıfı, araç kataloğu ve filtreleme durumunu tek merkezden yönetir.
class VehicleController {
  // ---------------------------------------------------------------------------
  // Tekil Örnek (Singleton)
  // ---------------------------------------------------------------------------
  static final VehicleController instance = VehicleController._internal();

  VehicleController._internal() {
    // Başlangıçta örnek bir aktif kiralama tanımlanabilir (veya null bırakılabilir)
    activeRentalVehicleNotifier.value = sampleVehicles.first;
    activeRentalDaysLeftNotifier.value = 3;
  }

  // ---------------------------------------------------------------------------
  // Reaktif Filtreleme ve Arama Durumları
  // ---------------------------------------------------------------------------
  /// Seçilen araç gövde tipi ('Tümü', 'SUV', 'Sedan', 'Elektrikli', 'Spor', 'Hatchback')
  final ValueNotifier<String> selectedTypeNotifier =
      ValueNotifier<String>('Tümü');

  /// Seçilen vites tipi ('Tümü', 'Otomatik', 'Manuel')
  final ValueNotifier<String> selectedTransmissionNotifier =
      ValueNotifier<String>('Tümü');

  /// Arama kutusuna yazılan metin
  final ValueNotifier<String> searchQueryNotifier =
      ValueNotifier<String>('');

  /// Fiyat sıralama tercihi: true = Artan, false = Azalan, null = Varsayılan
  final ValueNotifier<bool?> sortPriceAscendingNotifier =
      ValueNotifier<bool?>(null);

  /// Aktif olarak kiralanmış araç (varsa ana sayfada kart olarak gösterilir)
  final ValueNotifier<Vehicle?> activeRentalVehicleNotifier =
      ValueNotifier<Vehicle?>(null);

  /// Aktif kiralama süresinden kalan gün sayısı
  final ValueNotifier<int> activeRentalDaysLeftNotifier =
      ValueNotifier<int>(0);

  // ---------------------------------------------------------------------------
  // Filtreleme ve Sıralama Mantığı
  // ---------------------------------------------------------------------------
  /// Uygulanan filtreler, arama kelimesi ve sıralama tercihine göre araç listesini hesaplar.
  List<Vehicle> get filteredVehicles {
    final typeFilter = selectedTypeNotifier.value;
    final transFilter = selectedTransmissionNotifier.value;
    final query = searchQueryNotifier.value.trim().toLowerCase();
    final sortAsc = sortPriceAscendingNotifier.value;

    // 1. Filtreleme aşaması
    var list = sampleVehicles.where((v) {
      // Gövde türü kontrolü
      final matchesType = (typeFilter == 'Tümü' ||
          typeFilter == 'All' ||
          v.type.toLowerCase() == typeFilter.toLowerCase());

      // Vites türü kontrolü
      final matchesTransmission = (transFilter == 'Tümü' ||
          transFilter == 'All' ||
          v.transmission.toLowerCase() == transFilter.toLowerCase());

      // Arama terimi kontrolü (Marka, model veya gövde tipinde arama)
      final matchesQuery = query.isEmpty ||
          v.brand.toLowerCase().contains(query) ||
          v.name.toLowerCase().contains(query) ||
          v.type.toLowerCase().contains(query);

      return matchesType && matchesTransmission && matchesQuery;
    }).toList();

    // 2. Sıralama aşaması (varsa)
    if (sortAsc != null) {
      list.sort((a, b) => sortAsc
          ? a.dailyPrice.compareTo(b.dailyPrice)
          : b.dailyPrice.compareTo(a.dailyPrice));
    }

    return list;
  }

  // ---------------------------------------------------------------------------
  // Durum Güncelleme Metotları
  // ---------------------------------------------------------------------------
  /// Araç türü filtresini günceller
  void setTypeFilter(String type) {
    selectedTypeNotifier.value = type;
  }

  /// Vites filtresini günceller
  void setTransmissionFilter(String transmission) {
    selectedTransmissionNotifier.value = transmission;
  }

  /// Arama sorgusunu günceller
  void setSearchQuery(String query) {
    searchQueryNotifier.value = query;
  }

  /// Fiyat sıralamasını değiştirir veya sıfırlar
  void togglePriceSort() {
    if (sortPriceAscendingNotifier.value == null) {
      sortPriceAscendingNotifier.value = true; // Artan
    } else if (sortPriceAscendingNotifier.value == true) {
      sortPriceAscendingNotifier.value = false; // Azalan
    } else {
      sortPriceAscendingNotifier.value = null; // Sıfırla
    }
  }

  /// Yeni bir aracı aktif kiralama olarak atar
  void setActiveRental(Vehicle vehicle, int days) {
    activeRentalVehicleNotifier.value = vehicle;
    activeRentalDaysLeftNotifier.value = days;
  }

  /// Aktif kiralanan aracı teslim eder ve kiralama durumunu sonlandırır
  void returnActiveVehicle() {
    activeRentalVehicleNotifier.value = null;
    activeRentalDaysLeftNotifier.value = 0;
=======
>>>>>>> Stashed changes
import 'package:flutter/foundation.dart';
import '../models/vehicle_model.dart';

/// Sıralama ölçütleri listesi
enum PriceSortOrder { none, lowToHigh, highToLow }

/// [VehicleController] sınıfı, araç listesini, filtreleme seçeneklerini
/// (kategori, vites tipi, arama metni ve fiyat sıralaması) reaktif olarak yönetir.
class VehicleController {
  // Singleton deseni
  VehicleController._internal();
  static final VehicleController instance = VehicleController._internal();

  /// Tüm araçların orijinal ana listesi
  final List<Vehicle> _allVehicles = List.from(sampleVehicles);

  /// Filtrelenmiş araç listesini arayüze sunan reaktif bildirim nesnesi
  final ValueNotifier<List<Vehicle>> filteredVehiclesNotifier =
      ValueNotifier<List<Vehicle>>(List.from(sampleVehicles));

  /// Seçili araç gövde kategorisi ('Tümü', 'Sedan', 'SUV', 'Elektrikli', 'Spor')
  final ValueNotifier<String> selectedCategoryNotifier =
      ValueNotifier<String>('Tümü');

  /// Seçili vites filtresi ('Tümü', 'Otomatik', 'Manuel')
  final ValueNotifier<String> selectedTransmissionNotifier =
      ValueNotifier<String>('Tümü');

  /// Seçili fiyat sıralama tercihi
  final ValueNotifier<PriceSortOrder> sortOrderNotifier =
      ValueNotifier<PriceSortOrder>(PriceSortOrder.none);

  /// Arama kutusuna yazılan metin
  String _searchQuery = '';

  /// Arama sorgusunu güncelleyen ve listeyi yeniden filtreleyen metod
  void setSearchQuery(String query) {
    _searchQuery = query.trim().toLowerCase();
    _applyFilters();
  }

  /// Kategori filtresini güncelleyen metod
  void selectCategory(String category) {
    selectedCategoryNotifier.value = category;
    _applyFilters();
  }

  /// Vites filtresini güncelleyen metod
  void selectTransmission(String transmission) {
    selectedTransmissionNotifier.value = transmission;
    _applyFilters();
  }

  /// Fiyat sıralamasını değiştiren metod
  void setSortOrder(PriceSortOrder sortOrder) {
    sortOrderNotifier.value = sortOrder;
    _applyFilters();
  }

  /// Tüm filtreleri (arama, kategori, vites ve sıralama) sırayla uygulayan iç mantık fonksiyonu
  void _applyFilters() {
    List<Vehicle> result = List.from(_allVehicles);

    // 1. Arama Filtresi (Marka veya model adına göre)
    if (_searchQuery.isNotEmpty) {
      result = result.where((vehicle) {
        final matchesName = vehicle.name.toLowerCase().contains(_searchQuery);
        final matchesBrand = vehicle.brand.toLowerCase().contains(_searchQuery);
        return matchesName || matchesBrand;
      }).toList();
    }

    // 2. Kategori Filtresi
    final category = selectedCategoryNotifier.value;
    if (category != 'Tümü') {
      result = result.where((v) => v.type == category).toList();
    }

    // 3. Vites Filtresi
    final transmission = selectedTransmissionNotifier.value;
    if (transmission != 'Tümü') {
      result = result.where((v) => v.transmission == transmission).toList();
    }

    // 4. Fiyat Sıralaması
    switch (sortOrderNotifier.value) {
      case PriceSortOrder.lowToHigh:
        result.sort((a, b) => a.dailyPrice.compareTo(b.dailyPrice));
        break;
      case PriceSortOrder.highToLow:
        result.sort((a, b) => b.dailyPrice.compareTo(a.dailyPrice));
        break;
      case PriceSortOrder.none:
        break;
    }

    // Değişikliği UI'a bildirmek için ValueNotifier değerini yenile
    filteredVehiclesNotifier.value = result;
  }

  /// Filtreleri varsayılana sıfırlayan metod
  void resetFilters() {
    _searchQuery = '';
    selectedCategoryNotifier.value = 'Tümü';
    selectedTransmissionNotifier.value = 'Tümü';
    sortOrderNotifier.value = PriceSortOrder.none;
    filteredVehiclesNotifier.value = List.from(_allVehicles);
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
  }
}
