import 'package:football_app/data/models/player.dart';
import 'package:football_app/data/models/player_statistics.dart';

class TopAssistResponse {
  final Player player;
  final List<PlayerStatistics> statistics;

  TopAssistResponse({
    required this.player,
    required this.statistics,
  });

  factory TopAssistResponse.fromJson(Map<String, dynamic> json) {
    return TopAssistResponse(
      player: Player.fromJson(json['player']),
      statistics: (json['statistics'] as List)
          .map((e) => PlayerStatistics.fromJson(e))
          .toList(),
    );
  }
}
