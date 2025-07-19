import 'package:football_app/data/models/country.dart';
import 'package:football_app/data/models/season.dart';
import 'package:football_app/modules/league/models/league.dart';

class LeagueResponse {
  final League league;
  final Country country;
  final List<Season> seasons;

  LeagueResponse({
    required this.league,
    required this.country,
    required this.seasons,
  });

  factory LeagueResponse.fromJson(Map<String, dynamic> json) {
    return LeagueResponse(
      league: League.fromJson(json['league'] ?? {}),
      country: Country.fromJson(json['country'] ?? {}),
      seasons: (json['seasons'] as List<dynamic>? ?? [])
          .map((s) => Season.fromJson(s))
          .toList(),
    );
  }
}