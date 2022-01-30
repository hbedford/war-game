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
  factory Continent.fromJson(Map<String, dynamic> map) => Continent(
        id: map['id'],
        name: map['name'],
        territories: map['territories']
            .map<Territory>((territory) => Territory.fromJson(territory))
            .toList(),
        bonus: map['bonus'],
      );
  int get length => territories.length;
}
