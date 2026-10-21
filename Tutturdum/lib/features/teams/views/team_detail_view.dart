import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/football_models.dart';
import '../../../data/demo/demo_matches.dart';
import '../../home/widgets/featured_match_card.dart';

/// Takım Detay Ekranı (Sezonun 1. ve 2. Yarı Maç Programı)
class TeamDetailView extends StatefulWidget {
  final TeamModel team;

  const TeamDetailView({super.key, required this.team});

  @override
  State<TeamDetailView> createState() => _TeamDetailViewState();
}

class _TeamDetailViewState extends State<TeamDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<FootballMatch> _teamMatches;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _teamMatches = DemoMatches.getMatchesForTeam(widget.team.id);
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

    final firstHalfMatches = _teamMatches.where((m) => !m.isSecondHalf).toList();
    final secondHalfMatches = _teamMatches.where((m) => m.isSecondHalf).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.team.name),
      ),
      body: Column(
        children: [
          // Takım Özet Kartı
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardSurface : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: (isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent)
                        .withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    widget.team.logoEmoji,
                    style: const TextStyle(fontSize: 26),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.team.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Toplam Maç: ${_teamMatches.length} • Puan: ${widget.team.points}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.team.won}G ${widget.team.drawn}B ${widget.team.lost}M',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'AV: ${widget.team.goalDifference}',
                      style: TextStyle(
                        fontSize: 11,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Sezonun 1. ve 2. Yarı TabBar'ı
          TabBar(
            controller: _tabController,
            indicatorColor: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
            labelColor: isDark ? AppColors.darkPrimaryAccent : AppColors.lightPrimaryAccent,
            unselectedLabelColor: isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText,
            tabs: [
              Tab(text: 'Sezonun İlk Yarısı (${firstHalfMatches.length} Maç)'),
              Tab(text: 'Sezonun İkinci Yarısı (${secondHalfMatches.length} Maç)'),
            ],
          ),

          // Maç Listesi
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // 1. Yarı
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: firstHalfMatches.length,
                  itemBuilder: (context, index) {
                    return FeaturedMatchCard(match: firstHalfMatches[index]);
                  },
                ),
                // 2. Yarı
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: secondHalfMatches.length,
                  itemBuilder: (context, index) {
                    return FeaturedMatchCard(match: secondHalfMatches[index]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
