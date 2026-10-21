import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/odds_button.dart';
import '../../../data/models/football_models.dart';
import '../../../data/models/coupon_models.dart';
import '../../coupon_cart/controllers/coupon_cart_controller.dart';

/// Maç Detay ve Tüm Oranlar Ekranı
class MatchOddsView extends StatelessWidget {
  final FootballMatch match;

  const MatchOddsView({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cart = CouponCartController.instance;
    final odds = match.odds;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maç Oranları'),
      ),
      body: Column(
        children: [
          // Maç Skor / Başlık Başlığı
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardSurface : Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                ),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Hafta ${match.week} • ${match.status}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text('⚽', style: TextStyle(fontSize: 28)),
                          const SizedBox(height: 6),
                          Text(
                            match.homeTeamName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: (isDark ? AppColors.darkDivider : const Color(0xFFE2E8F0)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'VS',
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text('⚽', style: TextStyle(fontSize: 28)),
                          const SizedBox(height: 6),
                          Text(
                            match.awayTeamName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Oran Grupları
          Expanded(
            child: AnimatedBuilder(
              animation: cart,
              builder: (context, _) {
                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  children: [
                    // 1. Maç Sonucu
                    _buildOddsSection(
                      context: context,
                      title: 'Maç Sonucu',
                      icon: Icons.sports,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: OddsButton(
                                label: 'MS 1 (Ev)',
                                odds: odds.ms1,
                                isSelected: cart.isSelected(match.id, 'Maç Sonucu', '1'),
                                onTap: () => _toggle(cart, 'Maç Sonucu', '1', odds.ms1),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OddsButton(
                                label: 'MS X (Beraberlik)',
                                odds: odds.msX,
                                isSelected: cart.isSelected(match.id, 'Maç Sonucu', 'X'),
                                onTap: () => _toggle(cart, 'Maç Sonucu', 'X', odds.msX),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OddsButton(
                                label: 'MS 2 (Deplasman)',
                                odds: odds.ms2,
                                isSelected: cart.isSelected(match.id, 'Maç Sonucu', '2'),
                                onTap: () => _toggle(cart, 'Maç Sonucu', '2', odds.ms2),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // 2. Çifte Şans
                    _buildOddsSection(
                      context: context,
                      title: 'Çifte Şans',
                      icon: Icons.alt_route,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: OddsButton(
                                label: '1X (Ev veya Beraberlik)',
                                odds: odds.cs1X,
                                isSelected: cart.isSelected(match.id, 'Çifte Şans', '1X'),
                                onTap: () => _toggle(cart, 'Çifte Şans', '1X', odds.cs1X),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OddsButton(
                                label: '12 (Ev veya Dep)',
                                odds: odds.cs12,
                                isSelected: cart.isSelected(match.id, 'Çifte Şans', '12'),
                                onTap: () => _toggle(cart, 'Çifte Şans', '12', odds.cs12),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OddsButton(
                                label: 'X2 (Dep veya Beraberlik)',
                                odds: odds.csX2,
                                isSelected: cart.isSelected(match.id, 'Çifte Şans', 'X2'),
                                onTap: () => _toggle(cart, 'Çifte Şans', 'X2', odds.csX2),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // 3. Handikaplı Maç Sonucu (0-1)
                    _buildOddsSection(
                      context: context,
                      title: 'Handikaplı Maç Sonucu (Deplasman +1 Gol Avansı)',
                      icon: Icons.shield,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: OddsButton(
                                label: 'H 1 (-1)',
                                odds: odds.h1,
                                isSelected: cart.isSelected(match.id, 'Handikap (0-1)', 'H1'),
                                onTap: () => _toggle(cart, 'Handikap (0-1)', 'H1', odds.h1),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OddsButton(
                                label: 'H X (0)',
                                odds: odds.hX,
                                isSelected: cart.isSelected(match.id, 'Handikap (0-1)', 'HX'),
                                onTap: () => _toggle(cart, 'Handikap (0-1)', 'HX', odds.hX),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OddsButton(
                                label: 'H 2 (+1)',
                                odds: odds.h2,
                                isSelected: cart.isSelected(match.id, 'Handikap (0-1)', 'H2'),
                                onTap: () => _toggle(cart, 'Handikap (0-1)', 'H2', odds.h2),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // 4. Karşılıklı Gol
                    _buildOddsSection(
                      context: context,
                      title: 'Karşılıklı Gol (KG)',
                      icon: Icons.compare_arrows,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: OddsButton(
                                label: 'KG Var',
                                odds: odds.bttsYes,
                                isSelected: cart.isSelected(match.id, 'Karşılıklı Gol', 'Var'),
                                onTap: () => _toggle(cart, 'Karşılıklı Gol', 'Var', odds.bttsYes),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OddsButton(
                                label: 'KG Yok',
                                odds: odds.bttsNo,
                                isSelected: cart.isSelected(match.id, 'Karşılıklı Gol', 'Yok'),
                                onTap: () => _toggle(cart, 'Karşılıklı Gol', 'Yok', odds.bttsNo),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // 5. Toplam Gol Alt / Üst
                    _buildOddsSection(
                      context: context,
                      title: 'Toplam Gol Alt / Üst',
                      icon: Icons.unfold_more,
                      children: [
                        // 1.5 Alt / Üst
                        Row(
                          children: [
                            Expanded(
                              child: OddsButton(
                                label: '1.5 Alt',
                                odds: odds.under15,
                                isSelected: cart.isSelected(match.id, '1.5 Gol', 'Alt'),
                                onTap: () => _toggle(cart, '1.5 Gol', 'Alt', odds.under15),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OddsButton(
                                label: '1.5 Üst',
                                odds: odds.over15,
                                isSelected: cart.isSelected(match.id, '1.5 Gol', 'Üst'),
                                onTap: () => _toggle(cart, '1.5 Gol', 'Üst', odds.over15),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // 2.5 Alt / Üst
                        Row(
                          children: [
                            Expanded(
                              child: OddsButton(
                                label: '2.5 Alt',
                                odds: odds.under25,
                                isSelected: cart.isSelected(match.id, '2.5 Gol', 'Alt'),
                                onTap: () => _toggle(cart, '2.5 Gol', 'Alt', odds.under25),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OddsButton(
                                label: '2.5 Üst',
                                odds: odds.over25,
                                isSelected: cart.isSelected(match.id, '2.5 Gol', 'Üst'),
                                onTap: () => _toggle(cart, '2.5 Gol', 'Üst', odds.over25),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // 3.5 Alt / Üst
                        Row(
                          children: [
                            Expanded(
                              child: OddsButton(
                                label: '3.5 Alt',
                                odds: odds.under35,
                                isSelected: cart.isSelected(match.id, '3.5 Gol', 'Alt'),
                                onTap: () => _toggle(cart, '3.5 Gol', 'Alt', odds.under35),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OddsButton(
                                label: '3.5 Üst',
                                odds: odds.over35,
                                isSelected: cart.isSelected(match.id, '3.5 Gol', 'Üst'),
                                onTap: () => _toggle(cart, '3.5 Gol', 'Üst', odds.over35),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // 6. İlk Yarı Sonucu
                    _buildOddsSection(
                      context: context,
                      title: 'İlk Yarı Sonucu',
                      icon: Icons.timer_outlined,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: OddsButton(
                                label: 'İY 1',
                                odds: odds.ht1,
                                isSelected: cart.isSelected(match.id, 'İlk Yarı Sonucu', '1'),
                                onTap: () => _toggle(cart, 'İlk Yarı Sonucu', '1', odds.ht1),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OddsButton(
                                label: 'İY X',
                                odds: odds.htX,
                                isSelected: cart.isSelected(match.id, 'İlk Yarı Sonucu', 'X'),
                                onTap: () => _toggle(cart, 'İlk Yarı Sonucu', 'X', odds.htX),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OddsButton(
                                label: 'İY 2',
                                odds: odds.ht2,
                                isSelected: cart.isSelected(match.id, 'İlk Yarı Sonucu', '2'),
                                onTap: () => _toggle(cart, 'İlk Yarı Sonucu', '2', odds.ht2),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // 7. Özel Bahisler (Penaltı & Kırmızı Kart)
                    _buildOddsSection(
                      context: context,
                      title: 'Özel Maç Olayları',
                      icon: Icons.flag_outlined,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: OddsButton(
                                label: 'Penaltı Olur',
                                odds: odds.penaltyYes,
                                isSelected: cart.isSelected(match.id, 'Penaltı', 'Evet'),
                                onTap: () => _toggle(cart, 'Penaltı', 'Evet', odds.penaltyYes),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OddsButton(
                                label: 'Penaltı Olmaz',
                                odds: odds.penaltyNo,
                                isSelected: cart.isSelected(match.id, 'Penaltı', 'Hayır'),
                                onTap: () => _toggle(cart, 'Penaltı', 'Hayır', odds.penaltyNo),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: OddsButton(
                                label: 'Kırmızı Kart Olur',
                                odds: odds.redCardYes,
                                isSelected: cart.isSelected(match.id, 'Kırmızı Kart', 'Evet'),
                                onTap: () => _toggle(cart, 'Kırmızı Kart', 'Evet', odds.redCardYes),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OddsButton(
                                label: 'Kırmızı Kart Olmaz',
                                odds: odds.redCardNo,
                                isSelected: cart.isSelected(match.id, 'Kırmızı Kart', 'Hayır'),
                                onTap: () => _toggle(cart, 'Kırmızı Kart', 'Hayır', odds.redCardNo),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _toggle(CouponCartController cart, String marketName, String selectionName, double odds) {
    cart.toggleSelection(CouponSelection(
      id: '${match.id}_${marketName}_$selectionName',
      matchId: match.id,
      homeTeam: match.homeTeamName,
      awayTeam: match.awayTeamName,
      leagueName: 'Bülten',
      marketName: marketName,
      selectionName: selectionName,
      odds: odds,
    ));
  }

  Widget _buildOddsSection({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 16,
                  color: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}
