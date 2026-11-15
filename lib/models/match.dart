
class FootballMatch {
  final int id;
  final String league;
  final String country;
  final String home;
  final String away;
  final String? homeLogo;
  final String? awayLogo;
  final int? homeGoals;
  final int? awayGoals;
  final String status;
  final int? elapsed;
  final DateTime kickoff;

  const FootballMatch({
    required this.id,
    required this.league,
    required this.country,
    required this.home,
    required this.away,
    this.homeLogo,
    this.awayLogo,
    this.homeGoals,
    this.awayGoals,
    required this.status,
    this.elapsed,
    required this.kickoff,
  });

  factory FootballMatch.fromJson(
      Map<String, dynamic> json) {
    final fixture = json['fixture'];
    final leagueData = json['league'];
    final teams = json['teams'];
    final goals = json['goals'];
    final home = teams['home'];
    final away = teams['away'];
    final statusData = fixture['status'];

    return FootballMatch(
      id: fixture['id'],
      league: leagueData['name'] ?? '',
      country: leagueData['country'] ?? '',
      home: home['name'] ?? '',
      away: away['name'] ?? '',
      homeLogo: home['logo'],
      awayLogo: away['logo'],
      homeGoals: goals['home'],
      awayGoals: goals['away'],
      status: statusData['short'] ?? 'NS',
      elapsed: statusData['elapsed'],
      kickoff: DateTime.parse(
        fixture['date'],
      ).toLocal(),
    );
  }

  bool get isLive {
    return [
      '1H',
      'HT',
      '2H',
      'ET',
      'P',
      'LIVE',
    ].contains(status);
  }

  bool get isFinished {
    return [
      'FT',
      'AET',
      'PEN',
    ].contains(status);
  }
}
