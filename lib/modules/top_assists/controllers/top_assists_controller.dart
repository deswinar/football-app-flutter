import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/data/repositories/player_stats_repository.dart';
import 'package:football_app/data/responses/top_assist_response.dart';
import 'package:get/get.dart';

class TopAssistsController extends GetxController {
  final PlayerStatsRepository _playerStatsRepository;

  TopAssistsController(this._playerStatsRepository);

  final _topAssistsState = Rx<ViewState<List<TopAssistResponse>>>(ViewStateInitial());
  get topAssistsState => _topAssistsState.value;

  int? _currentLeagueId;
  int? _currentSeason;

  @override
  void onInit() {
    super.onInit();
    fetchTopAssists(leagueId: 39, season: 2021); // default values
  }

  Future<void> fetchTopAssists({
    required int leagueId,
    required int season,
  }) async {
    _currentLeagueId = leagueId;
    _currentSeason = season;

    _topAssistsState.value = const ViewStateLoading();

    try {
      final data = await _playerStatsRepository.getTopAssists(
        leagueId: leagueId,
        season: season,
      );

      _topAssistsState.value = ViewStateSuccess(data);
    } catch (e) {
      _topAssistsState.value = ViewStateError(e.toString());
    }
  }

  Future<void> refreshTopAssists({
    required int leagueId,
    required int season,
  }) async {
    await fetchTopAssists(leagueId: leagueId, season: season);
  }

  // on retry
  Future<void> retry() async {
    if (_currentLeagueId != null && _currentSeason != null) {
      await fetchTopAssists(
        leagueId: _currentLeagueId!,
        season: _currentSeason!,
      );
    }
  }
}
