import 'package:flutter/material.dart';
import 'package:football_app/modules/fixtures/models/fixture_response.dart';
import 'package:football_app/modules/fixtures/widgets/fixtures_card.dart';

class FixturesList extends StatelessWidget {
  const FixturesList({
    super.key,
    required this.fixtures,
  });

  final List<FixtureEntry> fixtures;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: fixtures.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final entry = fixtures[index];
        final fixture = entry.fixture;
        final league = entry.league;
        final venue = fixture.venue;
        final status = fixture.status;
        final homeTeam = entry.teams.home;
        final awayTeam = entry.teams.away;
    
        return FixturesCard(league: league, status: status, fixture: fixture, homeTeam: homeTeam, awayTeam: awayTeam, venue: venue);
      },
    );
  }
}