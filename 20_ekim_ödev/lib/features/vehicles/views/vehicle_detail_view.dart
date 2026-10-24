<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: vehicle_detail_view.dart
// Görev: Seçilen aracın tüm teknik özelliklerini ve kiralama başlatma aksiyonunu sunar.
// Açıklama: Motor gücü, menzil, yakıt türü, koltuk kapasitesi ve günlük fiyatı
// net ve şık Material 3 kartlarıyla sergiler.
// ==============================================================================

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/localization/locale_controller.dart';
import '../models/vehicle_model.dart';
import '../../rental/views/rental_view.dart';

/// [VehicleDetailView] widget'ı, aracın detaylı bilgi ve kiralama ekranıdır.
class VehicleDetailView extends StatelessWidget {
  /// İncelenen araç nesnesi
  final Vehicle vehicle;

  const VehicleDetailView({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final isEn = LocaleController.instance.isEnglish;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('${vehicle.brand} ${vehicle.name}'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 550),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // -----------------------------------------------------------
                  // Üst Görsel Vitrini (Gerçek Araç Fotoğrafı)
                  // -----------------------------------------------------------
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: vehicle.accentColor.withValues(alpha: 0.35),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: vehicle.accentColor.withValues(alpha: 0.15),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: Image.asset(
                        vehicle.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: vehicle.accentColor.withValues(alpha: 0.1),
                            child: Icon(
                              vehicle.displayIcon,
                              size: 80,
                              color: vehicle.accentColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // -----------------------------------------------------------
                  // Başlık, Puan ve Fiyat Alanı
                  // -----------------------------------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vehicle.brand.toUpperCase(),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              vehicle.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Puan ve Tur Rozeti
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.warning.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 18,
                              color: AppColors.warning,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${vehicle.rating} (${vehicle.tripCount})',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: AppColors.warning,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // -----------------------------------------------------------
                  // Teknik Özellikler Izgarası (Grid)
                  // -----------------------------------------------------------
                  Text(
                    AppStrings.specs(isEn),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: _buildSpecCard(
                          icon: Icons.speed_rounded,
                          title: AppStrings.engine(isEn),
                          value: vehicle.enginePower,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSpecCard(
                          icon: Icons.battery_charging_full_rounded,
                          title: AppStrings.range(isEn),
                          value: vehicle.range,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _buildSpecCard(
                          icon: Icons.tune_rounded,
                          title: isEn ? 'Gear' : 'Vites',
                          value: vehicle.transmission,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSpecCard(
                          icon: Icons.local_gas_station_rounded,
                          title: AppStrings.fuel(isEn),
                          value: vehicle.fuelType,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _buildSpecCard(
                          icon: Icons.event_seat_rounded,
                          title: AppStrings.seats(isEn),
                          value: '${vehicle.seats} ${isEn ? 'Persons' : 'Kişilik'}',
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSpecCard(
                          icon: Icons.category_rounded,
                          title: isEn ? 'Body Type' : 'Kasa Tipi',
                          value: vehicle.type,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // -----------------------------------------------------------
                  // Alt Sabit Fiyat ve Hemen Kirala Butonu
                  // -----------------------------------------------------------
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.dailyPriceLabel(isEn),
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '₺${vehicle.dailyPrice} ',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                      color: isDark
                                          ? AppColors.primary
                                          : AppColors.primaryDark,
                                    ),
                                  ),
                                  TextSpan(
                                    text: AppStrings.perDay(isEn),
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isDark
                                          ? AppColors.darkTextSecondary
                                          : AppColors.lightTextSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RentalView(vehicle: vehicle),
                              ),
                            );
                          },
                          icon: const Icon(Icons.key_rounded, size: 18),
                          label: Text(
                            AppStrings.rentNow(isEn),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
                    ),
                  ),
                ],
              ),
            ),
          ),
<<<<<<< Updated upstream
        ],
=======
<<<<<<< HEAD
        ),
=======
        ],
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
      ),
    );
  }

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
  /// Teknik özellik kartı oluşturucu
  Widget _buildSpecCard({
    required IconData icon,
    required String title,
    required String value,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
=======
>>>>>>> Stashed changes
  /// Teknik özellik kartı oluşturucu yardımcı widget
  Widget _buildSpecItem(IconData icon, String title, String value, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(10),
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
          ),
        ],
      ),
    );
  }
}
