import 'package:flutter/material.dart';
import '../controllers/app_controller.dart';
import '../core/constants/app_colors.dart';
import '../data/demo_data.dart';
import '../widgets/app_button.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _amountController = TextEditingController(text: '15000');
  final TextEditingController _noteController = TextEditingController();
  String _selectedRecipient = DemoData.demoRecipients.first;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _handleTransfer() {
    final double? amountTl = double.tryParse(_amountController.text.trim());
    if (amountTl == null || amountTl <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen geçerli bir transfer tutarı giriniz!'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    final int kurus = (amountTl * 100).round();
    final currentBalance = AppController.instance.balance.value;

    if (currentBalance < kurus) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transfer için yetersiz bakiye! Lütfen cüzdana bakiye ekleyin.'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    final success = AppController.instance.transferMoney(
      kurus,
      _selectedRecipient,
      _noteController.text.trim(),
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${amountTl.toStringAsFixed(0)} ₺ "$_selectedRecipient" hesabına başarıyla transfer edildi!',
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
        title: const Text('Para Transferi'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bakiye Durum Kartı
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kullanılabilir Sanal Bakiye:',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    Text(
                      AppController.instance.formattedBalance,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.primaryMint
                            : AppColors.primaryEmerald,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Alıcı Seçimi
              Text(
                'Alıcı Demo Hesap',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkCardVariant
                      : AppColors.lightCardVariant,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedRecipient,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    dropdownColor:
                        isDark ? AppColors.darkCard : AppColors.lightCard,
                    items: DemoData.demoRecipients.map((recipient) {
                      return DropdownMenuItem<String>(
                        value: recipient,
                        child: Text(
                          recipient,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedRecipient = val;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Transfer Tutarı
              Text(
                'Gönderilecek Tutar (TL)',
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
              const SizedBox(height: 20),

              // Açıklama Notu
              Text(
                'Transfer Notu (Opsiyonel)',
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
                controller: _noteController,
                decoration: const InputDecoration(
                  hintText: 'Örn: Tohum sermaye ön ödemesi',
                  prefixIcon: Icon(Icons.edit_note_rounded, size: 20),
                ),
              ),
              const SizedBox(height: 36),

              AppButton(
                text: 'Transferi Onayla ve Gönder',
                icon: Icons.send_rounded,
                onPressed: _handleTransfer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
