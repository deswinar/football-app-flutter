import 'package:get/get.dart';

class HomeController extends GetxController {
  final leagueId = 39.obs;
  final leagueName = 'Premier League'.obs;
  final seasonYear = 2023.obs;

  void updateLeagueAndSeason({
    required int id,
    required String name,
    required int season,
  }) {
    leagueId.value = id;
    leagueName.value = name;
    seasonYear.value = season;
  }
}
