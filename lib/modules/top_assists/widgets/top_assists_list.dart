import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/data/responses/top_assist_response.dart';
import 'package:football_app/modules/top_assists/controllers/top_assists_controller.dart';
import 'package:football_app/widgets/player_card_skeleton.dart';
import 'package:football_app/widgets/view_state_error_widget.dart';
import 'package:get/get.dart';

class TopAssistsList extends StatelessWidget {
  const TopAssistsList({
    super.key,
    required this.topAssistsController,
  });

  final TopAssistsController topAssistsController;

  @override
  Widget build(BuildContext context) {
  return Obx(() {
    final state = topAssistsController.topAssistsState;
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
        onRetry: () => topAssistsController.retry(),
      );
    } else if (state is ViewStateSuccess<List<TopAssistResponse>>) {
      final players = state.data;
      if (players.isEmpty) {
        return const Text('No data available.');
      }

      return SizedBox(
        height: 140,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: players.length,
          itemBuilder: (_, i) {
            final player = players[i];
            return Container(
              width: 100,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.blue[50],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey[300],
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: player.player.photo,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => const CircularProgressIndicator(strokeWidth: 2),
                        errorWidget: (_, __, ___) => const Icon(Icons.error, size: 24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    player.player.name,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${player.statistics.first.goals['assists'] ?? 0} Assists',
                    style: const TextStyle(fontSize: 11, color: Colors.black54),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 10),
        ),
      );
    }
    return const SizedBox.shrink();
  });
}
}
