<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: home_view.dart
// Görev: AraÇek uygulamasının ana sayfası.
// Açıklama: Karşılama başlığı, aktif kiralanan araç kartı, anlık arama,
// gövde tipi ve vites filtreleri, fiyata göre sıralama ve araç listesini barındırır.
// ==============================================================================

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/localization/locale_controller.dart';
import '../../authentication/controllers/auth_controller.dart';
import '../../vehicles/controllers/vehicle_controller.dart';
import '../../vehicles/models/vehicle_model.dart';
import '../../vehicles/views/vehicle_detail_view.dart';
import '../../vehicles/widgets/vehicle_card.dart';
import '../widgets/active_rental_card.dart';

/// [HomeView] widget'ı, ana vitrin ve araç keşif ekranıdır.
class HomeView extends StatefulWidget {
  /// Hasar/Teslimat sekmesine geçiş callback'i
  final VoidCallback onNavigateToDamageReport;

  const HomeView({super.key, required this.onNavigateToDamageReport});
=======
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/theme_controller.dart';
import '../../authentication/controllers/auth_controller.dart';
import '../../vehicles/controllers/vehicle_controller.dart';
import '../../vehicles/models/vehicle_model.dart';
import '../../vehicles/widgets/category_filter_bar.dart';
import '../../vehicles/widgets/vehicle_card.dart';
import '../widgets/active_rental_banner.dart';
import '../../damage_report/views/damage_report_view.dart';

/// [HomeView] ekranı, AraÇek uygulamasının ana keşif sayfasıdır.
/// Kullanıcı karşılama bilgisi, arama çubuğu, kategori ve sıralama filtreleri,
/// aktif kiralama panosu ve araç listesini barındırır.
class HomeView extends StatefulWidget {
  const HomeView({super.key});
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
<<<<<<< Updated upstream
  final TextEditingController _searchController = TextEditingController();
=======
<<<<<<< HEAD
  final _vehicleController = VehicleController.instance;
  final _searchController = TextEditingController();

  /// Desteklenen filtre kategorileri
  final List<String> _categories = [
    'Tümü',
    'SUV',
    'Sedan',
    'Elektrikli',
    'Spor',
    'Hatchback',
  ];

  /// Vites türleri
  final List<String> _transmissions = [
    'Tümü',
    'Otomatik',
    'Manuel',
  ];
=======
  final TextEditingController _searchController = TextEditingController();
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    final isEn = LocaleController.instance.isEnglish;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final userName = AuthController.instance.currentUserName;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // -----------------------------------------------------------
                  // Üst Profil Karşılama ve Konum Başlığı
                  // -----------------------------------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.welcomeGreeting(isEn, userName),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            AppStrings.welcomeSubtitle(isEn),
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                      // Konum Rozeti
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'İstanbul',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
=======
>>>>>>> Stashed changes
  /// Filtre ve sıralama modal penceresini açan fonksiyon
  void _openFilterModal(BuildContext context) {
    final isDark = ThemeController.instance.isDarkMode;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filtreleme & Sıralama',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Vites Türü',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              ValueListenableBuilder<String>(
                valueListenable:
                    VehicleController.instance.selectedTransmissionNotifier,
                builder: (context, currentTransmission, _) {
                  return Wrap(
                    spacing: 8,
                    children: ['Tümü', 'Otomatik', 'Manuel'].map((trans) {
                      final isSelected = currentTransmission == trans;
                      return ChoiceChip(
                        label: Text(trans),
                        selected: isSelected,
                        onSelected: (_) {
                          VehicleController.instance.selectTransmission(trans);
                          Navigator.pop(ctx);
                        },
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Fiyat Sıralaması',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              ValueListenableBuilder<PriceSortOrder>(
                valueListenable: VehicleController.instance.sortOrderNotifier,
                builder: (context, currentSort, _) {
                  return Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('Varsayılan'),
                        selected: currentSort == PriceSortOrder.none,
                        onSelected: (_) {
                          VehicleController.instance
                              .setSortOrder(PriceSortOrder.none);
                          Navigator.pop(ctx);
                        },
                      ),
                      ChoiceChip(
                        label: const Text('Fiyat: Artan'),
                        selected: currentSort == PriceSortOrder.lowToHigh,
                        onSelected: (_) {
                          VehicleController.instance
                              .setSortOrder(PriceSortOrder.lowToHigh);
                          Navigator.pop(ctx);
                        },
                      ),
                      ChoiceChip(
                        label: const Text('Fiyat: Azalan'),
                        selected: currentSort == PriceSortOrder.highToLow,
                        onSelected: (_) {
                          VehicleController.instance
                              .setSortOrder(PriceSortOrder.highToLow);
                          Navigator.pop(ctx);
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeController.instance.isDarkMode;
    final currentUser = AuthController.instance.currentUser;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 1. Üst Başlık ve Karşılama Alanı (Header)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Yuvarlak AraÇek Logosu
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primary, width: 1.5),
                          ),
                          child: ClipOval(
                            child: Image.asset(AppAssets.appLogo, fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Merhaba, ${currentUser.fullName}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const Text(
                              'AraÇek ile yolculuğunu başlat',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
                              ),
                            ),
                          ],
                        ),
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // -----------------------------------------------------------
                  // Aktif Kiralanan Araç Kartı (Varsa Gösterilir)
                  // -----------------------------------------------------------
                  ValueListenableBuilder<Vehicle?>(
                    valueListenable:
                        _vehicleController.activeRentalVehicleNotifier,
                    builder: (context, activeVehicle, _) {
                      if (activeVehicle == null) return const SizedBox.shrink();

                      return ValueListenableBuilder<int>(
                        valueListenable:
                            _vehicleController.activeRentalDaysLeftNotifier,
                        builder: (context, daysLeft, _) {
                          return ActiveRentalCard(
                            vehicle: activeVehicle,
                            daysLeft: daysLeft,
                            onReturnTap: widget.onNavigateToDamageReport,
                          );
                        },
                      );
                    },
                  ),

                  // -----------------------------------------------------------
                  // Arama Çubuğu
                  // -----------------------------------------------------------
                  TextField(
                    controller: _searchController,
                    onChanged: (val) {
                      _vehicleController.setSearchQuery(val);
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: AppStrings.searchHint(isEn),
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, size: 20),
                              onPressed: () {
                                _searchController.clear();
                                _vehicleController.setSearchQuery('');
                                setState(() {});
                              },
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // -----------------------------------------------------------
                  // Kategori Çipleri (Gövde Tipi Filtresi)
                  // -----------------------------------------------------------
                  SizedBox(
                    height: 40,
                    child: ValueListenableBuilder<String>(
                      valueListenable: _vehicleController.selectedTypeNotifier,
                      builder: (context, selectedType, _) {
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _categories.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final cat = _categories[index];
                            final isSelected = selectedType == cat;

                            return ChoiceChip(
                              label: Text(cat),
                              selected: isSelected,
                              onSelected: (_) {
                                _vehicleController.setTypeFilter(cat);
                                setState(() {});
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  // -----------------------------------------------------------
                  // Vites Seçimi ve Fiyat Sıralama Butonları
                  // -----------------------------------------------------------
                  Row(
                    children: [
                      // Vites Çipleri
                      Expanded(
                        child: ValueListenableBuilder<String>(
                          valueListenable:
                              _vehicleController.selectedTransmissionNotifier,
                          builder: (context, selectedTrans, _) {
                            return Wrap(
                              spacing: 8,
                              children: _transmissions.map((trans) {
                                final isSelected = selectedTrans == trans;
                                return FilterChip(
                                  label: Text(
                                    trans,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.normal,
                                    ),
                                  ),
                                  selected: isSelected,
                                  onSelected: (_) {
                                    _vehicleController
                                        .setTransmissionFilter(trans);
                                    setState(() {});
                                  },
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),

                      // Fiyat Sıralama Düğmesi
                      ValueListenableBuilder<bool?>(
                        valueListenable:
                            _vehicleController.sortPriceAscendingNotifier,
                        builder: (context, sortAsc, _) {
                          return OutlinedButton.icon(
                            onPressed: () {
                              _vehicleController.togglePriceSort();
                              setState(() {});
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              side: BorderSide(
                                color: sortAsc != null
                                    ? AppColors.primary
                                    : (isDark
                                        ? AppColors.darkBorder
                                        : AppColors.lightBorder),
                              ),
                            ),
                            icon: Icon(
                              sortAsc == null
                                  ? Icons.swap_vert_rounded
                                  : (sortAsc
                                      ? Icons.arrow_upward_rounded
                                      : Icons.arrow_downward_rounded),
                              size: 16,
                              color: sortAsc != null
                                  ? AppColors.primary
                                  : null,
                            ),
                            label: Text(
                              sortAsc == null
                                  ? (isEn ? 'Sort' : 'Fiyat')
                                  : (sortAsc
                                      ? AppStrings.sortPriceAsc(isEn)
                                      : AppStrings.sortPriceDesc(isEn)),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: sortAsc != null
                                    ? AppColors.primary
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // -----------------------------------------------------------
                  // Araç Listesi
                  // -----------------------------------------------------------
                  Builder(
                    builder: (context) {
                      final vehicles = _vehicleController.filteredVehicles;

                      if (vehicles.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.search_off_rounded,
                                  size: 48,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  isEn
                                      ? 'No vehicles found matching filters'
                                      : 'Filtrelere uygun araç bulunamadı',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return LayoutBuilder(
                        builder: (context, constraints) {
                          // Geniş ekranda 2 sütunlu grid, mobilde tek sütun
                          if (constraints.maxWidth > 580) {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.88,
                              ),
                              itemCount: vehicles.length,
                              itemBuilder: (context, index) {
                                final vehicle = vehicles[index];
                                return VehicleCard(
                                  vehicle: vehicle,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            VehicleDetailView(vehicle: vehicle),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          } else {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: vehicles.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 14),
                              itemBuilder: (context, index) {
                                final vehicle = vehicles[index];
                                return VehicleCard(
                                  vehicle: vehicle,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            VehicleDetailView(vehicle: vehicle),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
=======
>>>>>>> Stashed changes
                      ],
                    ),
                    // Hızlı Kamera / AraÇek Butonu
                    IconButton.filledTonal(
                      icon: const Icon(Icons.camera_alt_outlined, size: 20),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primary.withAlpha(30),
                        foregroundColor: AppColors.primary,
                      ),
                      tooltip: 'AraÇek Fotoğraf Çek',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const DamageReportView(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // 2. Arama ve Filtreleme Çubuğu
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Row(
                  children: [
                    // Arama Input Alanı
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) {
                          VehicleController.instance.setSearchQuery(val);
                        },
                        decoration: InputDecoration(
                          hintText: 'Araç markası veya modeli ara...',
                          prefixIcon: const Icon(Icons.search_rounded, size: 22),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 18),
                                  onPressed: () {
                                    _searchController.clear();
                                    VehicleController.instance.setSearchQuery('');
                                    setState(() {});
                                  },
                                )
                              : null,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Filtre Ayarları Butonu
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurfaceElevated,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.tune_rounded, size: 22),
                        color: AppColors.primary,
                        tooltip: 'Filtrele & Sırala',
                        onPressed: () => _openFilterModal(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 3. Aktif Kiralama Panosu (Varsa görüntülenir)
            const SliverToBoxAdapter(
              child: ActiveRentalBanner(),
            ),

            // 4. Kategori Çubuğu
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 14.0),
                child: CategoryFilterBar(),
              ),
            ),

            // 5. Araç Listesi Başlığı
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Müsait Araçlar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    ValueListenableBuilder<List<Vehicle>>(
                      valueListenable:
                          VehicleController.instance.filteredVehiclesNotifier,
                      builder: (context, vehicles, child) {
                        return Text(
                          '${vehicles.length} Araç',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // 6. Dinamik Araç Listesi
            ValueListenableBuilder<List<Vehicle>>(
              valueListenable:
                  VehicleController.instance.filteredVehiclesNotifier,
              builder: (context, vehicles, _) {
                if (vehicles.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Center(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.car_rental_outlined,
                              size: 64,
                              color: AppColors.darkTextSecondary,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Aramanıza uygun araç bulunamadı.',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                _searchController.clear();
                                VehicleController.instance.resetFilters();
                                setState(() {});
                              },
                              child: const Text('Filtreleri Temizle'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final vehicle = vehicles[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: VehicleCard(vehicle: vehicle),
                        );
                      },
                      childCount: vehicles.length,
                    ),
                  ),
                );
              },
            ),
          ],
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
        ),
      ),
    );
  }
}
