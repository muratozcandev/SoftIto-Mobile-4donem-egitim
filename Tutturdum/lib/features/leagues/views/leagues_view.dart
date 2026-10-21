import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/demo/demo_leagues.dart';
import 'league_detail_view.dart';

/// Ligler Listesi Ekranı (Kupon Oyna sekmesinin başlangıcı)
class LeaguesView extends StatelessWidget {
  const LeaguesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final leagues = DemoLeagues.leagues;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kupon Oyna • Lig Seçimi'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: leagues.length,
        itemBuilder: (context, index) {
          final league = leagues[index];
          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => LeagueDetailView(league: league)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    // Bayrak / Simge Kutusu
                    Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: (isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent)
                            .withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        league.logoEmoji,
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Lig Adı ve Ülke
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  league.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (league.isUefa) ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.gold.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'UEFA',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.gold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${league.country} • ${league.teamCount} Takım',
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Ok Simgesi
                    Icon(
                      Icons.chevron_right,
                      color: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
