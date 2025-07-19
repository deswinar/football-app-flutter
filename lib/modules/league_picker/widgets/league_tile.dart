import 'package:flutter/material.dart';
import 'package:football_app/modules/league/models/league.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LeagueTile extends StatelessWidget {
  final League league;
  final VoidCallback onTap;

  const LeagueTile({
    super.key,
    required this.league,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: league.logo,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 2),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
      title: Text(league.name),
      subtitle: Text(league.type),
      onTap: onTap,
    );
  }
}
