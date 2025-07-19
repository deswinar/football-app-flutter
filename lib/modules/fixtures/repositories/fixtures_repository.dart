import 'package:football_app/core/services/api_client.dart';
import 'package:football_app/modules/fixtures/models/fixture_response.dart';

class FixturesRepository {
  final ApiClient _apiClient;

  FixturesRepository(this._apiClient);

  // Fetch fixtures for a specific date in yyyy-MM-dd format
  Future<List<FixtureEntry>> getFixturesByDate(String date) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/fixtures',
      query: {
        'date': date,
        'timezone': 'Asia/Jakarta',
      },
    );

    final fixtureResponse = FixtureResponse.fromJson(response.data!);
    return fixtureResponse.response;
  }

  // Fetch live fixtures (ongoing matches)
  Future<List<FixtureEntry>> getLiveFixtures() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/fixtures',
      query: {
        'live': 'all',
        'timezone': 'Asia/Jakarta',
      },
    );

    final fixtureResponse = FixtureResponse.fromJson(response.data!);
    return fixtureResponse.response;
  }
}
