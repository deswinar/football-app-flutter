import 'package:football_app/core/services/api_client.dart';
import 'package:football_app/modules/fixtures/controllers/fixtures_controller.dart';
import 'package:football_app/modules/fixtures/repositories/fixtures_repository.dart';
import 'package:get/get.dart';
class FixturesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FixturesRepository(Get.find<ApiClient>()));
    Get.lazyPut(() => FixturesController(Get.find<FixturesRepository>()));
  }
}
