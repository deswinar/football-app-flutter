import 'package:football_app/data/models/country.dart';
import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _box = GetStorage();

  // Keys
  static const String _keyCountries = 'cached_countries';
  static const String _keySeasons = 'cached_seasons';
  static const String _keySelectedCountry = 'selected_country';
  static const String _keySelectedSeason = 'selected_season';

  // Get selected country as a model
  Country? getSelectedCountryModel() {
    final json = _box.read(_keySelectedCountry);
    return json != null ? Country.fromJson(json) : null;
  }

  // Optional: Save selected country from model
  Future<void> saveSelectedCountryModel(Country country) async {
    await _box.write(_keySelectedCountry, country.toJson());
  }

  // Cached Country List
  Future<void> saveCountries(List<Map<String, dynamic>> jsonList) async {
    await _box.write(_keyCountries, jsonList);
  }

  List<Map<String, dynamic>>? getCountries() {
    return (_box.read(_keyCountries) as List?)?.cast<Map<String, dynamic>>();
  }

  // Cached Season List
  Future<void> saveSeasons(List<Map<String, dynamic>> jsonList) async {
    await _box.write(_keySeasons, jsonList);
  }

  List<Map<String, dynamic>>? getSeasons() {
    return (_box.read(_keySeasons) as List?)?.cast<Map<String, dynamic>>();
  }

  // Selected Country
  Future<void> saveSelectedCountry(Map<String, dynamic> json) async {
    await _box.write(_keySelectedCountry, json);
  }

  Map<String, dynamic>? getSelectedCountry() {
    return _box.read(_keySelectedCountry);
  }

  // Selected Season
  Future<void> saveSelectedSeason(int year) async {
    await _box.write(_keySelectedSeason, year);
  }

  int? getSelectedSeason() {
    return _box.read(_keySelectedSeason);
  }

  void clear() {
    _box.erase();
  }
}
