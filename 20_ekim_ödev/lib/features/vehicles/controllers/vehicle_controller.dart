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
  }
}
