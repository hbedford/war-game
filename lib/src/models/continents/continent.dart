import 'package:war/src/models/territory/territory.dart';

class Continent {
  final int id;
  final String name;
  final List<Territory> territories;
  final int bonus;
  Continent({
    required this.id,
    required this.name,
    required this.territories,
    required this.bonus,
  });
  int get length => territories.length;
}
