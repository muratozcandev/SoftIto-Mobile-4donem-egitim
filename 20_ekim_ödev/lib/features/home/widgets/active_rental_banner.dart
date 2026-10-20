import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../rental/controllers/rental_controller.dart';
import '../../rental/models/rental_order_model.dart';
import '../../damage_report/views/damage_report_view.dart';

/// [ActiveRentalBanner] widget'ı, kullanıcının kiralamış olduğu aktif bir araç varsa
/// ana sayfanın en üstünde dikkat çekici bir kart olarak gösterir.
/// Kalan gün sayısını ve hızlı araç teslimat/fotoğraf çekim aksiyonunu sunar.
class ActiveRentalBanner extends StatelessWidget {
  const ActiveRentalBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<RentalOrder>>(
      valueListenable: RentalController.instance.activeRentalsNotifier,
      builder: (context, activeRentals, _) {
        if (activeRentals.isEmpty) {
          return const SizedBox.shrink();
        }

        final order = activeRentals.first;
        final vehicle = order.vehicle;

        return Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 18),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF132238), Color(0xFF0F172A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withAlpha(120),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withAlpha(35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Üst Vurgu Satırı
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(40),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.key_rounded,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Aktif Kiralık Aracınız',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                  // Kalan Gün Rozeti
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${order.remainingDays} Gün Kaldı',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Araç Bilgisi ve Küçük Görseli
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 80,
                      height: 52,
                      child: Image.asset(
                        vehicle.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicle.fullName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 13,
                              color: AppColors.darkTextSecondary,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                order.location,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.darkTextSecondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Teslim Et ve AraÇek Başlat Butonu
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // AraÇek hasar kontrolü ve teslimat ekranına geçiş yapar
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DamageReportView(
                          prefilledVehicleName: vehicle.fullName,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.camera_alt_rounded, size: 18),
                  label: const Text('Aracı Teslim Et & AraÇek Fotoğrafı Çek'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.primary, width: 1.2),
                    backgroundColor: AppColors.primary.withAlpha(30),
                    minimumSize: const Size.fromHeight(42),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
