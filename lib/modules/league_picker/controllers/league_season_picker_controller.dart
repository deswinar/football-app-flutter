import 'package:football_app/core/services/storage_service.dart';
import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/data/models/country.dart';
import 'package:football_app/data/repositories/country_repository.dart';
import 'package:football_app/data/repositories/season_repository.dart';
import 'package:football_app/modules/league/models/league_response.dart';
import 'package:football_app/modules/league/repositories/league_repository.dart';
import 'package:get/get.dart';

class LeagueSeasonPickerController extends GetxController {
  final LeagueRepository leagueRepository;
  final SeasonRepository seasonRepository;
  final CountryRepository countryRepository;
  final StorageService storageService;

  LeagueSeasonPickerController({
    required this.leagueRepository,
    required this.seasonRepository,
    required this.countryRepository,
    required this.storageService,
  });

  // View states
  final _leaguesState = Rx<ViewState<List<LeagueResponse>>>(ViewStateInitial());
  final _countriesState = Rx<ViewState<List<Country>>>(ViewStateInitial());
  final _seasonsState = Rx<ViewState<List<int>>>(ViewStateInitial());

  get leaguesState => _leaguesState.value;
  get countriesState => _countriesState.value;
  get seasonsState => _seasonsState.value;

  // Selections
  final selectedSeason = 2021.obs;
  final selectedCountry = Rxn<Country>();

  // Lists
  final availableSeasons = <int>[].obs;
  final availableCountries = <Country>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadCachedSelections();
    fetchInitialData();
  }

  void _loadCachedSelections() {
    final cachedSeason = storageService.getSelectedSeason();
    if (cachedSeason != null) {
      selectedSeason.value = cachedSeason;
    }

    final cachedCountryJson = storageService.getSelectedCountry();
    if (cachedCountryJson != null) {
      selectedCountry.value = Country.fromJson(cachedCountryJson);
    }
  }

  /// Fetch both seasons and countries
  Future<void> fetchInitialData() async {
    await Future.wait([
      fetchSeasons(),
      fetchCountries(),
    ]);
    if (availableSeasons.isNotEmpty && selectedCountry.value != null) {
      fetchLeagues();
    }
  }

  /// Fetch countries from API
  Future<void> fetchCountries() async {
    try {
      _countriesState.value = const ViewStateLoading();

      // Try cache first
      final cached = storageService.getCountries();
      final savedSelected = storageService.getSelectedCountryModel();

      if (cached != null) {
        final countryList = cached.map((e) => Country.fromJson(e)).toList();
        availableCountries.assignAll(countryList);

        // Select previously selected or fallback to first
        selectedCountry.value = savedSelected != null && countryList.contains(savedSelected)
            ? savedSelected
            : countryList.first;

        _countriesState.value = ViewStateSuccess(countryList);
      }

      // Always refresh in background
      final countries = await countryRepository.getCountries();
      if (countries.isEmpty) {
        _countriesState.value = const ViewStateError('No countries found.');
        return;
      }

      availableCountries.assignAll(countries);

      selectedCountry.value = savedSelected != null && countries.contains(savedSelected)
          ? savedSelected
          : countries.first;

      // Cache and emit success
      storageService.saveCountries(countries.map((e) => e.toJson()).toList());
      _countriesState.value = ViewStateSuccess(countries);
    } catch (e) {
      if (availableCountries.isEmpty) {
        _countriesState.value = ViewStateError('Failed to fetch countries: $e');
      }
    }
  }

  /// Fetch seasons
  Future<void> fetchSeasons() async {
    try {
      _seasonsState.value = const ViewStateLoading();

      final cached = storageService.getSeasons();
      final savedSelected = storageService.getSelectedSeason();

      if (cached != null) {
        final seasonList = cached.map((e) => e['year'] as int).toList();
        availableSeasons.assignAll(seasonList);

        // Use saved season if valid
        selectedSeason.value = savedSelected != null && seasonList.contains(savedSelected)
            ? savedSelected
            : seasonList.first;

        _seasonsState.value = ViewStateSuccess(seasonList);
      }

      final seasons = await seasonRepository.getSeasons();
      if (seasons.isNotEmpty) {
        availableSeasons.assignAll(seasons);

        selectedSeason.value = savedSelected != null && seasons.contains(savedSelected)
            ? savedSelected
            : seasons.first;

        storageService.saveSeasons(seasons.map((year) => {'year': year}).toList());
        _seasonsState.value = ViewStateSuccess(seasons);
      } else {
        _seasonsState.value = const ViewStateError('No seasons found.');
      }
    } catch (e) {
      if (availableSeasons.isEmpty) {
        _seasonsState.value = ViewStateError('Failed to load seasons: $e');
      }
    }
  }

  /// Fetch leagues based on season and country
  Future<void> fetchLeagues() async {
    final country = selectedCountry.value;
    final season = selectedSeason.value;

    if (country == null) return;

    try {
      _leaguesState.value = const ViewStateLoading();

      final leagues = await leagueRepository.getLeagues(
        season: season,
        country: country.name,
      );

      if (leagues.isEmpty) {
        _leaguesState.value = const ViewStateError('No leagues found.');
      } else {
        _leaguesState.value = ViewStateSuccess(leagues);
      }
    } catch (e) {
      _leaguesState.value = ViewStateError(e.toString());
    }
  }

  void selectSeason(int year) {
    selectedSeason.value = year;
    storageService.saveSelectedSeason(year);
    fetchLeagues();
  }

  void selectCountry(Country country) {
    selectedCountry.value = country;
    storageService.saveSelectedCountry(country.toJson());
    fetchLeagues();
  }
}
