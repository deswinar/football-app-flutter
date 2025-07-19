import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? code;

  ApiException({required this.message, this.code});

  factory ApiException.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException(message: "Connection timed out");
      case DioExceptionType.sendTimeout:
        return ApiException(message: "Send timeout");
      case DioExceptionType.receiveTimeout:
        return ApiException(message: "Receive timeout");
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        final errorData = e.response?.data;

        String errorMessage = "Something went wrong";

        if (errorData is Map && errorData['message'] != null) {
          errorMessage = errorData['message'];
        }

        return ApiException(
          message: errorMessage,
          code: statusCode,
        );
      case DioExceptionType.cancel:
        return ApiException(message: "Request was cancelled");
      case DioExceptionType.unknown:
        return ApiException(message: "No Internet connection");
      default:
        return ApiException(message: "Unexpected error occurred");
    }
  }

  DioException toDioError() {
    return DioException(
      requestOptions: RequestOptions(path: ''),
      error: message,
      type: DioExceptionType.unknown,
    );
  }

  @override
  String toString() => message;
}
