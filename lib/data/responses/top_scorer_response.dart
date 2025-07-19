import 'package:football_app/data/models/player.dart';
import 'package:football_app/data/models/player_statistics.dart';

class TopScorerResponse {
  final Player player;
  final List<PlayerStatistics> statistics;

  TopScorerResponse({
    required this.player,
    required this.statistics,
  });

  factory TopScorerResponse.fromJson(Map<String, dynamic> json) {
    return TopScorerResponse(
      player: Player.fromJson(json['player']),
      statistics: (json['statistics'] as List)
          .map((e) => PlayerStatistics.fromJson(e))
          .toList(),
    );
  }
}
