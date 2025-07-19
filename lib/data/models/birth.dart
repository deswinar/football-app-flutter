class Birth {
  final String date;
  final String place;
  final String country;

  Birth({
    required this.date,
    required this.place,
    required this.country,
  });

  factory Birth.fromJson(Map<String, dynamic> json) {
    return Birth(
      date: json['date'] ?? '',
      place: json['place'] ?? '',
      country: json['country'] ?? '',
    );
  }

  factory Birth.empty() {
    return Birth(date: '', place: '', country: '');
  }
}
