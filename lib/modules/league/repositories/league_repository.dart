import 'package:football_app/core/services/api_client.dart';
import 'package:football_app/core/utils/api_utils.dart';
import 'package:football_app/modules/league/models/league_response.dart';

class LeagueRepository {
  final ApiClient _apiClient;

  LeagueRepository(this._apiClient);

  // Fetch a list of leagues, optionally filtered by season
  Future<List<LeagueResponse>> getLeagues({int? season, String? country}) async {
    final query = <String, dynamic>{};

    if (season != null) {
      query['season'] = season.toString();
    }

    if (country != null) {
      query['country'] = country;
    }

    final response = await _apiClient.get<Map<String, dynamic>>(
      '/leagues',
      query: query,
    );

    // Check for 'errors' key
    checkForApiError(response.data, statusCode: response.statusCode);

    final List<dynamic> data = response.data?['response'] ?? [];
    return data.map((json) => LeagueResponse.fromJson(json)).toList();
  }

  // Fetch a single league by ID to get its seasons detail
  Future<LeagueResponse?> getLeagueSeasons({
    required int leagueId,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/leagues',
      query: {
        'id': leagueId.toString(),
      },
    );

    final List<dynamic> data = response.data?['response'] ?? [];
    if (data.isEmpty) return null;

    return LeagueResponse.fromJson(data.first as Map<String, dynamic>);
  }
}
