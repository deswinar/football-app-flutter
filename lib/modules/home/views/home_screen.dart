import 'package:flutter/material.dart';
import 'package:football_app/modules/home/controllers/home_controller.dart';
import 'package:football_app/modules/home/widgets/league_season_info_picker.dart';
import 'package:football_app/modules/top_assists/controllers/top_assists_controller.dart';
import 'package:football_app/modules/top_assists/widgets/top_assists_list.dart';
import 'package:football_app/modules/top_scorers/controllers/top_scorers_controller.dart';
import 'package:football_app/modules/top_scorers/widgets/top_scorers_list.dart';
import 'package:football_app/widgets/section_header.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final topScorersController = Get.find<TopScorersController>();
  final topAssistsController = Get.find<TopAssistsController>();
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football Stats'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            topScorersController.refreshTopScorers(
              leagueId: homeController.leagueId.value,
              season: homeController.seasonYear.value,
            ),
            topAssistsController.refreshTopAssists(
              leagueId: homeController.leagueId.value,
              season: homeController.seasonYear.value,
            ),
          ]);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tappable League & Season Info
              LeagueSeasonInfoPicker(homeController: homeController, topScorersController: topScorersController, topAssistsController: topAssistsController),

              const SizedBox(height: 16),
              SectionHeader(title: 'Top Scorers', icon: Icons.sports_soccer),
              const SizedBox(height: 8),
              TopScorersList(topScorersController: topScorersController),

              const SizedBox(height: 24),
              SectionHeader(title: 'Top Assists', icon: Icons.group),
              const SizedBox(height: 8),
              TopAssistsList(topAssistsController: topAssistsController),

              const SizedBox(height: 24),
              SectionHeader(title: 'Player of the Week', icon: Icons.star),
              const SizedBox(height: 8),
              _buildPlayerOfTheWeek(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerOfTheWeek() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: Colors.grey[300],
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: 'https://picsum.photos/72',
                width: 72,
                height: 72,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    const CircularProgressIndicator(strokeWidth: 2),
                errorWidget: (_, __, ___) => const Icon(Icons.error, size: 36),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'John Doe',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '3 Goals • 2 Assists',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
