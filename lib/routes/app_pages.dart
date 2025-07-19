import 'package:football_app/modules/fixtures/bindings/fixtures_binding.dart';
import 'package:football_app/modules/fixtures/views/fixtures_screen.dart';
import 'package:football_app/modules/home/bindings/home_binding.dart';
import 'package:football_app/modules/home/views/home_screen.dart';
import 'package:football_app/modules/league_picker/bindings/league_season_picker_binding.dart';
import 'package:football_app/modules/league_picker/views/league_season_picker_screen.dart';
import 'package:football_app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.fixtures,
      page: () => FixturesScreen(),
      binding: FixturesBinding(),
    ),
    GetPage(
      name: AppRoutes.leagueSeasonPicker,
      page: () => LeagueSeasonPickerScreen(),
      binding: LeagueSeasonPickerBinding(),
    ),
  ];
}
