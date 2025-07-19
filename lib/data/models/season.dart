  class Season {
  final int year;
  final String start;
  final String end;
  final bool current;

  Season({
    required this.year,
    required this.start,
    required this.end,
    required this.current,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      year: json['year'] ?? 0,
      start: json['start'] ?? '',
      end: json['end'] ?? '',
      current: json['current'] ?? false,
    );
  }
}