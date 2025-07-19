import 'package:football_app/core/services/api_client.dart';
import 'package:football_app/core/services/storage_service.dart';
import 'package:football_app/data/repositories/country_repository.dart';
import 'package:football_app/data/repositories/season_repository.dart';
import 'package:football_app/modules/league/repositories/league_repository.dart';
import 'package:football_app/modules/league_picker/controllers/league_season_picker_controller.dart';
import 'package:get/get.dart';

class LeagueSeasonPickerBinding extends Bindings {
  @override
  void dependencies() {
    // Repository
    Get.lazyPut(() => LeagueRepository(Get.find<ApiClient>()));
    Get.lazyPut(() => SeasonRepository(Get.find<ApiClient>()));
    Get.lazyPut(() => CountryRepository(Get.find<ApiClient>()));
    Get.lazyPut(() => StorageService());

    // Controller
    Get.lazyPut(() => LeagueSeasonPickerController(
      leagueRepository: Get.find<LeagueRepository>(),
      seasonRepository: Get.find<SeasonRepository>(),
      countryRepository: Get.find<CountryRepository>(),
      storageService: Get.find<StorageService>(),
    ));
  }
}
