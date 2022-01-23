import 'package:war/src/services/data.dart';

class GetCorrectTerritory {
  GetCorrectTerritory._();
  static get(int id) =>
      DataTerritory().territories.firstWhere((territory) => territory.id == id);
}
