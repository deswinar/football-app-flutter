import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static final String baseUrl = 'https://v3.football.api-sports.io/';
  static final String apiHost = dotenv.env['X_RAPIDAPI_HOST'] ?? '';
  static final String apiKey = dotenv.env['X_RAPIDAPI_KEY'] ?? '';
}