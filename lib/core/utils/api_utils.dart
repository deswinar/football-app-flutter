import 'package:football_app/core/services/api_exceptions.dart';

void checkForApiError(Map<String, dynamic>? data, {int? statusCode}) {
  if (data == null) return;

  if (data['errors'] is Map && (data['errors'] as Map).isNotEmpty) {
    final message = data['errors'].values.first.toString();
    throw ApiException(message: message, code: statusCode);
  }
}
