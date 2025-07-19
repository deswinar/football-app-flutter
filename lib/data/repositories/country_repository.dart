import 'package:football_app/core/services/api_client.dart';
import 'package:football_app/core/utils/api_utils.dart';
import 'package:football_app/data/models/country.dart';

class CountryRepository {
  final ApiClient _apiClient;

  CountryRepository(this._apiClient);

  // Get all countries
  Future<List<Country>> getCountries({String? name, String? code, String? search}) async {
    final query = <String, dynamic>{};

    if (name != null) query['name'] = name;
    if (code != null) query['code'] = code;
    if (search != null) query['search'] = search;

    final response = await _apiClient.get<Map<String, dynamic>>(
      '/countries',
      query: query,
    );

    checkForApiError(response.data, statusCode: response.statusCode);

    final List<dynamic> data = response.data?['response'] ?? [];
    return data.map((json) => Country.fromJson(json)).toList();
  }
}
