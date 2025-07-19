// player_card.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football_app/data/responses/top_scorer_response.dart';

class PlayerCard extends StatelessWidget {
  final TopScorerResponse player;

  const PlayerCard({required this.player, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[300],
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: player.player.photo,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    const CircularProgressIndicator(strokeWidth: 2),
                errorWidget: (_, __, ___) => const Icon(Icons.error, size: 28),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            player.player.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          Text(
            '${player.statistics.first.goals['total'] ?? 0} Goals',
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
