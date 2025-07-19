import 'package:football_app/core/services/api_client.dart';
import 'package:football_app/core/utils/api_utils.dart';
import 'package:football_app/data/responses/top_assist_response.dart';
import 'package:football_app/data/responses/top_scorer_response.dart';

class PlayerStatsRepository {
  final ApiClient _apiClient;

  PlayerStatsRepository(this._apiClient);

  // Fetch top scorers for a given league and season
  Future<List<TopScorerResponse>> getTopScorers({
    required int leagueId,
    required int season,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/players/topscorers',
      query: {
        'league': leagueId.toString(),
        'season': season.toString(),
      },
    );

    checkForApiError(response.data, statusCode: response.statusCode);

    final List<dynamic> data = response.data?['response'] ?? [];
    return data.map((json) => TopScorerResponse.fromJson(json)).toList();
  }

  // Fetch top assists for a given league and season
  Future<List<TopAssistResponse>> getTopAssists({
    required int leagueId,
    required int season,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/players/topassists',
      query: {
        'league': leagueId.toString(),
        'season': season.toString(),
      },
    );

    checkForApiError(response.data, statusCode: response.statusCode);

    final List<dynamic> data = response.data?['response'] ?? [];
    return data.map((json) => TopAssistResponse.fromJson(json)).toList();
  }
}
