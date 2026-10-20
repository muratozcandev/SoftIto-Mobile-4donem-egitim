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

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                              ),
                            ),
                          ],
                        ),
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
        ),
      ),
    );
  }
}
