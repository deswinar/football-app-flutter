import 'package:flutter/material.dart';
import 'package:football_app/modules/fixtures/models/fixture_response.dart';
import 'package:football_app/modules/fixtures/widgets/status_badge.dart';
import 'package:football_app/modules/fixtures/widgets/team_info_widget.dart';
import 'package:intl/intl.dart';

class FixturesCard extends StatelessWidget {
  const FixturesCard({
    super.key,
    required this.league,
    required this.status,
    required this.fixture,
    required this.homeTeam,
    required this.awayTeam,
    required this.venue,
  });

  final LeagueData league;
  final FixtureStatus? status;
  final FixtureData fixture;
  final TeamInfo? homeTeam;
  final TeamInfo? awayTeam;
  final FixtureVenue? venue;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // League info
            Row(
              children: [
                if (league.logo != null)
                  Image.network(
                    league.logo!,
                    height: 20,
                    width: 20,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.error, size: 16),
                  ),
                const SizedBox(width: 6),
                Text(
                  league.name ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                StatusBadge(status: status?.short),
              ],
            ),
            const SizedBox(height: 12),
    
            // Match time
            Text(
              fixture.date != null
                  ? DateFormat('hh:mm a • dd MMM yyyy')
                      .format(fixture.date!.toLocal())
                  : 'No date available',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
    
            // Teams
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: TeamInfoWidget(team: homeTeam, isRight: false)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('vs'),
                ),
                Flexible(child: TeamInfoWidget(team: awayTeam, isRight: true)), // reversed order
              ],
            ),
    
            const SizedBox(height: 12),
    
            // Venue & Referee
            if (venue?.name != null || fixture.referee != null)
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      venue?.name ?? 'Unknown venue',
                      style: const TextStyle(fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  if (fixture.referee != null) ...[
                    const SizedBox(width: 8),
                    const Icon(Icons.person, size: 16),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        fixture.referee!,
                        style: const TextStyle(fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}
