<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: vehicle_card.dart
// Görev: Araç listesinde veya arama sonuçlarında gösterilen modern araç kartı.
// Açıklama: Marka, model, günlük fiyat, puan, vites ve yakıt bilgilerini
// görsel olarak zengin Material 3 kartı içerisinde sunar.
// ==============================================================================

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/localization/locale_controller.dart';
import '../models/vehicle_model.dart';

/// [VehicleCard] widget'ı, tekil bir aracın özet bilgilerini gösteren tıklanabilir karttır.
class VehicleCard extends StatelessWidget {
  /// Gösterilecek araç modeli
  final Vehicle vehicle;

  /// Karta tıklandığında çalışacak callback
  final VoidCallback onTap;

  const VehicleCard({
    super.key,
    required this.vehicle,
    required this.onTap,
=======
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/theme_controller.dart';
import '../models/vehicle_model.dart';
import 'vehicle_spec_chip.dart';
import '../views/vehicle_detail_view.dart';

/// [VehicleCard] widget'ı, ana sayfada ve arama listesinde her bir aracın
/// fotoğrafını, teknik özelliklerini, fiyatını ve kiralama butonunu gösteren modern kart bileşenidir.
class VehicleCard extends StatelessWidget {
  /// Gösterilecek araç nesnesi
  final Vehicle vehicle;

  /// Kurucu metod
  const VehicleCard({
    super.key,
    required this.vehicle,
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
    final isEn = LocaleController.instance.isEnglish;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: isDark ? 0 : 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------------------------------------------------------
              // Üst Kısım: Marka/Model ve Puan Rozeti
              // ---------------------------------------------------------------
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sol: Marka ve Model Başlığı
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicle.brand.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.1,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          vehicle.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Sağ: Puan Rozeti
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.warning.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: AppColors.warning,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          vehicle.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: AppColors.warning,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ---------------------------------------------------------------
              // Orta Kısım: Araç Fotoğrafı ve Gövde Tipi Rozeti
              // ---------------------------------------------------------------
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: vehicle.accentColor.withValues(alpha: 0.25),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Gerçek Araç Fotoğrafı
                      Image.asset(
                        vehicle.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: vehicle.accentColor.withValues(alpha: 0.1),
                            child: Icon(
                              vehicle.displayIcon,
                              size: 64,
                              color: vehicle.accentColor,
                            ),
                          );
                        },
                      ),

                      // Alt tarafa hafif gölgeli degrade (yazıların okunması için)
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.65),
                              ],
                              stops: const [0.6, 1.0],
                            ),
                          ),
                        ),
                      ),

                      // Gövde Tipi Rozeti (Sol Alt)
                      Positioned(
                        left: 12,
                        bottom: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.65),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: vehicle.accentColor.withValues(alpha: 0.5),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            vehicle.type,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
=======
>>>>>>> Stashed changes
    final theme = Theme.of(context);
    final isDark = ThemeController.instance.isDarkMode;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Kart tıklandığında araç detay sayfasına geçiş yapar
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => VehicleDetailView(vehicle: vehicle),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Araç Fotoğrafı ve Üzerindeki Etiketler
            Stack(
              children: [
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Image.asset(
                    vehicle.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => Container(
                      color: isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurfaceElevated,
                      child: const Center(
                        child: Icon(Icons.directions_car, size: 50, color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
                // Fotoğraf altındaki hafif gölge gradyanı
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withAlpha(120),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                // Öne Çıkan Araç Rozeti (Featured Badge)
                if (vehicle.isFeatured)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(80),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star_rounded, size: 14, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            'Öne Çıkan',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // Gövde Tipi Rozeti (Sağ Üst)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(160),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white.withAlpha(40)),
                    ),
                    child: Text(
                      vehicle.type,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 2. Araç Bilgileri ve Başlığı
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Marka ve Model Adı
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          vehicle.fullName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
              ),
              const SizedBox(height: 16),

              // ---------------------------------------------------------------
              // Alt Kısım: Teknik Özellik İpuçları (Vites, Yakıt, Koltuk)
              // ---------------------------------------------------------------
              Row(
                children: [
                  _buildSpecChip(Icons.tune_rounded, vehicle.transmission),
                  const SizedBox(width: 8),
                  _buildSpecChip(Icons.local_gas_station_rounded, vehicle.fuelType),
                  const SizedBox(width: 8),
                  _buildSpecChip(Icons.event_seat_rounded, '${vehicle.seats} K'),
                ],
              ),
              const SizedBox(height: 14),

              const Divider(height: 1),
              const SizedBox(height: 12),

              // ---------------------------------------------------------------
              // Fiyat ve İncele / Kirala Butonu
              // ---------------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Fiyat Bilgisi
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.dailyPriceLabel(isEn),
                        style: TextStyle(
                          fontSize: 11,
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
                                fontSize: 20,
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
=======
>>>>>>> Stashed changes
                  const SizedBox(height: 10),

                  // Araç Teknik Özellik Çipleri
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      VehicleSpecChip(
                        icon: Icons.speed_rounded,
                        label: '${vehicle.horsepower} HP',
                      ),
                      VehicleSpecChip(
                        icon: Icons.tune_rounded,
                        label: vehicle.transmission,
                      ),
                      VehicleSpecChip(
                        icon: Icons.local_gas_station_rounded,
                        label: vehicle.fuelType,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  const Divider(),
                  const SizedBox(height: 10),

                  // 3. Fiyat ve "Hemen Kirala" Butonu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Fiyat Göstergesi
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Günlük Fiyat',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '${vehicle.dailyPrice} ₺',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                ' / gün',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Hemen Kirala Butonu
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => VehicleDetailView(vehicle: vehicle),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(110, 42),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Kirala',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward_rounded, size: 16),
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
                          ],
                        ),
                      ),
                    ],
                  ),
<<<<<<< Updated upstream
=======
<<<<<<< HEAD

                  // Detay Butonu
                  ElevatedButton.icon(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                    icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                    label: Text(
                      isEn ? 'Details' : 'İncele',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
=======
>>>>>>> Stashed changes
                ],
              ),
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
<<<<<<< Updated upstream
=======
<<<<<<< HEAD

  /// Küçük teknik özellik rozeti oluşturucu yardımcı metot
  Widget _buildSpecChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
}
