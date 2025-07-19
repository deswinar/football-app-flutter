import 'package:flutter/material.dart';
import 'package:football_app/modules/home/controllers/home_controller.dart';
import 'package:football_app/modules/top_assists/controllers/top_assists_controller.dart';
import 'package:football_app/modules/top_scorers/controllers/top_scorers_controller.dart';
import 'package:football_app/routes/app_routes.dart';
import 'package:get/get.dart';

class LeagueSeasonInfoPicker extends StatelessWidget {
  const LeagueSeasonInfoPicker({
    super.key,
    required this.homeController,
    required this.topScorersController,
    required this.topAssistsController,
  });

  final HomeController homeController;
  final TopScorersController topScorersController;
  final TopAssistsController topAssistsController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Get.toNamed(AppRoutes.leagueSeasonPicker);
        if (result != null) {
          homeController.updateLeagueAndSeason(
            id: result['id'],
            name: result['name'],
            season: result['season'],
          );
          topScorersController.fetchTopScorers(
            leagueId: result['id'],
            season: result['season'],
          );
          topAssistsController.fetchTopAssists(
            leagueId: result['id'],
            season: result['season'],
          );
        }
      },
      child: Obx(() {
        final leagueName = homeController.leagueName.value;
        final seasonYear = homeController.seasonYear.value;
    
        return Row(
          children: [
            const Icon(Icons.emoji_events, size: 18, color: Colors.grey),
            const SizedBox(width: 6),
            Text(
              '$leagueName • $seasonYear/${seasonYear + 1}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        );
      }),
    );
  }
}
