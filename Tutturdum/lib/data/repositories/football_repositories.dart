import '../models/football_models.dart';
import '../demo/demo_leagues.dart';
import '../demo/demo_teams.dart';
import '../demo/demo_matches.dart';

/// Ligler Repository
class LeagueRepository {
  static final LeagueRepository instance = LeagueRepository._internal();
  LeagueRepository._internal();

  List<LeagueModel> getLeagues() {
    return DemoLeagues.leagues;
  }

  LeagueModel? getLeagueById(String id) {
    for (final l in DemoLeagues.leagues) {
      if (l.id == id) return l;
    }
    return null;
  }

  List<TeamModel> getStandings(String leagueId) {
    return DemoTeams.getTeamsForLeague(leagueId);
  }
}

/// Maçlar Repository
class MatchRepository {
  static final MatchRepository instance = MatchRepository._internal();
  MatchRepository._internal();

  List<FootballMatch> getMatchesForLeague(String leagueId) {
    return DemoMatches.getMatchesForLeague(leagueId);
  }

  List<FootballMatch> getMatchesForTeam(String teamId) {
    return DemoMatches.getMatchesForTeam(teamId);
  }

  FootballMatch? getMatchById(String matchId) {
    return DemoMatches.getMatchById(matchId);
  }

  List<FootballMatch> getFeaturedMatches() {
    return DemoMatches.getFeaturedMatches();
  }
}

/// Oranlar Repository
class OddsRepository {
  static final OddsRepository instance = OddsRepository._internal();
  OddsRepository._internal();

  MatchOdds? getOddsForMatch(String matchId) {
    final match = MatchRepository.instance.getMatchById(matchId);
    return match?.odds;
  }
}
