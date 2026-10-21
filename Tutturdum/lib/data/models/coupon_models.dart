/// Kupon içindeki tekil maç bahis seçimi
class CouponSelection {
  final String id;
  final String matchId;
  final String homeTeam;
  final String awayTeam;
  final String leagueName;
  final String marketName;
  final String selectionName;
  final double odds;

  const CouponSelection({
    required this.id,
    required this.matchId,
    required this.homeTeam,
    required this.awayTeam,
    required this.leagueName,
    required this.marketName,
    required this.selectionName,
    required this.odds,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'matchId': matchId,
      'homeTeam': homeTeam,
      'awayTeam': awayTeam,
      'leagueName': leagueName,
      'marketName': marketName,
      'selectionName': selectionName,
      'odds': odds,
    };
  }

  factory CouponSelection.fromJson(Map<String, dynamic> json) {
    return CouponSelection(
      id: json['id'] as String,
      matchId: json['matchId'] as String,
      homeTeam: json['homeTeam'] as String,
      awayTeam: json['awayTeam'] as String,
      leagueName: json['leagueName'] as String,
      marketName: json['marketName'] as String,
      selectionName: json['selectionName'] as String,
      odds: (json['odds'] as num).toDouble(),
    );
  }
}

/// Oynanan Kupon Modeli
class CouponModel {
  final String id;
  final DateTime createdAt;
  final List<CouponSelection> selections;
  final double totalOdds;
  final double stake;
  final double possibleWin;
  final String status; // 'Simülasyon', 'Kazandı', 'Kaybetti'

  const CouponModel({
    required this.id,
    required this.createdAt,
    required this.selections,
    required this.totalOdds,
    required this.stake,
    required this.possibleWin,
    this.status = 'Simülasyon',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'selections': selections.map((e) => e.toJson()).toList(),
      'totalOdds': totalOdds,
      'stake': stake,
      'possibleWin': possibleWin,
      'status': status,
    };
  }

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      selections: (json['selections'] as List<dynamic>)
          .map((e) => CouponSelection.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalOdds: (json['totalOdds'] as num).toDouble(),
      stake: (json['stake'] as num).toDouble(),
      possibleWin: (json['possibleWin'] as num).toDouble(),
      status: json['status'] as String? ?? 'Simülasyon',
    );
  }
}
