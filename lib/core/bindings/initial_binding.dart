import 'package:football_app/core/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../services/dio_service.dart';
import '../services/api_client.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() => DioService.buildDioClient());
    Get.lazyPut<ApiClient>(() => ApiClient(Get.find<Dio>()));
    Get.lazyPut<StorageService>(() => StorageService());
  }
}
