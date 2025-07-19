import 'package:flutter/material.dart';
import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/modules/league/models/league_response.dart';
import 'package:football_app/modules/league_picker/controllers/league_season_picker_controller.dart';
import 'package:football_app/modules/league_picker/widgets/league_tile.dart';
import 'package:football_app/widgets/view_state_error_widget.dart';
import 'package:get/get.dart';

class LeagueList extends StatelessWidget {
  const LeagueList({
    super.key,
    required this.controller,
  });

  final LeagueSeasonPickerController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final state = controller.leaguesState;

      if (state is ViewStateLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state is ViewStateError) {
        return ViewStateErrorWidget(
          message: state.message,
          onRetry: () => controller.fetchLeagues(),
        );
      }

      if (state is ViewStateSuccess<List<LeagueResponse>>) {
        final leagues = state.data;
        return ListView.separated(
          itemCount: leagues.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, index) {
            final league = leagues[index].league;
            return LeagueTile(
              league: league,
              onTap: () {
                Get.back(result: {
                  'id': league.id,
                  'name': league.name,
                  'season': controller.selectedSeason.value,
                });
              },
            );
          },
        );
      }

      return const SizedBox(); // ViewStateInitial or fallback
    });
  }
}
