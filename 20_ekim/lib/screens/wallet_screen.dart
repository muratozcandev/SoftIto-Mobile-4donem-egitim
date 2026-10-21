import 'package:flutter/material.dart';
import '../controllers/app_controller.dart';
import '../core/constants/app_colors.dart';
import '../models/transaction_model.dart';
import 'add_money_screen.dart';
import 'transfer_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cüzdan & Bakiye'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Bakiye Başlık Kartı
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: LinearGradient(
                    colors: isDark
                        ? [
                            const Color(0xFF141C2F),
                            const Color(0xFF0D253A),
                          ]
                        : [
                            Colors.white,
                            const Color(0xFFE6FFFA),
                          ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF1E3A5F)
                        : const Color(0xFFA7F3D0),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Toplam Sanal Varlık',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ValueListenableBuilder<int>(
                      valueListenable: AppController.instance.balance,
                      builder: (context, balanceKurus, _) {
                        return Text(
                          AppController.instance.formattedBalance,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 18),

                    // Aksiyon Butonları (Para Ekle & Transfer)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const AddMoneyScreen(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.add_rounded, size: 18),
                            label: const Text('Para Ekle'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const TransferScreen(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.send_rounded, size: 18),
                            label: const Text('Transfer'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // İşlem Geçmişi Başlığı
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'İşlem Geçmişi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                  ValueListenableBuilder<List<TransactionModel>>(
                    valueListenable: AppController.instance.transactions,
                    builder: (context, txs, _) {
                      return Text(
                        '${txs.length} İşlem',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? AppColors.darkTextMuted
                              : AppColors.lightTextMuted,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // İşlem Geçmişi Listesi
            Expanded(
              child: ValueListenableBuilder<List<TransactionModel>>(
                valueListenable: AppController.instance.transactions,
                builder: (context, transactions, _) {
                  if (transactions.isEmpty) {
                    return Center(
                      child: Text(
                        'Henüz bir hesap hareketi bulunmuyor.',
                        style: TextStyle(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    itemCount: transactions.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final tx = transactions[index];
                      Color txColor;
                      if (tx.isPositive) {
                        txColor = isDark
                            ? AppColors.primaryMint
                            : AppColors.primaryEmerald;
                      } else {
                        txColor = tx.type == TransactionType.investment
                            ? AppColors.accentCyan
                            : isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary;
                      }

                      return Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.darkCard
                              : AppColors.lightCard,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: txColor.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                tx.icon,
                                color: txColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tx.title,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? AppColors.darkTextPrimary
                                          : AppColors.lightTextPrimary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    tx.description,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: isDark
                                          ? AppColors.darkTextSecondary
                                          : AppColors.lightTextSecondary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    tx.formattedDate,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isDark
                                          ? AppColors.darkTextMuted
                                          : AppColors.lightTextMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              tx.formattedAmount,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: txColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
