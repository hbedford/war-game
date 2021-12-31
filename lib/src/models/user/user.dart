import 'package:war/src/models/objective/objective.dart';

class User {
  final int id;
  final String name;
  final Objective objective;
  User({
    required this.id,
    required this.name,
    required this.objective,
  });
}
