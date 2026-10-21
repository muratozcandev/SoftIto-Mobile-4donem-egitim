import 'package:flutter/material.dart';
import '../controllers/app_controller.dart';
import '../core/constants/app_colors.dart';
import '../models/business_idea_model.dart';
import '../widgets/app_button.dart';
import 'add_money_screen.dart';

class BusinessDetailScreen extends StatefulWidget {
  final BusinessIdeaModel idea;

  const BusinessDetailScreen({super.key, required this.idea});

  @override
  State<BusinessDetailScreen> createState() => _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends State<BusinessDetailScreen> {
  late BusinessIdeaModel _currentIdea;

  @override
  void initState() {
    super.initState();
    _currentIdea = widget.idea;
  }

  void _showContractDialog() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currentBalance = AppController.instance.balance.value;
    final hasEnoughBalance = currentBalance >= _currentIdea.investmentAmount;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.darkCard : AppColors.lightCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Üst Çizgi
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.primaryMint.withOpacity(0.15)
                          : AppColors.primaryEmerald.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.description_rounded,
                      color: isDark
                          ? AppColors.primaryMint
                          : AppColors.primaryEmerald,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Sanal Yatırım Sözleşmesi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.4,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Sözleşme Metni Kutusu
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkCardVariant
                      : AppColors.lightCardVariant,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Simülasyon Yatırım Protokolü',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.primaryMint
                            : AppColors.primaryEmerald,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'İşbu sanal yatırım protokolü ile "${_currentIdea.title}" projesine ${_currentIdea.formattedAmount} değerinde tohum sermaye aktarımı onaylanacaktır. Bu işlem bir eğitim ve simülasyon adımıdır; gerçek mali yükümlülük içermez.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.45,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(height: 1),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Yatırım Bedeli:',
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                        Text(
                          _currentIdea.formattedAmount,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mevcut Sanal Bakiye:',
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
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: hasEnoughBalance
                                ? (isDark
                                    ? AppColors.primaryMint
                                    : AppColors.primaryEmerald)
                                : AppColors.danger,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              if (!hasEnoughBalance) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.danger.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline_rounded,
                          color: AppColors.danger, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Bakiyeniz bu yatırım için yetersiz. Lütfen cüzdanınıza sanal bakiye ekleyin.',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.danger,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                AppButton(
                  text: 'Bakiye Ekle',
                  icon: Icons.add_circle_outline_rounded,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AddMoneyScreen(),
                      ),
                    );
                  },
                ),
              ] else ...[
                AppButton(
                  text: 'Sözleşmeyi Onayla ve Yatırımı Yap',
                  icon: Icons.draw_rounded,
                  onPressed: () {
                    Navigator.of(context).pop();
                    _executeInvestment();
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _executeInvestment() {
    final success = AppController.instance.makeInvestment(_currentIdea);

    if (success) {
      setState(() {
        _currentIdea = _currentIdea.copyWith(
          isInvested: true,
          fundingPercentage: 1.0,
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Tebrikler! "${_currentIdea.title}" projesine başarıyla ${_currentIdea.formattedAmount} yatırım yaptınız!',
          ),
          backgroundColor: AppColors.primaryEmerald,
          duration: const Duration(seconds: 4),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Yatırım gerçekleştirilemedi! Bakiye yetersiz.'),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Girişim Detayı'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Başlık ve İkon Alanı
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.primaryMint.withOpacity(0.15)
                          : AppColors.primaryEmerald.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      _currentIdea.icon,
                      size: 32,
                      color: isDark
                          ? AppColors.primaryMint
                          : AppColors.primaryEmerald,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkCardVariant
                                : AppColors.lightCardVariant,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _currentIdea.category,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? AppColors.accentCyan
                                  : AppColors.primaryEmeraldDark,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _currentIdea.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Kurucu ve Yatırım Durum Kartı
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Girişimci / Kurucu',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? AppColors.darkTextMuted
                                : AppColors.lightTextMuted,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _currentIdea.founderName,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 36,
                      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    ),
                    Column(
                      children: [
                        Text(
                          'Hedef Fonlama',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? AppColors.darkTextMuted
                                : AppColors.lightTextMuted,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _currentIdea.formattedAmount,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: isDark
                                ? AppColors.primaryMint
                                : AppColors.primaryEmerald,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Fikir Açıklaması
              _buildSectionTitle('Girişim Hakkında', isDark),
              const SizedBox(height: 8),
              Text(
                _currentIdea.fullDescription,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 20),

              // İş Modeli
              _buildSectionTitle('Gelir ve İş Modeli', isDark),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkCardVariant
                      : AppColors.lightCardVariant,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  _currentIdea.businessModel,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Hedef Kitle
              _buildSectionTitle('Hedef Kitle ve Pazar', isDark),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkCardVariant
                      : AppColors.lightCardVariant,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  _currentIdea.targetAudience,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 36),

              // Buton: Sözleşmeyi İmzala
              if (_currentIdea.isInvested)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.primaryMint.withOpacity(0.15)
                        : AppColors.primaryEmerald.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark
                          ? AppColors.primaryMint
                          : AppColors.primaryEmerald,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        color: isDark
                            ? AppColors.primaryMint
                            : AppColors.primaryEmerald,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Bu Girişime Yatırım Yaptınız',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.primaryMint
                              : AppColors.primaryEmerald,
                        ),
                      ),
                    ],
                  ),
                )
              else
                AppButton(
                  text: 'Sözleşmeyi İmzala (${_currentIdea.formattedAmount})',
                  icon: Icons.edit_document,
                  onPressed: _showContractDialog,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.2,
        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
      ),
    );
  }
}
