import 'package:football_app/modules/home/controllers/home_controller.dart';
import 'package:football_app/modules/top_assists/controllers/top_assists_controller.dart';
import 'package:football_app/modules/top_scorers/controllers/top_scorers_controller.dart';
import 'package:get/get.dart';
import 'package:football_app/data/repositories/player_stats_repository.dart';
import 'package:football_app/core/services/api_client.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    //Repository
    Get.lazyPut(() => PlayerStatsRepository(Get.find<ApiClient>()));

    // Controller
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => TopScorersController(Get.find<PlayerStatsRepository>()));
    Get.lazyPut(() => TopAssistsController(Get.find<PlayerStatsRepository>()));
  }
}
