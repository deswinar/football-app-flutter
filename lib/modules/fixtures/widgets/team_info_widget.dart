import 'package:flutter/material.dart';
import 'package:football_app/modules/fixtures/models/fixture_response.dart';

class TeamInfoWidget extends StatelessWidget {
  const TeamInfoWidget({
    super.key,
    required this.team,
    required this.isRight,
  });

  final TeamInfo? team;
  final bool isRight;

  @override
  Widget build(BuildContext context) {
    final content = <Widget>[
      if (team?.logo != null)
        Image.network(
          team!.logo!,
          height: 24,
          width: 24,
          errorBuilder: (_, __, ___) => const Icon(Icons.error, size: 16),
        ),
      const SizedBox(width: 6),
      Expanded(
        child: Text(
          team?.name ?? '-',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: isRight ? TextAlign.right : TextAlign.left,
        ),
      ),
    ];

    return Row(
      mainAxisAlignment: isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: isRight ? content.reversed.toList() : content,
    );
  }
}
