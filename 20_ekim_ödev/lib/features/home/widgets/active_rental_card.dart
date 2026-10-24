// ==============================================================================
// Dosya: active_rental_card.dart
// Görev: Kullanıcının şu anda kiraladığı aktif aracı ve kalan süresini gösteren kart.
// Açıklama: Araç teslim etme ve teslimat esnasında AraÇek hasar kaydı açma butonunu barındırır.
// ==============================================================================

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/localization/locale_controller.dart';
import '../../vehicles/models/vehicle_model.dart';

/// [ActiveRentalCard] widget'ı, ana sayfanın en üstünde kiralanmış aktif aracı sunar.
class ActiveRentalCard extends StatelessWidget {
  /// Kiralanan araç bilgisi
  final Vehicle vehicle;

  /// Kalan kiralama gün sayısı
  final int daysLeft;

  /// Teslim Et / Fotoğraf Çek butonuna tıklandığında çalışacak callback
  final VoidCallback onReturnTap;

  const ActiveRentalCard({
    super.key,
    required this.vehicle,
    required this.daysLeft,
    required this.onReturnTap,
  });

  @override
  Widget build(BuildContext context) {
    final isEn = LocaleController.instance.isEnglish;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Üst Satır: Aktif Kiralama Durum Rozeti ve Kalan Gün
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.electric_car,
                      size: 14,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      AppStrings.activeRentalTitle(isEn),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  AppStrings.daysLeft(isEn, daysLeft),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppColors.warning,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Araç Bilgisi ve Görsel İkonu
          Row(
            children: [
              Container(
                width: 75,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.4),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    vehicle.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.white.withValues(alpha: 0.1),
                      child: Icon(
                        vehicle.displayIcon,
                        size: 28,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.brand.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      vehicle.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Teslim Et ve AraÇek Çekimi Yap Butonu
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onReturnTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.camera_alt_outlined, size: 18),
                  label: Text(
                    AppStrings.returnVehicleBtn(isEn),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
