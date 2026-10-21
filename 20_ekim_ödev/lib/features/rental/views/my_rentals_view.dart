import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/theme_controller.dart';
import '../controllers/rental_controller.dart';
import '../models/rental_order_model.dart';
import '../../damage_report/views/damage_report_view.dart';

/// [MyRentalsView] ekranı, kullanıcının aktif olarak kullandığı kiralık araçları
/// ve geçmiş tamamlanan teslimatlarını listeler.
class MyRentalsView extends StatefulWidget {
  const MyRentalsView({super.key});

  @override
  State<MyRentalsView> createState() => _MyRentalsViewState();
}

class _MyRentalsViewState extends State<MyRentalsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Aracı iade etme onay diyaloğu
  void _confirmDelivery(RentalOrder order) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Aracı Teslim Et'),
        content: Text(
          '${order.vehicle.fullName} aracını teslim etmek ve AraÇek hasar raporu oluşturmak istiyor musunuz?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Vazgeç'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              // Siparişi geçmişe taşı
              RentalController.instance.deliverVehicle(order);
              // Doğrudan AraÇek kamera / teslimat ekranına geç
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DamageReportView(
                    prefilledVehicleName: order.vehicle.fullName,
                  ),
                ),
              );
            },
            child: const Text('Teslim Et & AraÇek'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeController.instance.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kiralamalarım'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          tabs: const [
            Tab(text: 'Aktif Kiralamalar'),
            Tab(text: 'Geçmiş / Tamamlanan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 1. Aktif Kiralamalar Sekmesi
          ValueListenableBuilder<List<RentalOrder>>(
            valueListenable: RentalController.instance.activeRentalsNotifier,
            builder: (context, activeList, _) {
              if (activeList.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.directions_car_outlined, size: 64, color: AppColors.darkTextSecondary),
                      SizedBox(height: 12),
                      Text(
                        'Şu anda aktif bir kiralamanız bulunmuyor.',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: activeList.length,
                itemBuilder: (context, index) {
                  final order = activeList[index];
                  return _buildOrderCard(order, isDark, isActive: true);
                },
              );
            },
          ),

          // 2. Geçmiş Kiralamalar Sekmesi
          ValueListenableBuilder<List<RentalOrder>>(
            valueListenable: RentalController.instance.pastRentalsNotifier,
            builder: (context, pastList, _) {
              if (pastList.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history_rounded, size: 64, color: AppColors.darkTextSecondary),
                      SizedBox(height: 12),
                      Text(
                        'Henüz tamamlanmış bir kiralama kaydınız yok.',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: pastList.length,
                itemBuilder: (context, index) {
                  final order = pastList[index];
                  return _buildOrderCard(order, isDark, isActive: false);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(RentalOrder order, bool isDark, {required bool isActive}) {
    final vehicle = order.vehicle;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 90,
                    height: 60,
                    child: Image.asset(vehicle.imagePath, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              vehicle.fullName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.primary.withAlpha(40)
                                  : AppColors.success.withAlpha(40),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              isActive ? 'Aktif' : 'Tamamlandı',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: isActive ? AppColors.primary : AppColors.success,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Kod: ${order.id} • ${order.days} Gün',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                      Text(
                        'Toplam: ${order.totalPrice} ₺',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 14, color: AppColors.darkTextSecondary),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    order.location,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (isActive) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _confirmDelivery(order),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.assignment_turned_in_rounded, size: 16),
                  label: const Text('Aracı Teslim Et & AraÇek Fotoğrafı Çek'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
