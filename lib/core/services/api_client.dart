import 'package:dio/dio.dart';
import 'api_exceptions.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? query}) async {
    try {
      return await dio.get<T>(path, queryParameters: query);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    try {
      return await dio.post<T>(path, data: data, queryParameters: query);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    try {
      return await dio.put<T>(path, data: data, queryParameters: query);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    try {
      return await dio.patch<T>(path, data: data, queryParameters: query);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Response<T>> delete<T>(String path, {Map<String, dynamic>? query}) async {
    try {
      return await dio.delete<T>(path, queryParameters: query);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}
