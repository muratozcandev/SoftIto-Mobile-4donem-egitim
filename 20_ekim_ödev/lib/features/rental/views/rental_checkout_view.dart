import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/theme_controller.dart';
import '../../vehicles/models/vehicle_model.dart';
import '../controllers/rental_controller.dart';
import '../../damage_report/views/damage_report_view.dart';
import '../../home/views/main_navigation_shell.dart';

/// [RentalCheckoutView] ekranı, kullanıcının seçtiği araç için teslimat lokasyonunu,
/// sanal kredi kartı bilgilerini, indirim kuponunu girdiği ve
/// kiralama sözleşmesi simülasyonunu tamamladığı ödeme ekranıdır.
class RentalCheckoutView extends StatefulWidget {
  final Vehicle vehicle;
  final int days;

  const RentalCheckoutView({
    super.key,
    required this.vehicle,
    required this.days,
  });

  @override
  State<RentalCheckoutView> createState() => _RentalCheckoutViewState();
}

class _RentalCheckoutViewState extends State<RentalCheckoutView> {
  final _formKey = GlobalKey<FormState>();

  // Sanal kart kontrolcüleri
  final _cardHolderController =
      TextEditingController(text: 'Ahmet Yılmaz');
  final _cardNumberController =
      TextEditingController(text: '5422 8900 1234 5678');
  final _expiryController = TextEditingController(text: '12/28');
  final _cvvController = TextEditingController(text: '342');
  final _couponController = TextEditingController();

  // Seçili teslimat lokasyonu
  String _selectedLocation = 'İstanbul Havalimanı (IST) - Dış Hatlar';

  // İndirim tutarı (Kupon kodu uygulanırsa)
  int _discount = 0;
  bool _isProcessing = false;

  final List<String> _locations = [
    'İstanbul Havalimanı (IST) - Dış Hatlar',
    'Sabiha Gökçen Havalimanı (SAW) - Otopark',
    'Kadıköy Rıhtım Ofisi',
    'Levent Kanyon Plaza Teslimat Noktası',
    'Ankara Esenboğa Havalimanı',
    'İzmir Adnan Menderes Havalimanı',
  ];

  @override
  void dispose() {
    _cardHolderController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _couponController.dispose();
    super.dispose();
  }

  /// Kupon kodu uygulama fonksiyonu
  void _applyCoupon() {
    final code = _couponController.text.trim().toUpperCase();
    if (code == 'ARACEK' || code == 'ARACEK2026') {
      setState(() {
        _discount = 250;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🎉 250 ₺ AraÇek kupon indirimi uygulandı!'),
          backgroundColor: AppColors.success,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Geçersiz kupon kodu. (İpucu: ARACEK yazabilirsiniz)'),
          backgroundColor: AppColors.warning,
        ),
      );
    }
  }

  /// Ödemeyi onaylama ve kiralama simülasyonu
  void _submitRental() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isProcessing = true);

    // Kısa bir güvenli ödeme simülasyonu gecikmesi
    await Future.delayed(const Duration(milliseconds: 1000));

    // Kiralama siparişini controller'a kaydet
    final order = RentalController.instance.rentVehicle(
      vehicle: widget.vehicle,
      days: widget.days,
      location: _selectedLocation,
    );

    if (mounted) {
      setState(() => _isProcessing = false);
      _showSuccessDialog(order.id);
    }
  }

  /// Kiralama başarılı diyalog penceresi
  void _showSuccessDialog(String orderId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.success.withAlpha(30),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  size: 56,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Kiralama Başarılı!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Text(
                'Sipariş Kodunuz: $orderId\nAracınız teslimata hazırlandı.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: AppColors.darkTextSecondary),
              ),
              const SizedBox(height: 20),
              // AraÇek ile Teslimat Fotoğrafı Çek Butonu
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  // Doğrudan AraÇek kamera / hasar kontrol ekranına yönlendirir
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => DamageReportView(
                        prefilledVehicleName: widget.vehicle.fullName,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.camera_alt_rounded),
                label: const Text('Şimdi AraÇek ile Fotoğraf Çek'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
              const SizedBox(height: 8),
              // Ana Sayfaya Dön Butonu
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const MainNavigationShell(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text('Ana Sayfaya Git'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final vehicle = widget.vehicle;
    final isDark = ThemeController.instance.isDarkMode;
    final subtotal = vehicle.dailyPrice * widget.days;
    final grandTotal = (subtotal - _discount).clamp(0, 999999);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ödeme ve Kiralama Onayı'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Özet Araç Kartı
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: 88,
                          height: 60,
                          child: Image.asset(vehicle.imagePath, fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vehicle.fullName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${widget.days} Gün x ${vehicle.dailyPrice} ₺/gün',
                              style: TextStyle(
                                fontSize: 13,
                                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),

                // 2. Teslimat Lokasyonu Seçimi
                const Text(
                  'Teslim Alma / Bırakma Noktası',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: _selectedLocation,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_on_outlined),
                  ),
                  items: _locations.map((loc) {
                    return DropdownMenuItem<String>(
                      value: loc,
                      child: Text(loc, style: const TextStyle(fontSize: 13)),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedLocation = val);
                  },
                ),
                const SizedBox(height: 22),

                // 3. Sanal Kredi Kartı Bilgileri
                const Text(
                  'Kart Bilgileri (Demo Simülasyonu)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _cardHolderController,
                  decoration: const InputDecoration(
                    labelText: 'Kart Üzerindeki İsim',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'İsim zorunludur' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Kart Numarası',
                    prefixIcon: Icon(Icons.credit_card),
                  ),
                  validator: (v) => v == null || v.length < 16 ? 'Geçerli kart giriniz' : null,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _expiryController,
                        decoration: const InputDecoration(
                          labelText: 'Son Kul. (AA/YY)',
                          prefixIcon: Icon(Icons.calendar_today_outlined),
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Gerekli' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _cvvController,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'CVV',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                        validator: (v) => v == null || v.length < 3 ? 'Gerekli' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // 4. İndirim Kuponu
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _couponController,
                        decoration: const InputDecoration(
                          hintText: 'Kupon Kodu (örn: ARACEK)',
                          prefixIcon: Icon(Icons.local_offer_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _applyCoupon,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(90, 52),
                      ),
                      child: const Text('Uygula'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 5. Fiyat Dağılımı Dökümü
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildPriceRow('Araç Kiralama Tutarı:', '$subtotal ₺', isDark),
                      const SizedBox(height: 8),
                      _buildPriceRow('Kasko & Güvence Bedeli:', '0 ₺ (Ücretsiz)', isDark, isHighlight: true),
                      if (_discount > 0) ...[
                        const SizedBox(height: 8),
                        _buildPriceRow('Kupon İndirimi:', '-$_discount ₺', isDark, isDiscount: true),
                      ],
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Ödenecek Toplam:',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            '$grandTotal ₺',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Onayla ve Kirala Butonu
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _isProcessing ? null : _submitRental,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isProcessing
                        ? const CircularProgressIndicator(color: Colors.black)
                        : Text(
                            'Toplam $grandTotal ₺ Öde ve Kirala',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, bool isDark,
      {bool isHighlight = false, bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isDiscount
                ? AppColors.success
                : (isHighlight ? AppColors.primary : null),
          ),
        ),
      ],
    );
  }
}
