import 'package:flutter/material.dart';
import '../../../data/models/football_models.dart';
import '../../../data/models/coupon_models.dart';
import '../../../features/coupon_cart/controllers/coupon_cart_controller.dart';
import '../../../core/widgets/odds_button.dart';
import '../../matches/views/match_odds_view.dart';
import '../../../core/constants/app_colors.dart';

/// Öne Çıkan Maç Kartı
class FeaturedMatchCard extends StatelessWidget {
  final FootballMatch match;

  const FeaturedMatchCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cart = CouponCartController.instance;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => MatchOddsView(match: match)),
          );
        },
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Üst Bilgi: Hafta, Durum ve Tüm Oranlar Butonu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent)
                          .withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Hafta ${match.week} • ${match.status}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Tüm Oranlar (15+)',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.darkSecondaryAccent : AppColors.lightSecondaryAccent,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 11,
                        color: isDark ? AppColors.darkSecondaryAccent : AppColors.lightSecondaryAccent,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Takımlar ve Maç Görünümü
              Row(
                children: [
                  // Ev Sahibi
                  Expanded(
                    child: Row(
                      children: [
                        const Text('⚽', style: TextStyle(fontSize: 18)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            match.homeTeamName,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'VS',
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  // Deplasman
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            match.awayTeamName,
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('⚽', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Hızlı Bahis Oran Butonları (1, X, 2)
              AnimatedBuilder(
                animation: cart,
                builder: (context, _) {
                  final is1Selected = cart.isSelected(match.id, 'Maç Sonucu', '1');
                  final isXSelected = cart.isSelected(match.id, 'Maç Sonucu', 'X');
                  final is2Selected = cart.isSelected(match.id, 'Maç Sonucu', '2');

                  return Row(
                    children: [
                      Expanded(
                        child: OddsButton(
                          label: 'MS 1',
                          odds: match.odds.ms1,
                          isSelected: is1Selected,
                          onTap: () {
                            cart.toggleSelection(CouponSelection(
                              id: '${match.id}_ms_1',
                              matchId: match.id,
                              homeTeam: match.homeTeamName,
                              awayTeam: match.awayTeamName,
                              leagueName: 'Bülten',
                              marketName: 'Maç Sonucu',
                              selectionName: '1',
                              odds: match.odds.ms1,
                            ));
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OddsButton(
                          label: 'MS X',
                          odds: match.odds.msX,
                          isSelected: isXSelected,
                          onTap: () {
                            cart.toggleSelection(CouponSelection(
                              id: '${match.id}_ms_x',
                              matchId: match.id,
                              homeTeam: match.homeTeamName,
                              awayTeam: match.awayTeamName,
                              leagueName: 'Bülten',
                              marketName: 'Maç Sonucu',
                              selectionName: 'X',
                              odds: match.odds.msX,
                            ));
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OddsButton(
                          label: 'MS 2',
                          odds: match.odds.ms2,
                          isSelected: is2Selected,
                          onTap: () {
                            cart.toggleSelection(CouponSelection(
                              id: '${match.id}_ms_2',
                              matchId: match.id,
                              homeTeam: match.homeTeamName,
                              awayTeam: match.awayTeamName,
                              leagueName: 'Bülten',
                              marketName: 'Maç Sonucu',
                              selectionName: '2',
                              odds: match.odds.ms2,
                            ));
                          },
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
    );
  }
}
