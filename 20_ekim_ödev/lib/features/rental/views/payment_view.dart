// ==============================================================================
// Dosya: payment_view.dart
// Görev: Kiralama işleminin son adımı olan simüle edilmiş kredi kartı ödeme ekranı.
// Açıklama: Kart numarası, son kullanma, CVV, kart sahibi alanlarını doğrular.
// Kupon kodu indirimi sunar ve onay sonrasında aktif kiralamayı başlatır.
// ==============================================================================

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/localization/locale_controller.dart';
import '../controllers/rental_controller.dart';

/// [PaymentView] widget'ı, simüle edilmiş ödeme formunu barındırır.
class PaymentView extends StatefulWidget {
  final RentalController rentalController;

  const PaymentView({super.key, required this.rentalController});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  /// Form doğrulama anahtarı
  final _formKey = GlobalKey<FormState>();

  /// Kart numarası controller'ı
  final _cardNumberController =
      TextEditingController(text: '4532 8920 1234 5678');

  /// Son kullanma tarihi controller'ı
  final _expiryController = TextEditingController(text: '12/28');

  /// CVV controller'ı
  final _cvvController = TextEditingController(text: '884');

  /// Kart sahibi adı controller'ı
  final _holderController = TextEditingController(text: 'Murat Yılmaz');

  /// Kupon kodu controller'ı
  final _couponController = TextEditingController();

  /// Ödeme yüklenme simülasyon bayrağı
  bool _isProcessing = false;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _holderController.dispose();
    _couponController.dispose();
    super.dispose();
  }

  /// Kupon uygulama işlemi
  void _applyCoupon() {
    final success =
        widget.rentalController.applyCoupon(_couponController.text);
    final isEn = LocaleController.instance.isEnglish;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: success ? AppColors.success : AppColors.error,
        content: Text(
          success
              ? AppStrings.couponApplied(isEn)
              : (isEn ? 'Invalid coupon code' : 'Geçersiz kupon kodu! (Deneyin: ARACEK15 veya SOFTITO)'),
        ),
      ),
    );
    setState(() {});
  }

  /// Ödemeyi tamamlama ve kiralamayı onaylama simülasyonu
  void _submitPayment() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isProcessing = true);
    final isEn = LocaleController.instance.isEnglish;

    // Gerçekçi ödeme provizyon gecikmesi simülasyonu
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;

      widget.rentalController.completeRental();
      setState(() => _isProcessing = false);

      // Başarılı ödeme bildirim diyaloğu
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  size: 45,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                AppStrings.success(isEn),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                AppStrings.rentalSuccessMsg(isEn),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Diyaloğu kapat
                  Navigator.of(ctx).pop();
                  // Kiralama ve detay ekranlarını kapatıp ana sayfaya dön
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Text(isEn ? 'Go to Home' : 'Ana Sayfaya Dön'),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEn = LocaleController.instance.isEnglish;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = widget.rentalController;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.paymentTitle(isEn)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ---------------------------------------------------------
                    // Sanal Kart Görünümü (Visual Credit Card)
                    // ---------------------------------------------------------
                    Container(
                      height: 180,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'AraÇek Card',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Icon(
                                Icons.contactless_rounded,
                                color: Colors.white.withValues(alpha: 0.7),
                                size: 24,
                              ),
                            ],
                          ),
                          Text(
                            _cardNumberController.text.isEmpty
                                ? '•••• •••• •••• ••••'
                                : _cardNumberController.text,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'KART SAHİBİ',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.5),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    _holderController.text.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SON KULLANMA',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.5),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    _expiryController.text,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ---------------------------------------------------------
                    // Kart Bilgileri Giriş Formu
                    // ---------------------------------------------------------
                    // Kart Numarası
                    TextFormField(
                      controller: _cardNumberController,
                      keyboardType: TextInputType.number,
                      onChanged: (val) => setState(() {}),
                      validator: (val) => val == null || val.trim().length < 16
                          ? (isEn
                              ? 'Enter a valid 16-digit card'
                              : '16 haneli geçerli kart numarası giriniz')
                          : null,
                      decoration: InputDecoration(
                        labelText: AppStrings.cardNumber(isEn),
                        prefixIcon: const Icon(Icons.credit_card),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Kart Sahibi
                    TextFormField(
                      controller: _holderController,
                      onChanged: (val) => setState(() {}),
                      validator: (val) => val == null || val.trim().isEmpty
                          ? AppStrings.fieldRequired(isEn)
                          : null,
                      decoration: InputDecoration(
                        labelText: AppStrings.cardHolder(isEn),
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Son Kullanma Tarihi ve CVV Yan Yana
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _expiryController,
                            keyboardType: TextInputType.datetime,
                            onChanged: (val) => setState(() {}),
                            validator: (val) =>
                                val == null || val.trim().length < 5
                                    ? (isEn ? 'MM/YY format' : 'AA/YY formatı')
                                    : null,
                            decoration: InputDecoration(
                              labelText: AppStrings.cardExpiry(isEn),
                              prefixIcon: const Icon(Icons.calendar_today_outlined),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: TextFormField(
                            controller: _cvvController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            validator: (val) =>
                                val == null || val.trim().length < 3
                                    ? (isEn ? '3 digits' : '3 hane')
                                    : null,
                            decoration: InputDecoration(
                              labelText: AppStrings.cardCvv(isEn),
                              prefixIcon: const Icon(Icons.security_outlined),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // ---------------------------------------------------------
                    // İndirim Kuponu Alanı
                    // ---------------------------------------------------------
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _couponController,
                            textCapitalization: TextCapitalization.characters,
                            decoration: InputDecoration(
                              labelText: AppStrings.couponCode(isEn),
                              hintText: 'ARACEK15 / SOFTITO',
                              prefixIcon: const Icon(Icons.discount_outlined),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: _applyCoupon,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 16),
                          ),
                          child: Text(AppStrings.applyCoupon(isEn)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // ---------------------------------------------------------
                    // Ödeme Özeti Kartı
                    // ---------------------------------------------------------
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildSummaryRow(
                              isEn ? 'Rental Fee' : 'Araç Kiralama Bedeli',
                              '₺${controller.rawRentalPrice}',
                              isDark,
                            ),
                            if (controller.insuranceNotifier.value) ...[
                              const SizedBox(height: 8),
                              _buildSummaryRow(
                                isEn ? 'Comprehensive Insurance' : 'Tam Kasko Güvencesi',
                                '₺${controller.totalInsurancePrice}',
                                isDark,
                              ),
                            ],
                            if (controller.discountPercentNotifier.value > 0) ...[
                              const SizedBox(height: 8),
                              _buildSummaryRow(
                                isEn ? 'Discount' : 'Kupon İndirimi',
                                '-₺${controller.discountAmount}',
                                isDark,
                                isDiscount: true,
                              ),
                            ],
                            const Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppStrings.totalToPay(isEn),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  '₺${controller.totalPrice}',
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
                    ),
                    const SizedBox(height: 24),

                    // ---------------------------------------------------------
                    // Ödemeyi Onayla Butonu
                    // ---------------------------------------------------------
                    ElevatedButton(
                      onPressed: _isProcessing ? null : _submitPayment,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isProcessing
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.black,
                              ),
                            )
                          : Text(
                              AppStrings.payAndRent(isEn),
                              style: const TextStyle(fontSize: 16),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isDark,
      {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isDiscount ? AppColors.success : null,
          ),
        ),
      ],
    );
  }
}
