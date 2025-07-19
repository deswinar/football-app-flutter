class FixtureResponse {
  final List<FixtureEntry> response;

  FixtureResponse({required this.response});

  factory FixtureResponse.fromJson(Map<String, dynamic> json) {
    final responseList = json['response'] as List<dynamic>? ?? [];
    return FixtureResponse(
      response: responseList.map((e) => FixtureEntry.fromJson(e)).toList(),
    );
  }
}

class FixtureEntry {
  final FixtureData fixture;
  final LeagueData league;
  final TeamsData teams;
  final GoalsData goals;
  final ScoreData score;

  FixtureEntry({
    required this.fixture,
    required this.league,
    required this.teams,
    required this.goals,
    required this.score,
  });

  factory FixtureEntry.fromJson(Map<String, dynamic> json) {
    return FixtureEntry(
      fixture: FixtureData.fromJson(json['fixture']),
      league: LeagueData.fromJson(json['league']),
      teams: TeamsData.fromJson(json['teams']),
      goals: GoalsData.fromJson(json['goals']),
      score: ScoreData.fromJson(json['score']),
    );
  }
}

class FixtureData {
  final int? id;
  final String? referee;
  final String? timezone;
  final DateTime? date;
  final int? timestamp;
  final FixturePeriods? periods;
  final FixtureVenue? venue;
  final FixtureStatus? status;

  FixtureData({
    this.id,
    this.referee,
    this.timezone,
    this.date,
    this.timestamp,
    this.periods,
    this.venue,
    this.status,
  });

  factory FixtureData.fromJson(Map<String, dynamic> json) {
    return FixtureData(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
      referee: json['referee']?.toString(),
      timezone: json['timezone']?.toString(),
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      timestamp: json['timestamp'] is int ? json['timestamp'] : int.tryParse(json['timestamp'].toString()),
      periods: json['periods'] != null
          ? FixturePeriods.fromJson(json['periods'])
          : null,
      venue: json['venue'] != null
          ? FixtureVenue.fromJson(json['venue'])
          : null,
      status: json['status'] != null
          ? FixtureStatus.fromJson(json['status'])
          : null,
    );
  }
}


class FixturePeriods {
  final int? first;
  final int? second;

  FixturePeriods({
    this.first,
    this.second,
  });

  factory FixturePeriods.fromJson(Map<String, dynamic> json) {
    return FixturePeriods(
      first: json['first'],
      second: json['second'],
    );
  }
}

class FixtureVenue {
  final int? id;
  final String? name;
  final String? city;

  FixtureVenue({
    this.id,
    this.name,
    this.city,
  });

  factory FixtureVenue.fromJson(Map<String, dynamic> json) {
    return FixtureVenue(
      id: json['id'],
      name: json['name'],
      city: json['city'],
    );
  }
}

class FixtureStatus {
  final String? long;
  final String? short;
  final dynamic elapsed;
  final dynamic extra;

  FixtureStatus({
    this.long,
    this.short,
    this.elapsed,
    this.extra,
  });

  factory FixtureStatus.fromJson(Map<String, dynamic> json) {
    return FixtureStatus(
      long: json['long'],
      short: json['short'],
      elapsed: json['elapsed'] is int ? json['elapsed'] : int.tryParse(json['elapsed'].toString()),
      extra: json['extra'] is String ? json['extra'] : json['extra'].toString(),
    );
  }
}

class LeagueData {
  final int? id;
  final String? name;
  final String? country;
  final String? logo;
  final String? flag;
  final int? season;
  final String? round;
  final bool? standings;

  LeagueData({
    this.id,
    this.name,
    this.country,
    this.logo,
    this.flag,
    this.season,
    this.round,
    this.standings,
  });

  factory LeagueData.fromJson(Map<String, dynamic> json) {
    return LeagueData(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      logo: json['logo'],
      flag: json['flag'],
      season: json['season'],
      round: json['round'],
      standings: json['standings'],
    );
  }
}

class TeamsData {
  final TeamInfo? home;
  final TeamInfo? away;

  TeamsData({
    this.home,
    this.away,
  });

  factory TeamsData.fromJson(Map<String, dynamic> json) {
    return TeamsData(
      home: json['home'] != null ? TeamInfo.fromJson(json['home']) : null,
      away: json['away'] != null ? TeamInfo.fromJson(json['away']) : null,
    );
  }
}

class TeamInfo {
  final int? id;
  final String? name;
  final String? logo;
  final bool? winner;

  TeamInfo({
    this.id,
    this.name,
    this.logo,
    this.winner,
  });

  factory TeamInfo.fromJson(Map<String, dynamic> json) {
    return TeamInfo(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      winner: json['winner'],
    );
  }
}

class GoalsData {
  final int? home;
  final int? away;

  GoalsData({
    this.home,
    this.away,
  });

  factory GoalsData.fromJson(Map<String, dynamic> json) {
    return GoalsData(
      home: json['home'],
      away: json['away'],
    );
  }
}

class ScoreData {
  final ScoreTime? halftime;
  final ScoreTime? fulltime;
  final ScoreTime? extratime;
  final ScoreTime? penalty;

  ScoreData({
    this.halftime,
    this.fulltime,
    this.extratime,
    this.penalty,
  });

  factory ScoreData.fromJson(Map<String, dynamic> json) {
    return ScoreData(
      halftime: json['halftime'] != null ? ScoreTime.fromJson(json['halftime']) : null,
      fulltime: json['fulltime'] != null ? ScoreTime.fromJson(json['fulltime']) : null,
      extratime: json['extratime'] != null ? ScoreTime.fromJson(json['extratime']) : null,
      penalty: json['penalty'] != null ? ScoreTime.fromJson(json['penalty']) : null,
    );
  }
}

class ScoreTime {
  final int? home;
  final int? away;

  ScoreTime({
    this.home,
    this.away,
  });

  factory ScoreTime.fromJson(Map<String, dynamic> json) {
    return ScoreTime(
      home: json['home'],
      away: json['away'],
    );
  }
}
