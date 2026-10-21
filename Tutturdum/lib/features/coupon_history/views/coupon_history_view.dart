import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../data/models/coupon_models.dart';
import '../../../data/repositories/coupon_repository.dart';

/// Kupon Geçmişi Ekranı
class CouponHistoryView extends StatelessWidget {
  const CouponHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kupon Geçmişi'),
      ),
      body: ValueListenableBuilder<List<CouponModel>>(
        valueListenable: CouponRepository.instance.couponsNotifier,
        builder: (context, coupons, _) {
          if (coupons.isEmpty) {
            return const EmptyState(
              icon: Icons.history,
              title: 'Henüz Kupon Bulunmuyor',
              message: 'Oynadığınız simülasyon kuponları burada listelenir ve cihazınızda saklanır.',
            );
          }

          final dateFormat = DateFormat('dd.MM.yyyy HH:mm');

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: coupons.length,
            itemBuilder: (context, index) {
              final coupon = coupons[index];
              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 12),
                child: Theme(
                  data: theme.copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: (isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent)
                                    .withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.receipt_long,
                                size: 20,
                                color: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  coupon.id,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                Text(
                                  dateFormat.format(coupon.createdAt),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: theme.textTheme.bodyMedium?.color,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.gold.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            coupon.status,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.gold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${coupon.selections.length} Maç • Oran: ${CurrencyFormatter.formatOdds(coupon.totalOdds)}',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Yatırılan: ${CurrencyFormatter.format(coupon.stake)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    children: [
                      const Divider(),
                      const SizedBox(height: 6),
                      // Kupondaki Maçlar Listesi
                      ...coupon.selections.map((sel) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${sel.homeTeam} - ${sel.awayTeam}',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                    ),
                                    Text(
                                      '${sel.marketName}: ${sel.selectionName}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: isDark ? AppColors.darkSecondaryAccent : AppColors.lightSecondaryAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                CurrencyFormatter.formatOdds(sel.odds),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent)
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Olası Brüt Dönüş:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            Text(
                              CurrencyFormatter.format(coupon.possibleWin),
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                color: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
