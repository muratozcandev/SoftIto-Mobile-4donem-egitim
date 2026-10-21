import '../models/football_models.dart';

/// Tutturdum takımlar ve lig puan durumları
abstract class DemoTeams {
  static final Map<String, List<TeamModel>> _leagueTeams = {
    // 🇹🇷 Süper Lig (18 Takım) - ÖZEL ŞART: Beşiktaş 1. ve Lider, Galatasaray 0 puanla son sırada!
    'super_lig': [
      const TeamModel(
        id: 'tr_bjk',
        name: 'Beşiktaş',
        shortName: 'BJK',
        leagueId: 'super_lig',
        logoEmoji: '🦅',
        played: 24,
        won: 20,
        drawn: 4,
        lost: 0,
        goalsFor: 58,
        goalsAgainst: 12,
        goalDifference: 46,
        points: 64, // 1. Sıra - LİDER
      ),
      const TeamModel(
        id: 'tr_fb',
        name: 'Fenerbahçe',
        shortName: 'FB',
        leagueId: 'super_lig',
        logoEmoji: '🟡',
        played: 24,
        won: 18,
        drawn: 3,
        lost: 3,
        goalsFor: 54,
        goalsAgainst: 19,
        goalDifference: 35,
        points: 57,
      ),
      const TeamModel(
        id: 'tr_ts',
        name: 'Trabzonspor',
        shortName: 'TS',
        leagueId: 'super_lig',
        logoEmoji: '🌊',
        played: 24,
        won: 15,
        drawn: 5,
        lost: 4,
        goalsFor: 44,
        goalsAgainst: 22,
        goalDifference: 22,
        points: 50,
      ),
      const TeamModel(
        id: 'tr_ibfk',
        name: 'Başakşehir',
        shortName: 'IBFK',
        leagueId: 'super_lig',
        logoEmoji: '🦉',
        played: 24,
        won: 13,
        drawn: 6,
        lost: 5,
        goalsFor: 39,
        goalsAgainst: 25,
        goalDifference: 14,
        points: 45,
      ),
      const TeamModel(
        id: 'tr_samsun',
        name: 'Samsunspor',
        shortName: 'SAM',
        leagueId: 'super_lig',
        logoEmoji: '🔴',
        played: 24,
        won: 12,
        drawn: 5,
        lost: 7,
        goalsFor: 36,
        goalsAgainst: 27,
        goalDifference: 9,
        points: 41,
      ),
      const TeamModel(
        id: 'tr_eyup',
        name: 'Eyüpspor',
        shortName: 'EYP',
        leagueId: 'super_lig',
        logoEmoji: '💜',
        played: 24,
        won: 11,
        drawn: 6,
        lost: 7,
        goalsFor: 34,
        goalsAgainst: 28,
        goalDifference: 6,
        points: 39,
      ),
      const TeamModel(
        id: 'tr_goztepe',
        name: 'Göztepe',
        shortName: 'GÖZ',
        leagueId: 'super_lig',
        logoEmoji: '🟡',
        played: 24,
        won: 10,
        drawn: 7,
        lost: 7,
        goalsFor: 33,
        goalsAgainst: 29,
        goalDifference: 4,
        points: 37,
      ),
      const TeamModel(
        id: 'tr_kasimpasa',
        name: 'Kasımpaşa',
        shortName: 'KAS',
        leagueId: 'super_lig',
        logoEmoji: '🔵',
        played: 24,
        won: 9,
        drawn: 8,
        lost: 7,
        goalsFor: 38,
        goalsAgainst: 37,
        goalDifference: 1,
        points: 35,
      ),
      const TeamModel(
        id: 'tr_sivas',
        name: 'Sivasspor',
        shortName: 'SİV',
        leagueId: 'super_lig',
        logoEmoji: '🔴',
        played: 24,
        won: 9,
        drawn: 5,
        lost: 10,
        goalsFor: 31,
        goalsAgainst: 34,
        goalDifference: -3,
        points: 32,
      ),
      const TeamModel(
        id: 'tr_antalya',
        name: 'Antalyaspor',
        shortName: 'ANT',
        leagueId: 'super_lig',
        logoEmoji: '⚪',
        played: 24,
        won: 8,
        drawn: 6,
        lost: 10,
        goalsFor: 29,
        goalsAgainst: 35,
        goalDifference: -6,
        points: 30,
      ),
      const TeamModel(
        id: 'tr_konya',
        name: 'Konyaspor',
        shortName: 'KON',
        leagueId: 'super_lig',
        logoEmoji: '🟢',
        played: 24,
        won: 7,
        drawn: 7,
        lost: 10,
        goalsFor: 27,
        goalsAgainst: 33,
        goalDifference: -6,
        points: 28,
      ),
      const TeamModel(
        id: 'tr_gaziantep',
        name: 'Gaziantep FK',
        shortName: 'GFK',
        leagueId: 'super_lig',
        logoEmoji: '🔴',
        played: 24,
        won: 7,
        drawn: 6,
        lost: 11,
        goalsFor: 28,
        goalsAgainst: 38,
        goalDifference: -10,
        points: 27,
      ),
      const TeamModel(
        id: 'tr_rize',
        name: 'Çaykur Rizespor',
        shortName: 'RİZ',
        leagueId: 'super_lig',
        logoEmoji: '🟢',
        played: 24,
        won: 7,
        drawn: 5,
        lost: 12,
        goalsFor: 25,
        goalsAgainst: 39,
        goalDifference: -14,
        points: 26,
      ),
      const TeamModel(
        id: 'tr_kayseri',
        name: 'Kayserispor',
        shortName: 'KAY',
        leagueId: 'super_lig',
        logoEmoji: '🟡',
        played: 24,
        won: 5,
        drawn: 9,
        lost: 10,
        goalsFor: 24,
        goalsAgainst: 40,
        goalDifference: -16,
        points: 24,
      ),
      const TeamModel(
        id: 'tr_bodrum',
        name: 'Bodrum FK',
        shortName: 'BOD',
        leagueId: 'super_lig',
        logoEmoji: '🟢',
        played: 24,
        won: 5,
        drawn: 6,
        lost: 13,
        goalsFor: 18,
        goalsAgainst: 36,
        goalDifference: -18,
        points: 21,
      ),
      const TeamModel(
        id: 'tr_alanya',
        name: 'Alanyaspor',
        shortName: 'ALN',
        leagueId: 'super_lig',
        logoEmoji: '🟠',
        played: 24,
        won: 4,
        drawn: 7,
        lost: 13,
        goalsFor: 21,
        goalsAgainst: 42,
        goalDifference: -21,
        points: 19,
      ),
      const TeamModel(
        id: 'tr_hatay',
        name: 'Hatayspor',
        shortName: 'HAT',
        leagueId: 'super_lig',
        logoEmoji: '🟤',
        played: 24,
        won: 3,
        drawn: 6,
        lost: 15,
        goalsFor: 19,
        goalsAgainst: 48,
        goalDifference: -29,
        points: 15,
      ),
      const TeamModel(
        id: 'tr_gs',
        name: 'Galatasaray',
        shortName: 'GS',
        leagueId: 'super_lig',
        logoEmoji: '🦁',
        played: 24,
        won: 0,
        drawn: 0,
        lost: 24,
        goalsFor: 0,
        goalsAgainst: 72,
        goalDifference: -72,
        points: 0, // 18. Sıra - SIFIR PUANLA SON SIRADA
      ),
    ],

    // 🏴󠁧󠁢󠁥󠁮󠁧󠁿 Premier Lig (20 Takım)
    'premier_league': _generateStandardLeagueTeams('premier_league', [
      'Liverpool', 'Arsenal', 'Manchester City', 'Chelsea', 'Nottingham Forest',
      'Aston Villa', 'Brighton', 'Bournemouth', 'Newcastle', 'Tottenham',
      'Fulham', 'Brentford', 'Manchester United', 'West Ham', 'Crystal Palace',
      'Everton', 'Leicester City', 'Wolves', 'Ipswich Town', 'Southampton'
    ], [60, 56, 53, 49, 47, 45, 42, 40, 39, 37, 36, 35, 32, 30, 28, 25, 21, 19, 16, 12]),

    // 🇪🇸 LaLiga (20 Takım)
    'la_liga': _generateStandardLeagueTeams('la_liga', [
      'Barcelona', 'Real Madrid', 'Atletico Madrid', 'Athletic Bilbao', 'Villarreal',
      'Real Mallorca', 'Real Sociedad', 'Girona', 'Osasuna', 'Real Betis',
      'Celta Vigo', 'Sevilla', 'Rayo Vallecano', 'Alaves', 'Las Palmas',
      'Leganes', 'Getafe', 'Espanyol', 'Valencia', 'Real Valladolid'
    ], [62, 59, 53, 48, 44, 42, 40, 38, 37, 35, 34, 32, 29, 27, 25, 23, 20, 18, 17, 13]),

    // 🇮🇹 Serie A (20 Takım)
    'serie_a': _generateStandardLeagueTeams('serie_a', [
      'Napoli', 'Inter', 'Atalanta', 'Fiorentina', 'Lazio',
      'Juventus', 'AC Milan', 'Bologna', 'Torino', 'Udinese',
      'Empoli', 'Roma', 'Parma', 'Verona', 'Como',
      'Cagliari', 'Lecce', 'Genoa', 'Monza', 'Venezia'
    ], [57, 56, 54, 51, 48, 47, 44, 40, 37, 36, 33, 31, 29, 27, 24, 22, 20, 18, 15, 12]),

    // 🇩🇪 Bundesliga (18 Takım)
    'bundesliga': _generateStandardLeagueTeams('bundesliga', [
      'Bayern Munich', 'Bayer Leverkusen', 'Eintracht Frankfurt', 'RB Leipzig', 'Borussia Dortmund',
      'Freiburg', 'Mainz 05', 'Wolfsburg', 'Stuttgart', 'Borussia Mönchengladbach',
      'Werder Bremen', 'Union Berlin', 'Augsburg', 'Heidenheim', 'St. Pauli',
      'Hoffenheim', 'Holstein Kiel', 'Bochum'
    ], [59, 53, 47, 45, 43, 40, 38, 36, 34, 32, 30, 27, 25, 22, 19, 17, 13, 10]),

    // 🇫🇷 Ligue 1 (18 Takım)
    'ligue_1': _generateStandardLeagueTeams('ligue_1', [
      'Paris Saint-Germain', 'Monaco', 'Marseille', 'Lille', 'Lyon',
      'Nice', 'Lens', 'Auxerre', 'Toulouse', 'Strasbourg',
      'Brest', 'Reims', 'Rennes', 'Nantes', 'Angers',
      'Saint-Etienne', 'Le Havre', 'Montpellier'
    ], [62, 52, 49, 45, 42, 39, 37, 35, 33, 31, 29, 28, 26, 23, 21, 18, 15, 11]),

    // 🇵🇹 Liga Portugal (18 Takım)
    'liga_portugal': _generateStandardLeagueTeams('liga_portugal', [
      'Sporting CP', 'Benfica', 'Porto', 'Braga', 'Santa Clara',
      'Vitoria de Guimaraes', 'Moreirense', 'Casa Pia', 'Famalicao', 'Rio Ave',
      'Estoril', 'Arouca', 'Gil Vicente', 'Boavista', 'AVS Futebol',
      'Nacional', 'Estrela da Amadora', 'Farense'
    ], [61, 57, 52, 46, 40, 38, 35, 33, 31, 29, 27, 25, 23, 20, 18, 16, 14, 11]),

    // 🇳🇱 Eredivisie (18 Takım)
    'eredivisie': _generateStandardLeagueTeams('eredivisie', [
      'PSV Eindhoven', 'Ajax', 'Utrecht', 'Feyenoord', 'Twente',
      'AZ Alkmaar', 'Go Ahead Eagles', 'Fortuna Sittard', 'NEC Nijmegen', 'Heerenveen',
      'Willem II', 'Groningen', 'Sparta Rotterdam', 'PEC Zwolle', 'NAC Breda',
      'Heracles', 'Almere City', 'RKC Waalwijk'
    ], [63, 58, 51, 48, 44, 41, 38, 35, 32, 30, 28, 26, 24, 22, 19, 17, 14, 10]),

    // ⭐ Şampiyonlar Ligi (36 Takım)
    'champions_league': _generateUefaTeams('champions_league', 36, 'UCL'),

    // 🏆 Avrupa Ligi (36 Takım)
    'europa_league': _generateUefaTeams('europa_league', 36, 'UEL'),

    // 🛡️ Konferans Ligi (36 Takım)
    'conference_league': _generateUefaTeams('conference_league', 36, 'UECL'),
  };

  static List<TeamModel> getTeamsForLeague(String leagueId) {
    return _leagueTeams[leagueId] ?? [];
  }

  static TeamModel? getTeamById(String teamId) {
    for (final teams in _leagueTeams.values) {
      for (final team in teams) {
        if (team.id == teamId) return team;
      }
    }
    return null;
  }

  static List<TeamModel> _generateStandardLeagueTeams(
    String leagueId,
    List<String> names,
    List<int> pointsList,
  ) {
    final list = <TeamModel>[];
    for (int i = 0; i < names.length; i++) {
      final pts = pointsList[i];
      final won = pts ~/ 3;
      final drawn = pts % 3;
      final lost = 24 - won - drawn;
      final gf = won * 2 + drawn + 10;
      final ga = lost * 2 + 10;
      final gd = gf - ga;
      list.add(TeamModel(
        id: '${leagueId}_team_$i',
        name: names[i],
        shortName: names[i].length > 3 ? names[i].substring(0, 3).toUpperCase() : names[i].toUpperCase(),
        leagueId: leagueId,
        logoEmoji: '⚽',
        played: 24,
        won: won,
        drawn: drawn,
        lost: lost < 0 ? 0 : lost,
        goalsFor: gf,
        goalsAgainst: ga,
        goalDifference: gd,
        points: pts,
      ));
    }
    return list;
  }

  static List<TeamModel> _generateUefaTeams(String leagueId, int count, String prefix) {
    final names = [
      'Real Madrid', 'Manchester City', 'Bayern Munich', 'Paris Saint-Germain', 'Liverpool',
      'Inter', 'Barcelona', 'Arsenal', 'Bayer Leverkusen', 'Atletico Madrid',
      'Atalanta', 'Juventus', 'Borussia Dortmund', 'Benfica', 'Sporting CP',
      'AC Milan', 'Feyenoord', 'PSV Eindhoven', 'Aston Villa', 'Monaco',
      'Celtic', 'Club Brugge', 'Lille', 'Dinamo Zagreb', 'Sparta Prague',
      'Sturm Graz', 'Bologna', 'Girona', 'Stuttgart', 'Crvena Zvezda',
      'Salzburg', 'Young Boys', 'Slovan Bratislava', 'Shakhtar Donetsk', 'Besiktas', 'Galatasaray'
    ];
    final list = <TeamModel>[];
    for (int i = 0; i < count; i++) {
      final name = i < names.length ? names[i] : '$prefix Takım ${i + 1}';
      final pts = 24 - (i * 0.6).round();
      list.add(TeamModel(
        id: '${leagueId}_uefa_$i',
        name: name,
        shortName: '$prefix${i + 1}',
        leagueId: leagueId,
        logoEmoji: '🏆',
        played: 8,
        won: (pts / 3).floor(),
        drawn: pts % 3,
        lost: (8 - (pts / 3).floor() - (pts % 3)).clamp(0, 8),
        goalsFor: 18 - (i ~/ 3),
        goalsAgainst: 6 + (i ~/ 4),
        goalDifference: (18 - (i ~/ 3)) - (6 + (i ~/ 4)),
        points: pts,
      ));
    }
    return list;
  }
}
