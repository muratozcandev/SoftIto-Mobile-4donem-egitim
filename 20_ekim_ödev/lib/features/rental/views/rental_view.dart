// ==============================================================================
// Dosya: rental_view.dart
// Görev: Kiralama süresi (1-31 gün) seçimi, ek güvence paketi ve fiyat hesaplama ekranı.
// Açıklama: Kullanıcının gün sayısını dinamik olarak değiştirmesini sağlar ve
// anlık hesaplanan toplam tutarla ödeme ekranına geçiş sunar.
// ==============================================================================

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/localization/locale_controller.dart';
import '../../vehicles/models/vehicle_model.dart';
import '../controllers/rental_controller.dart';
import 'payment_view.dart';

/// [RentalView] widget'ı, kiralama süresinin ve opsiyonlarının belirlendiği ekrandır.
class RentalView extends StatefulWidget {
  final Vehicle vehicle;

  const RentalView({super.key, required this.vehicle});

  @override
  State<RentalView> createState() => _RentalViewState();
}

class _RentalViewState extends State<RentalView> {
  late final RentalController _controller;

  @override
  void initState() {
    super.initState();
    // Kiralama controller'ını seçilen araçla başlatıyoruz
    _controller = RentalController(vehicle: widget.vehicle);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEn = LocaleController.instance.isEnglish;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.rentalDuration(isEn)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // -----------------------------------------------------------
                  // Seçilen Araç Özet Başlığı
                  // -----------------------------------------------------------
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 75,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: widget.vehicle.accentColor
                                    .withValues(alpha: 0.35),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.asset(
                                widget.vehicle.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  color: widget.vehicle.accentColor
                                      .withValues(alpha: 0.15),
                                  child: Icon(
                                    widget.vehicle.displayIcon,
                                    size: 32,
                                    color: widget.vehicle.accentColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.vehicle.brand.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.vehicle.name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₺${widget.vehicle.dailyPrice} ${AppStrings.perDay(isEn)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: isDark
                                        ? AppColors.primary
                                        : AppColors.primaryDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // -----------------------------------------------------------
                  // Dinamik Kiralama Süresi Seçicisi (1 - 31 Gün)
                  // -----------------------------------------------------------
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.rentalDuration(isEn),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              ValueListenableBuilder<int>(
                                valueListenable: _controller.daysNotifier,
                                builder: (context, days, _) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary
                                          .withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      AppStrings.daysCount(isEn, days),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                        color: isDark
                                            ? AppColors.primary
                                            : AppColors.primaryDark,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Eksi - Değer - Artı Butonları
                          ValueListenableBuilder<int>(
                            valueListenable: _controller.daysNotifier,
                            builder: (context, days, _) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Azalt Butonu
                                      IconButton.filledTonal(
                                        onPressed: days > 1
                                            ? _controller.decrementDays
                                            : null,
                                        icon: const Icon(Icons.remove),
                                      ),
                                      Text(
                                        '$days',
                                        style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      // Arttır Butonu (31 gün sınırına kadar)
                                      IconButton.filledTonal(
                                        onPressed: days < 31
                                            ? _controller.incrementDays
                                            : null,
                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),

                                  // Slider ile Hızlı Gün Kaydırma
                                  Slider(
                                    value: days.toDouble(),
                                    min: 1,
                                    max: 31,
                                    divisions: 30,
                                    label: '$days Gün',
                                    activeColor: isDark
                                        ? AppColors.primary
                                        : AppColors.primaryDark,
                                    onChanged: (val) {
                                      _controller.setDays(val.round());
                                    },
                                  ),
                                  Center(
                                    child: Text(
                                      isEn
                                          ? 'Select between 1 and 31 days'
                                          : '1 ile 31 gün arasında kiralama yapabilirsiniz',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isDark
                                            ? AppColors.darkTextSecondary
                                            : AppColors.lightTextSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // -----------------------------------------------------------
                  // Güvence & Kasko Paketi Tercihi
                  // -----------------------------------------------------------
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: _controller.insuranceNotifier,
                        builder: (context, hasInsurance, _) {
                          return SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              isEn ? 'Full Coverage Insurance' : 'Tam Kasko ve Güvence',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Text(
                              isEn
                                  ? '+₺250 / day (Zero deductible & 24/7 assistance)'
                                  : '+₺250 / gün (Muafiyetsiz koruma & 7/24 yol yardım)',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                            value: hasInsurance,
                            activeThumbColor: AppColors.primary,
                            onChanged: (val) {
                              _controller.toggleInsurance();
                              setState(() {});
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // -----------------------------------------------------------
                  // Anlık Fiyat Özeti
                  // -----------------------------------------------------------
                  ValueListenableBuilder<int>(
                    valueListenable: _controller.daysNotifier,
                    builder: (context, days, _) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${widget.vehicle.name} ($days ${isEn ? 'Days' : 'Gün'})',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDark
                                          ? AppColors.darkTextSecondary
                                          : AppColors.lightTextSecondary,
                                    ),
                                  ),
                                  Text(
                                    '₺${_controller.rawRentalPrice}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              if (_controller.insuranceNotifier.value) ...[
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      isEn ? 'Insurance Package' : 'Güvence Paketi',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isDark
                                            ? AppColors.darkTextSecondary
                                            : AppColors.lightTextSecondary,
                                      ),
                                    ),
                                    Text(
                                      '₺${_controller.totalInsurancePrice}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              const Divider(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppStrings.totalToPay(isEn),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    '₺${_controller.totalPrice}',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                      color: isDark
                                          ? AppColors.primary
                                          : AppColors.primaryDark,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // -----------------------------------------------------------
                  // Ödemeye Geç Butonu
                  // -----------------------------------------------------------
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentView(
                            rentalController: _controller,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      isEn ? 'Proceed to Payment' : 'Ödeme Adımına Geç',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
