/// Lig modeli
class LeagueModel {
  final String id;
  final String name;
  final String country;
  final String logoEmoji;
  final int teamCount;
  final bool isUefa;

  const LeagueModel({
    required this.id,
    required this.name,
    required this.country,
    required this.logoEmoji,
    required this.teamCount,
    this.isUefa = false,
  });
}

/// Takım ve lig tablosu puan durumu modeli
class TeamModel {
  final String id;
  final String name;
  final String shortName;
  final String leagueId;
  final String logoEmoji;
  final int played;
  final int won;
  final int drawn;
  final int lost;
  final int goalsFor;
  final int goalsAgainst;
  final int goalDifference;
  final int points;

  const TeamModel({
    required this.id,
    required this.name,
    required this.shortName,
    required this.leagueId,
    required this.logoEmoji,
    required this.played,
    required this.won,
    required this.drawn,
    required this.lost,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.goalDifference,
    required this.points,
  });

  TeamModel copyWith({
    String? id,
    String? name,
    String? shortName,
    String? leagueId,
    String? logoEmoji,
    int? played,
    int? won,
    int? drawn,
    int? lost,
    int? goalsFor,
    int? goalsAgainst,
    int? goalDifference,
    int? points,
  }) {
    return TeamModel(
      id: id ?? this.id,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      leagueId: leagueId ?? this.leagueId,
      logoEmoji: logoEmoji ?? this.logoEmoji,
      played: played ?? this.played,
      won: won ?? this.won,
      drawn: drawn ?? this.drawn,
      lost: lost ?? this.lost,
      goalsFor: goalsFor ?? this.goalsFor,
      goalsAgainst: goalsAgainst ?? this.goalsAgainst,
      goalDifference: goalDifference ?? this.goalDifference,
      points: points ?? this.points,
    );
  }
}

/// Maç bahis oranları modeli
class MatchOdds {
  final String matchId;

  // Maç Sonucu
  final double ms1;
  final double msX;
  final double ms2;

  // Çifte Şans
  final double cs1X;
  final double cs12;
  final double csX2;

  // Handikaplı Maç Sonucu (0-1)
  final double h1;
  final double hX;
  final double h2;

  // Toplam Gol Alt / Üst
  final double over15;
  final double under15;
  final double over25;
  final double under25;
  final double over35;
  final double under35;
  final double over45;
  final double under45;

  // Karşılıklı Gol
  final double bttsYes;
  final double bttsNo;

  // İlk Yarı Sonucu
  final double ht1;
  final double htX;
  final double ht2;

  // Penaltı & Kırmızı Kart
  final double penaltyYes;
  final double penaltyNo;
  final double redCardYes;
  final double redCardNo;

  const MatchOdds({
    required this.matchId,
    required this.ms1,
    required this.msX,
    required this.ms2,
    required this.cs1X,
    required this.cs12,
    required this.csX2,
    required this.h1,
    required this.hX,
    required this.h2,
    required this.over15,
    required this.under15,
    required this.over25,
    required this.under25,
    required this.over35,
    required this.under35,
    required this.over45,
    required this.under45,
    required this.bttsYes,
    required this.bttsNo,
    required this.ht1,
    required this.htX,
    required this.ht2,
    required this.penaltyYes,
    required this.penaltyNo,
    required this.redCardYes,
    required this.redCardNo,
  });
}

/// Maç modeli
class FootballMatch {
  final String id;
  final String leagueId;
  final String homeTeamId;
  final String homeTeamName;
  final String awayTeamId;
  final String awayTeamName;
  final DateTime matchDate;
  final int week; // Hafta numarası
  final bool isSecondHalf; // 1. yarı / 2. yarı maç programı
  final String status; // 'Bülten', 'Canlı', 'Bitti'
  final MatchOdds odds;

  const FootballMatch({
    required this.id,
    required this.leagueId,
    required this.homeTeamId,
    required this.homeTeamName,
    required this.awayTeamId,
    required this.awayTeamName,
    required this.matchDate,
    required this.week,
    this.isSecondHalf = false,
    this.status = 'Bülten',
    required this.odds,
  });
}
