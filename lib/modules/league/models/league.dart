class League {
  final int id;
  final String name;
  final String type;
  final String logo;

  League({
    required this.id,
    required this.name,
    required this.type,
    required this.logo,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      logo: json['logo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'logo': logo,
    };
  }
}
