import 'package:football_app/data/repositories/player_stats_repository.dart';
import 'package:get/get.dart';
import 'package:football_app/data/responses/top_scorer_response.dart';
import 'package:football_app/core/state/view_state.dart';

class TopScorersController extends GetxController {
  final PlayerStatsRepository _playerStatsRepository;

  TopScorersController(this._playerStatsRepository);

  final _topScorersState = Rx<ViewState<List<TopScorerResponse>>>(ViewStateInitial());

  get topScorersState => _topScorersState.value;

  @override
  void onInit() {
    super.onInit();
    fetchTopScorers(leagueId: 39, season: 2021);
  }

  Future<void> fetchTopScorers({
    required int leagueId,
    required int season,
  }) async {
    _topScorersState.value = const ViewStateLoading();

    try {
      final data = await _playerStatsRepository.getTopScorers(
        leagueId: leagueId,
        season: season,
      );

      _topScorersState.value = ViewStateSuccess(data);
    } catch (e) {
      _topScorersState.value = ViewStateError(e.toString());
    }
  }

  // Optional: For refreshing only
  Future<void> refreshTopScorers({
    required int leagueId,
    required int season,
  }) async {
    await fetchTopScorers(leagueId: leagueId, season: season);
  }
}
