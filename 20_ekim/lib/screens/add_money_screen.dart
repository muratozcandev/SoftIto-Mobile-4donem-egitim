import 'package:flutter/material.dart';
import '../controllers/app_controller.dart';
import '../core/constants/app_colors.dart';
import '../widgets/app_button.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final TextEditingController _amountController = TextEditingController(text: '25000');
  String _selectedSource = 'Sanal Kredi Kartı (Mastercard •• 4242)';

  final List<String> _sources = [
    'Sanal Kredi Kartı (Mastercard •• 4242)',
    'Sanal Havale / EFT (Demo Garanti)',
    'Demo Kripto Fon Aktarımı (USDT)',
    'Tohum Hibe Fonu Teşviki',
  ];

  final List<int> _quickAmounts = [10000, 25000, 50000, 100000];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _handleAddMoney() {
    final double? amountTl = double.tryParse(_amountController.text.trim());
    if (amountTl == null || amountTl <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen geçerli bir tutar giriniz!'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    final int kurus = (amountTl * 100).round();
    final success = AppController.instance.addMoney(kurus, source: _selectedSource);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${amountTl.toStringAsFixed(0)} ₺ sanal bakiyenize başarıyla eklendi!',
          ),
          backgroundColor: AppColors.primaryEmerald,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sanal Bakiye Yükle'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bilgi Kartı
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.primaryMint.withOpacity(0.15)
                            : AppColors.primaryEmerald.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.info_outline_rounded,
                        color: isDark
                            ? AppColors.primaryMint
                            : AppColors.primaryEmerald,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'Bu bir demo yükleme işlemidir. Gerçek bir banka veya kredi kartı borçlandırması yapılmaz.',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Yüklenecek Tutar
              Text(
                'Yüklenecek Tutar (TL)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    child: Text(
                      '₺',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  hintText: '0',
                ),
              ),
              const SizedBox(height: 14),

              // Hızlı Tutar Seçimi
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _quickAmounts.map((amt) {
                  return ActionChip(
                    label: Text('+${amt.toString().replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (m) => '${m[1]}.',
                        )} ₺'),
                    backgroundColor: isDark
                        ? AppColors.darkCardVariant
                        : AppColors.lightCardVariant,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.primaryMint
                          : AppColors.primaryEmerald,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: isDark
                            ? AppColors.darkBorder
                            : AppColors.lightBorder,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _amountController.text = amt.toString();
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Yükleme Kaynağı
              Text(
                'Demo Kaynak Seçimi',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Material(
                color: isDark
                    ? AppColors.darkCardVariant
                    : AppColors.lightCardVariant,
                borderRadius: BorderRadius.circular(14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
                child: Column(
                  children: _sources.map((source) {
                    final isSelected = source == _selectedSource;
                    return RadioListTile<String>(
                      title: Text(
                        source,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                      value: source,
                      groupValue: _selectedSource,
                      activeColor: isDark
                          ? AppColors.primaryMint
                          : AppColors.primaryEmerald,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _selectedSource = val;
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 36),

              AppButton(
                text: 'Bakiyeyi Hesaba Yükle',
                icon: Icons.add_circle_rounded,
                onPressed: _handleAddMoney,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
