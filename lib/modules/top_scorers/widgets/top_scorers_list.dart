import 'package:flutter/material.dart';
import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/data/responses/top_scorer_response.dart';
import 'package:football_app/modules/top_scorers/controllers/top_scorers_controller.dart';
import 'package:football_app/widgets/player_card.dart';
import 'package:football_app/widgets/player_card_skeleton.dart';
import 'package:football_app/widgets/view_state_error_widget.dart';
import 'package:get/get.dart';

class TopScorersList extends StatelessWidget {
  const TopScorersList({
    super.key,
    required this.topScorersController,
  });

  final TopScorersController topScorersController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final state = topScorersController.topScorersState;
      if (state is ViewStateLoading) {
        return SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (_, __) => const PlayerCardSkeleton(),
            separatorBuilder: (_, __) => const SizedBox(width: 12),
          ),
        );
      } else if (state is ViewStateError) {
        return ViewStateErrorWidget(
          message: state.message,
          onRetry: () => topScorersController.fetchTopScorers(
            leagueId: 39,
            season: 2023,
          ),
        );
      } else if (state is ViewStateSuccess<List<TopScorerResponse>>) {
        final players = state.data;
        if (players.isEmpty) {
          return const Text('No data available.');
        }
        return SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: players.length,
            itemBuilder: (_, i) => PlayerCard(player: players[i]),
            separatorBuilder: (_, __) => const SizedBox(width: 12),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
