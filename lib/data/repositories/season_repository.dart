import 'package:football_app/core/services/api_client.dart';

class SeasonRepository {
  final ApiClient _apiClient;

  SeasonRepository(this._apiClient);

  // Fetch all available seasons
  Future<List<int>> getSeasons() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/leagues/seasons',
    );

    // API returns an array of integers in `response`
    final List<dynamic> data = response.data?['response'] ?? [];
    return data.map((e) => e as int).toList();
  }
}
