import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:football_app/core/services/api_exceptions.dart';
import '../constants/app_constants.dart';

class DioService {
  static Dio buildDioClient() {
    final options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      responseType: ResponseType.json,
      headers: {
        'x-rapidapi-key': AppConstants.apiKey,
        'x-rapidapi-host': AppConstants.baseUrl,
        'Content-Type': 'application/json',
      },
    );

    final dio = Dio(options);

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => debugPrint(obj.toString()),
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException err, handler) {
        final apiError = ApiException.fromDioError(err);
        handler.reject(apiError.toDioError());
      },
    ));

    return dio;
  }
}
