import '../models/football_models.dart';
import 'demo_teams.dart';

/// Tutturdum deterministik maç ve oran üretim sistemi
abstract class DemoMatches {
  static final Map<String, List<FootballMatch>> _leagueMatchesCache = {};

  /// Ligdeki tüm maçları getirir (Önbellekten veya oluşturur)
  static List<FootballMatch> getMatchesForLeague(String leagueId) {
    if (_leagueMatchesCache.containsKey(leagueId)) {
      return _leagueMatchesCache[leagueId]!;
    }

    final teams = DemoTeams.getTeamsForLeague(leagueId);
    if (teams.isEmpty) return [];

    final matches = <FootballMatch>[];

    if (leagueId == 'champions_league' ||
        leagueId == 'europa_league' ||
        leagueId == 'conference_league') {
      // UEFA 36 Takımlı Lig Aşaması Formatı (8 maç günü simülasyonu)
      matches.addAll(_generateUefaMatches(leagueId, teams));
    } else {
      // Çift devreli lig sistemi (18 takım -> 34 maç / 20 takım -> 38 maç)
      matches.addAll(_generateRoundRobinMatches(leagueId, teams));
    }

    _leagueMatchesCache[leagueId] = matches;
    return matches;
  }

  /// Belirli bir takımın tüm maç programını (1. ve 2. yarı) getirir
  static List<FootballMatch> getMatchesForTeam(String teamId) {
    final team = DemoTeams.getTeamById(teamId);
    if (team == null) return [];

    final allMatches = getMatchesForLeague(team.leagueId);
    return allMatches.where((m) => m.homeTeamId == teamId || m.awayTeamId == teamId).toList();
  }

  /// Tek bir maçı kimliğine göre bulur
  static FootballMatch? getMatchById(String matchId) {
    for (final matches in _leagueMatchesCache.values) {
      for (final m in matches) {
        if (m.id == matchId) return m;
      }
    }
    // Önbellek boşsa tüm ligleri tara
    for (final league in [
      'super_lig', 'premier_league', 'la_liga', 'serie_a', 'bundesliga',
      'ligue_1', 'liga_portugal', 'eredivisie', 'champions_league', 'europa_league', 'conference_league'
    ]) {
      final list = getMatchesForLeague(league);
      for (final m in list) {
        if (m.id == matchId) return m;
      }
    }
    return null;
  }

  /// Günün bülteni için öne çıkan maçları getirir
  static List<FootballMatch> getFeaturedMatches() {
    final superLig = getMatchesForLeague('super_lig');
    final pl = getMatchesForLeague('premier_league');
    final cl = getMatchesForLeague('champions_league');

    final featured = <FootballMatch>[];

    // Beşiktaş'ın ve derbilerin olduğu maçları öne çıkar
    final bjkMatch = superLig.firstWhere(
      (m) => (m.homeTeamId == 'tr_bjk' || m.awayTeamId == 'tr_bjk') && m.week == 25,
      orElse: () => superLig.first,
    );
    featured.add(bjkMatch);

    if (pl.isNotEmpty) {
      featured.add(pl.firstWhere((m) => m.week == 25, orElse: () => pl.first));
    }
    if (cl.isNotEmpty) {
      featured.add(cl.first);
    }
    if (superLig.length > 2) {
      featured.add(superLig[2]);
    }

    return featured;
  }

  /// Standart Çift Devreli Lig Fikstürü (Round-Robin Algoritması)
  static List<FootballMatch> _generateRoundRobinMatches(String leagueId, List<TeamModel> teams) {
    final matches = <FootballMatch>[];
    final n = teams.length; // 18 veya 20
    final halfRounds = n - 1; // 17 veya 19 hafta
    final matchesPerRound = n ~/ 2;

    final teamIds = List<String>.generate(n, (i) => teams[i].id);

    // 1. YARI (İlk devre)
    for (int round = 0; round < halfRounds; round++) {
      final weekNum = round + 1;
      final baseDate = DateTime(2026, 8, 15).add(Duration(days: round * 7));

      for (int m = 0; m < matchesPerRound; m++) {
        String homeId;
        String awayId;

        if (m == 0) {
          homeId = teamIds[0];
          awayId = teamIds[n - 1 - round];
        } else {
          final first = (round + m) % (n - 1);
          final second = (round + n - 1 - m) % (n - 1);
          homeId = teamIds[first + 1];
          awayId = teamIds[second + 1];
        }

        // Ev sahibi ve deplasman dengesi
        if (round % 2 == 1 && m == 0) {
          final temp = homeId;
          homeId = awayId;
          awayId = temp;
        }

        final homeTeam = DemoTeams.getTeamById(homeId)!;
        final awayTeam = DemoTeams.getTeamById(awayId)!;
        final matchId = '${leagueId}_w${weekNum}_${homeId}_$awayId';

        final odds = _calculateDeterministicOdds(matchId, homeTeam, awayTeam);

        matches.add(FootballMatch(
          id: matchId,
          leagueId: leagueId,
          homeTeamId: homeId,
          homeTeamName: homeTeam.name,
          awayTeamId: awayId,
          awayTeamName: awayTeam.name,
          matchDate: baseDate.add(Duration(hours: 14 + (m % 4) * 2)),
          week: weekNum,
          isSecondHalf: false,
          status: weekNum < 24 ? 'Bitti' : (weekNum == 25 ? 'Bülten' : 'Yakında'),
          odds: odds,
        ));
      }
    }

    // 2. YARI (İkinci devre - Rövanş maçları, sahalar değişir)
    final firstHalfMatches = List<FootballMatch>.from(matches);
    for (final m in firstHalfMatches) {
      final secondHalfWeek = m.week + halfRounds;
      final secondHalfMatchId = '${leagueId}_w${secondHalfWeek}_${m.awayTeamId}_${m.homeTeamId}';
      final baseDate = DateTime(2027, 1, 10).add(Duration(days: (m.week - 1) * 7));

      final homeTeam = DemoTeams.getTeamById(m.awayTeamId)!;
      final awayTeam = DemoTeams.getTeamById(m.homeTeamId)!;

      final odds = _calculateDeterministicOdds(secondHalfMatchId, homeTeam, awayTeam);

      matches.add(FootballMatch(
        id: secondHalfMatchId,
        leagueId: leagueId,
        homeTeamId: homeTeam.id,
        homeTeamName: homeTeam.name,
        awayTeamId: awayTeam.id,
        awayTeamName: awayTeam.name,
        matchDate: baseDate.add(const Duration(hours: 19)),
        week: secondHalfWeek,
        isSecondHalf: true,
        status: 'Yakında',
        odds: odds,
      ));
    }

    return matches;
  }

  /// UEFA 36 Takımlı Lig Aşaması Fikstürü (8 Maç Günü)
  static List<FootballMatch> _generateUefaMatches(String leagueId, List<TeamModel> teams) {
    final matches = <FootballMatch>[];
    final n = teams.length; // 36 takım

    for (int week = 1; week <= 8; week++) {
      final baseDate = DateTime(2026, 9, 15).add(Duration(days: (week - 1) * 14));
      for (int i = 0; i < n; i += 2) {
        final homeIndex = (i + week - 1) % n;
        final awayIndex = (i + week) % n;

        final homeTeam = teams[homeIndex];
        final awayTeam = teams[awayIndex];
        final matchId = '${leagueId}_w${week}_${homeTeam.id}_${awayTeam.id}';
        final odds = _calculateDeterministicOdds(matchId, homeTeam, awayTeam);

        matches.add(FootballMatch(
          id: matchId,
          leagueId: leagueId,
          homeTeamId: homeTeam.id,
          homeTeamName: homeTeam.name,
          awayTeamId: awayTeam.id,
          awayTeamName: awayTeam.name,
          matchDate: baseDate.add(Duration(hours: 20, minutes: (i % 4) * 15)),
          week: week,
          isSecondHalf: week > 4,
          status: week <= 6 ? 'Bitti' : (week == 7 ? 'Bülten' : 'Yakında'),
          odds: odds,
        ));
      }
    }

    return matches;
  }

  /// Deterministik, takım puanı ve güç dengesine göre tutarlı oran hesaplayıcı
  static MatchOdds _calculateDeterministicOdds(String matchId, TeamModel home, TeamModel away) {
    // Hash tabanlı deterministik hafif varyasyon
    int hash = 0;
    for (int i = 0; i < matchId.length; i++) {
      hash = (hash * 31 + matchId.codeUnitAt(i)) & 0xFFFFFF;
    }
    final variance = (hash % 20) / 100.0; // 0.00 - 0.19 arası varyasyon

    // Ev sahibi avantajı + puan farkı
    final pointDiff = (home.points - away.points) / 20.0; // örn: 10 puan fark -> +0.5

    double ms1;
    double msX;
    double ms2;

    if (pointDiff > 1.2) {
      // Çok güçlü ev sahibi (örn: Beşiktaş vs alt sıralar)
      ms1 = (1.20 + variance).clamp(1.10, 1.45);
      msX = (4.20 + variance * 2).clamp(3.80, 5.50);
      ms2 = (7.50 + variance * 3).clamp(6.00, 12.00);
    } else if (pointDiff > 0.4) {
      // Güçlü ev sahibi
      ms1 = (1.65 + variance).clamp(1.50, 1.95);
      msX = (3.40 + variance).clamp(3.10, 3.80);
      ms2 = (4.50 + variance * 2).clamp(3.90, 5.80);
    } else if (pointDiff < -1.0) {
      // Güçlü deplasman takımı
      ms1 = (4.80 + variance * 2).clamp(4.00, 6.50);
      msX = (3.50 + variance).clamp(3.20, 3.90);
      ms2 = (1.60 + variance).clamp(1.45, 1.85);
    } else {
      // Dengeli maç
      ms1 = (2.25 + variance).clamp(2.00, 2.55);
      msX = (3.10 + variance).clamp(2.95, 3.35);
      ms2 = (2.80 + variance).clamp(2.50, 3.20);
    }

    // Çifte Şans
    final cs1X = ((ms1 * msX) / (ms1 + msX) * 0.95).clamp(1.12, 1.85);
    final cs12 = ((ms1 * ms2) / (ms1 + ms2) * 0.95).clamp(1.18, 1.40);
    final csX2 = ((msX * ms2) / (msX + ms2) * 0.95).clamp(1.15, 2.10);

    // Handikap
    final h1 = (ms1 * 1.55).clamp(1.65, 3.40);
    final hX = (3.60 + variance).clamp(3.20, 4.10);
    final h2 = (ms2 * 0.75 + 1.1).clamp(1.35, 2.80);

    // Alt / Üst
    final over25 = (1.75 + variance).clamp(1.50, 2.10);
    final under25 = (1.95 - variance).clamp(1.65, 2.25);

    final over15 = (1.22 + variance * 0.5).clamp(1.15, 1.35);
    final under15 = (3.40 + variance * 2).clamp(2.80, 4.20);

    final over35 = (2.85 + variance).clamp(2.40, 3.60);
    final under35 = (1.35 + variance * 0.5).clamp(1.22, 1.50);

    final over45 = (5.20 + variance * 2).clamp(4.20, 6.80);
    final under45 = (1.12 + variance * 0.2).clamp(1.08, 1.20);

    // Karşılıklı Gol
    final bttsYes = (1.70 + variance).clamp(1.55, 1.95);
    final bttsNo = (1.90 - variance).clamp(1.75, 2.15);

    // İlk Yarı
    final ht1 = (ms1 * 1.25 + 0.3).clamp(1.60, 3.80);
    final htX = (2.10 + variance * 0.5).clamp(1.95, 2.40);
    final ht2 = (ms2 * 1.20 + 0.4).clamp(1.90, 5.50);

    // Penaltı & Kırmızı Kart
    final penaltyYes = (2.65 + variance).clamp(2.40, 3.10);
    final penaltyNo = (1.38 - variance * 0.3).clamp(1.28, 1.48);

    final redCardYes = (3.40 + variance).clamp(3.00, 4.00);
    final redCardNo = (1.24 - variance * 0.2).clamp(1.18, 1.32);

    return MatchOdds(
      matchId: matchId,
      ms1: double.parse(ms1.toStringAsFixed(2)),
      msX: double.parse(msX.toStringAsFixed(2)),
      ms2: double.parse(ms2.toStringAsFixed(2)),
      cs1X: double.parse(cs1X.toStringAsFixed(2)),
      cs12: double.parse(cs12.toStringAsFixed(2)),
      csX2: double.parse(csX2.toStringAsFixed(2)),
      h1: double.parse(h1.toStringAsFixed(2)),
      hX: double.parse(hX.toStringAsFixed(2)),
      h2: double.parse(h2.toStringAsFixed(2)),
      over15: double.parse(over15.toStringAsFixed(2)),
      under15: double.parse(under15.toStringAsFixed(2)),
      over25: double.parse(over25.toStringAsFixed(2)),
      under25: double.parse(under25.toStringAsFixed(2)),
      over35: double.parse(over35.toStringAsFixed(2)),
      under35: double.parse(under35.toStringAsFixed(2)),
      over45: double.parse(over45.toStringAsFixed(2)),
      under45: double.parse(under45.toStringAsFixed(2)),
      bttsYes: double.parse(bttsYes.toStringAsFixed(2)),
      bttsNo: double.parse(bttsNo.toStringAsFixed(2)),
      ht1: double.parse(ht1.toStringAsFixed(2)),
      htX: double.parse(htX.toStringAsFixed(2)),
      ht2: double.parse(ht2.toStringAsFixed(2)),
      penaltyYes: double.parse(penaltyYes.toStringAsFixed(2)),
      penaltyNo: double.parse(penaltyNo.toStringAsFixed(2)),
      redCardYes: double.parse(redCardYes.toStringAsFixed(2)),
      redCardNo: double.parse(redCardNo.toStringAsFixed(2)),
    );
  }
}
