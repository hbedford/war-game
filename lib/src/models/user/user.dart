import 'package:war/src/models/objective/objective.dart';

class User {
  final int id;
  final String name;
  final String email;
  final Objective? objective;
  int soldiers;
  User(
      {required this.id,
      required this.name,
      required this.email,
      this.objective,
      required this.soldiers});
  factory User.fromJson(Map map) => User(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        soldiers: 0,
      );
  Map<String, dynamic> get toMap => {
        'id': id,
        'name': name,
        'email': email,
      };
}
