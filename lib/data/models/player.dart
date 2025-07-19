import 'package:football_app/data/models/birth.dart';

class Player {
  final int id;
  final String name;
  final String firstname;
  final String lastname;
  final int age;
  final Birth birth;
  final String nationality;
  final String height;
  final String weight;
  final bool injured;
  final String photo;

  Player({
    required this.id,
    required this.name,
    required this.firstname,
    required this.lastname,
    required this.age,
    required this.birth,
    required this.nationality,
    required this.height,
    required this.weight,
    required this.injured,
    required this.photo,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      age: json['age'] ?? 0,
      birth: json['birth'] != null ? Birth.fromJson(json['birth']) : Birth.empty(),
      nationality: json['nationality'] ?? '',
      height: json['height'] ?? '',
      weight: json['weight'] ?? '',
      injured: json['injured'] ?? false,
      photo: json['photo'] ?? '',
    );
  }
}
