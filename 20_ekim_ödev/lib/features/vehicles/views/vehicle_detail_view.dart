import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/theme_controller.dart';
import '../models/vehicle_model.dart';
import '../../rental/controllers/rental_controller.dart';
import '../../rental/views/rental_checkout_view.dart';

/// [VehicleDetailView] ekranı, kullanıcının seçtiği aracın tüm teknik detaylarını,
/// büyük fotoğraflarını, 1-31 gün arası kiralama süresi seçimini ve
/// dinamik fiyat hesaplamasını barındıran detay sayfasıdır.
class VehicleDetailView extends StatefulWidget {
  final Vehicle vehicle;

  const VehicleDetailView({
    super.key,
    required this.vehicle,
  });

  @override
  State<VehicleDetailView> createState() => _VehicleDetailViewState();
}

class _VehicleDetailViewState extends State<VehicleDetailView> {
  // Seçilen gün sayısı (Varsayılan 3 gün)
  int _selectedDays = 3;

  @override
  Widget build(BuildContext context) {
    final vehicle = widget.vehicle;
    final isDark = ThemeController.instance.isDarkMode;
    final totalPrice = RentalController.instance.calculateTotal(vehicle.dailyPrice, _selectedDays);

    return Scaffold(
      body: Stack(
        children: [
          // 1. Kaydırılabilir İçerik
          CustomScrollView(
            slivers: [
              // Büyük Araç Görseli ve Özel AppBar
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        vehicle.imagePath,
                        fit: BoxFit.cover,
                      ),
                      // Görsel altı karartma gradyanı
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withAlpha(140),
                              Colors.transparent,
                              isDark ? AppColors.darkBackground : AppColors.lightBackground,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // İçerik Detayları
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Marka ve Kategori Rozeti
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withAlpha(35),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              vehicle.brand.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurfaceElevated,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              vehicle.type,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Araç Model Adı
                      Text(
                        vehicle.name,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Teknik Özellikler Izgarası (Specs Grid)
                      const Text(
                        'Teknik Özellikler & Performans',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 12),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.25,
                        children: [
                          _buildSpecItem(Icons.speed_rounded, '0-100 Hızlanma', '${vehicle.acceleration} sn', isDark),
                          _buildSpecItem(Icons.bolt_rounded, 'Motor Gücü', '${vehicle.horsepower} HP', isDark),
                          _buildSpecItem(Icons.tune_rounded, 'Vites Türü', vehicle.transmission, isDark),
                          _buildSpecItem(Icons.local_gas_station_rounded, 'Yakıt Türü', vehicle.fuelType, isDark),
                          _buildSpecItem(Icons.airline_seat_recline_extra_rounded, 'Kapasite', '${vehicle.seats} Koltuk', isDark),
                          _buildSpecItem(Icons.map_rounded, 'Tahmini Menzil', '${vehicle.rangeKm} km', isDark),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Kiralama Süresi Seçici (1 - 31 Gün Kuralı)
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.calendar_month_rounded, size: 20, color: AppColors.primary),
                                SizedBox(width: 8),
                                Text(
                                  'Kiralama Süresi (1 - 31 Gün)',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),

                            // Stepper Kontrolü
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Seçilen Gün Sayısı:',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  children: [
                                    IconButton.filledTonal(
                                      icon: const Icon(Icons.remove, size: 18),
                                      onPressed: _selectedDays > 1
                                          ? () => setState(() => _selectedDays--)
                                          : null,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                      child: Text(
                                        '$_selectedDays Gün',
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                    IconButton.filledTonal(
                                      icon: const Icon(Icons.add, size: 18),
                                      onPressed: _selectedDays < 31
                                          ? () => setState(() => _selectedDays++)
                                          : null,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Kaydırıcı (Slider)
                            Slider(
                              value: _selectedDays.toDouble(),
                              min: 1,
                              max: 31,
                              divisions: 30,
                              activeColor: AppColors.primary,
                              inactiveColor: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                              label: '$_selectedDays Gün',
                              onChanged: (val) {
                                setState(() {
                                  _selectedDays = val.round();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Dahil Olan Hizmetler
                      const Row(
                        children: [
                          Icon(Icons.verified_user_rounded, size: 18, color: AppColors.success),
                          SizedBox(width: 8),
                          Text(
                            'Tam Kapsamlı AraÇek Kaskosu ve Yol Yardımı Dahil',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 2. Alt Sabit Ödeme Çubuğu (Bottom Action Bar)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                border: Border(
                  top: BorderSide(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(40),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Toplam Fiyat Bilgisi
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$_selectedDays Günlük Toplam',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$totalPrice ₺',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),

                  // Ödemeye İlerle Butonu
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Kiralama ve ödeme simülasyonu ekranına yönlendirir
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RentalCheckoutView(
                              vehicle: vehicle,
                              days: _selectedDays,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Kiralama ve Ödeme',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward_rounded, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Teknik özellik kartı oluşturucu yardımcı widget
  Widget _buildSpecItem(IconData icon, String title, String value, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
