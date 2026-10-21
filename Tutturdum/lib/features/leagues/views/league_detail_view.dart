import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/football_models.dart';
import '../../../data/demo/demo_teams.dart';
import '../../../data/demo/demo_matches.dart';
import '../../teams/views/team_detail_view.dart';
import '../../home/widgets/featured_match_card.dart';

/// Lig Detay Ekranı (Puan Tablosu & Maç Programı)
class LeagueDetailView extends StatefulWidget {
  final LeagueModel league;

  const LeagueDetailView({super.key, required this.league});

  @override
  State<LeagueDetailView> createState() => _LeagueDetailViewState();
}

class _LeagueDetailViewState extends State<LeagueDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<TeamModel> _standings;
  late List<FootballMatch> _matches;
  int _selectedWeek = 25; // Varsayılan aktif bülten haftası

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _standings = DemoTeams.getTeamsForLeague(widget.league.id);
    _matches = DemoMatches.getMatchesForLeague(widget.league.id);

    // Eğer bülten haftasında maç yoksa ilk maçın haftasını al
    if (_matches.isNotEmpty && !_matches.any((m) => m.week == _selectedWeek)) {
      _selectedWeek = _matches.first.week;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final weekMatches = _matches.where((m) => m.week == _selectedWeek).toList();
    final availableWeeks = _matches.map((m) => m.week).toSet().toList()..sort();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(widget.league.logoEmoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.league.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
          labelColor: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
          unselectedLabelColor: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
          tabs: const [
            Tab(icon: Icon(Icons.leaderboard_outlined, size: 20), text: 'Puan Tablosu'),
            Tab(icon: Icon(Icons.sports_soccer_outlined, size: 20), text: 'Maçlar & Oranlar'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 1. Sekme: Puan Tablosu
          _buildStandingsTab(theme, isDark),

          // 2. Sekme: Fikstür ve Maçlar
          _buildMatchesTab(theme, isDark, weekMatches, availableWeeks),
        ],
      ),
    );
  }

  Widget _buildStandingsTab(ThemeData theme, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.league.id == 'super_lig')
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF13221B) : const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: (isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent)
                      .withValues(alpha: 0.3),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.star, color: AppColors.gold, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Süper Lig Özel Şartı: Beşiktaş lider, Galatasaray 0 puanla son sıradadır.',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

          // Tablo Başlığı
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardSurface : const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                SizedBox(width: 26, child: Text('#', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                Expanded(child: Text('Takım', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                SizedBox(width: 26, child: Text('O', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                SizedBox(width: 26, child: Text('G', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                SizedBox(width: 26, child: Text('B', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                SizedBox(width: 26, child: Text('M', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                SizedBox(width: 32, child: Text('AV', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                SizedBox(width: 32, child: Text('P', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.darkPrimaryAccent))),
              ],
            ),
          ),
          const SizedBox(height: 6),

          // Takım Satırları
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _standings.length,
            itemBuilder: (context, index) {
              final team = _standings[index];
              final rank = index + 1;
              final isLeader = rank == 1;
              final isLast = rank == _standings.length;

              Color rankColor = isDark ? Colors.white70 : Colors.black87;
              if (isLeader) rankColor = AppColors.gold;
              if (isLast && widget.league.id == 'super_lig') rankColor = Colors.redAccent;

              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => TeamDetailView(team: team)),
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                    color: isLeader
                        ? (isDark ? AppColors.darkPrimaryAccent.withValues(alpha: 0.1) : const Color(0xFFF0FDF4))
                        : (index % 2 == 0
                            ? Colors.transparent
                            : (isDark ? AppColors.darkCardSurface.withValues(alpha: 0.5) : const Color(0xFFF8FAFC))),
                    borderRadius: BorderRadius.circular(8),
                    border: isLeader
                        ? Border.all(color: AppColors.gold.withValues(alpha: 0.4))
                        : (isLast && widget.league.id == 'super_lig'
                            ? Border.all(color: Colors.red.withValues(alpha: 0.3))
                            : null),
                  ),
                  child: Row(
                    children: [
                      // Sıra
                      SizedBox(
                        width: 26,
                        child: Text(
                          '$rank',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: rankColor,
                          ),
                        ),
                      ),
                      // Takım Adı & Logo
                      Expanded(
                        child: Row(
                          children: [
                            Text(team.logoEmoji, style: const TextStyle(fontSize: 14)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                team.name,
                                style: TextStyle(
                                  fontWeight: isLeader ? FontWeight.bold : FontWeight.w600,
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // İstatistikler
                      SizedBox(width: 26, child: Text('${team.played}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12))),
                      SizedBox(width: 26, child: Text('${team.won}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12))),
                      SizedBox(width: 26, child: Text('${team.drawn}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12))),
                      SizedBox(width: 26, child: Text('${team.lost}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12))),
                      SizedBox(width: 32, child: Text('${team.goalDifference}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12))),
                      SizedBox(
                        width: 32,
                        child: Text(
                          '${team.points}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: isLeader ? AppColors.gold : (isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMatchesTab(
    ThemeData theme,
    bool isDark,
    List<FootballMatch> weekMatches,
    List<int> availableWeeks,
  ) {
    return Column(
      children: [
        // Hafta Seçim Şeridi
        if (availableWeeks.isNotEmpty)
          Container(
            height: 48,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: availableWeeks.length,
              itemBuilder: (context, index) {
                final w = availableWeeks[index];
                final isSelected = w == _selectedWeek;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text('Hafta $w'),
                    selected: isSelected,
                    selectedColor: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedWeek = w);
                      }
                    },
                  ),
                );
              },
            ),
          ),

        // Seçilen Haftanın Maçları
        Expanded(
          child: weekMatches.isEmpty
              ? const Center(child: Text('Bu hafta için maç bulunamadı.'))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: weekMatches.length,
                  itemBuilder: (context, index) {
                    return FeaturedMatchCard(match: weekMatches[index]);
                  },
                ),
        ),
      ],
    );
  }
}
