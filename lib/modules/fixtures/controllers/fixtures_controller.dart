import 'package:football_app/modules/fixtures/repositories/fixtures_repository.dart';
import 'package:football_app/core/state/view_state.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:football_app/modules/fixtures/models/fixture_response.dart'; // for FixtureEntry

class FixturesController extends GetxController {
  final FixturesRepository _repository;

  FixturesController(this._repository);

  final _fixturesState = Rx<ViewState<List<FixtureEntry>>>(ViewStateInitial());
  get fixturesState => _fixturesState.value;

  final selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    fetchFixturesByDate(selectedDate.value);
  }

  String get formattedDate => DateFormat('yyyy-MM-dd').format(selectedDate.value);

  Future<void> fetchFixturesByDate(DateTime date) async {
    _fixturesState.value = const ViewStateLoading();

    try {
      final fixtures = await _repository.getFixturesByDate(
        DateFormat('yyyy-MM-dd').format(date),
      );
      _fixturesState.value = ViewStateSuccess(fixtures);
    } catch (e) {
      _fixturesState.value = ViewStateError(e.toString());
    }
  }

  Future<void> fetchLiveFixtures() async {
    _fixturesState.value = const ViewStateLoading();

    try {
      final fixtures = await _repository.getLiveFixtures();
      _fixturesState.value = ViewStateSuccess(fixtures);
    } catch (e) {
      _fixturesState.value = ViewStateError(e.toString());
    }
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
    fetchFixturesByDate(date);
  }
}
