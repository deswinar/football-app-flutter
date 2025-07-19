class PlayerStatistics {
  final Map<String, dynamic> team;
  final Map<String, dynamic> league;
  final Map<String, dynamic> games;
  final Map<String, dynamic> goals;
  final Map<String, dynamic> shots;
  final Map<String, dynamic> passes;
  final Map<String, dynamic> tackles;
  final Map<String, dynamic> duels;
  final Map<String, dynamic> dribbles;
  final Map<String, dynamic> fouls;
  final Map<String, dynamic> cards;
  final Map<String, dynamic> substitutes;
  final Map<String, dynamic> penalty;

  PlayerStatistics({
    required this.team,
    required this.league,
    required this.games,
    required this.goals,
    required this.shots,
    required this.passes,
    required this.tackles,
    required this.duels,
    required this.dribbles,
    required this.fouls,
    required this.cards,
    required this.substitutes,
    required this.penalty,
  });

  factory PlayerStatistics.fromJson(Map<String, dynamic> json) {
    return PlayerStatistics(
      team: json['team'] ?? {},
      league: json['league'] ?? {},
      games: json['games'] ?? {},
      goals: json['goals'] ?? {},
      shots: json['shots'] ?? {},
      passes: json['passes'] ?? {},
      tackles: json['tackles'] ?? {},
      duels: json['duels'] ?? {},
      dribbles: json['dribbles'] ?? {},
      fouls: json['fouls'] ?? {},
      cards: json['cards'] ?? {},
      substitutes: json['substitutes'] ?? {},
      penalty: json['penalty'] ?? {},
    );
  }
}
