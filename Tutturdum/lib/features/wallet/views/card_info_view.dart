import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/repositories/wallet_repository.dart';

/// Kart Bilgileri ve Sanal Bakiye Yükleme Simülasyonu
class CardInfoView extends StatefulWidget {
  const CardInfoView({super.key});

  @override
  State<CardInfoView> createState() => _CardInfoViewState();
}

class _CardInfoViewState extends State<CardInfoView> {
  final _formKey = GlobalKey<FormState>();
  final _holderController = TextEditingController(text: 'Ahmet Yılmaz (Demo)');
  final _cardNumberController = TextEditingController(text: '4532 •••• •••• 9821');
  final _expiryController = TextEditingController(text: '12/28');
  final _cvvController = TextEditingController(text: '849');
  final _amountController = TextEditingController(text: '500');

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _holderController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _handleDeposit() async {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.tryParse(_amountController.text.replaceAll(',', '.'));
    if (amount == null || amount <= 0) {
      setState(() => _errorMessage = 'Geçerli bir yükleme tutarı giriniz.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await Future.delayed(const Duration(milliseconds: 600)); // Simülasyon gecikmesi
      await WalletRepository.instance.deposit(amount);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${CurrencyFormatter.format(amount)} sanal bakiye başarıyla yüklendi!'),
          backgroundColor: AppColors.success,
        ),
      );

      Navigator.of(context).pop();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bakiye Yükle (Demo)'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Güvenlik & Simülasyon Uyarısı
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: (isDark ? AppColors.darkSecondaryAccent : AppColors.lightSecondaryAccent)
                        .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (isDark ? AppColors.darkSecondaryAccent : AppColors.lightSecondaryAccent)
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.security, color: AppColors.darkSecondaryAccent, size: 24),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Sanal Bakiye Simülasyonu: Gerçek kart bilgilerinizi girmeyiniz. Bu ekran yalnızca arayüz ve demo bakiye yükleme testleri içindir.',
                          style: TextStyle(fontSize: 12, height: 1.3),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // Görsel Demo Kartı
                Container(
                  height: 180,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'TUTTURDUM DEMO CARD',
                            style: TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 1),
                          ),
                          Text(
                            '₺ DEMO',
                            style: TextStyle(
                              color: AppColors.darkPrimaryAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        '•••• •••• •••• 9821',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('AHMET YILMAZ', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          Text('12 / 28', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                if (_errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                    ),
                  ),
                ],

                // Kart Sahibi
                AppTextField(
                  controller: _holderController,
                  label: 'Kart Sahibi Adı Soyadı',
                  prefixIcon: Icons.person_outline,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) return 'Kart sahibi giriniz';
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // Kart Numarası
                AppTextField(
                  controller: _cardNumberController,
                  label: 'Kart Numarası (Örnek)',
                  prefixIcon: Icons.credit_card,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) return 'Kart numarası giriniz';
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // Son Kullanma & CVV
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _expiryController,
                        label: 'Son Kullanma Tarihi',
                        hint: 'AA/YY',
                        prefixIcon: Icons.calendar_today_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppTextField(
                        controller: _cvvController,
                        label: 'CVV',
                        hint: '3 hane',
                        prefixIcon: Icons.lock_outline,
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Hızlı Yükleme Tutar Çipleri
                const Text(
                  'Yüklenecek Sanal Tutar (₺)',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [100, 250, 500, 1000, 2500].map((amt) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: ActionChip(
                        label: Text('$amt ₺'),
                        onPressed: () {
                          _amountController.text = '$amt';
                        },
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),

                // Tutar Girişi
                AppTextField(
                  controller: _amountController,
                  label: 'Özel Tutar Giriniz',
                  prefixIcon: Icons.currency_lira,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) return 'Tutar giriniz';
                    final parsed = double.tryParse(val.replaceAll(',', '.'));
                    if (parsed == null || parsed <= 0) return 'Geçerli bir tutar giriniz';
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Yükle Butonu
                AppButton(
                  label: 'Sanal Bakiyeyi Yükle',
                  icon: Icons.check_circle_outline,
                  isLoading: _isLoading,
                  onPressed: _handleDeposit,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
