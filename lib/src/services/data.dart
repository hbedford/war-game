import 'package:flutter/rendering.dart';
import 'package:war/src/models/continents/continent.dart';
import 'package:war/src/models/territory/territory.dart';

DataTerritory data = DataTerritory();

class Data {
  Continent americaDoNorte = Continent(
    id: 0,
    name: 'America do Norte',
    territories: [
      data.alaska,
      data.mackenzie,
      data.groelandia,
      data.vancouver,
      data.ohio,
      data.labrador,
      data.california,
      data.novaYork,
      /*  data.mexico, */
    ],
    bonus: 5,
  );
}

class DataTerritory {
  final alaska = Territory(id: 0, name: 'Alaska', offset: Offset(8, 15));
  final mackenzie = Territory(id: 1, name: 'Mackenzie', offset: Offset(15, 15));
  final groelandia =
      Territory(id: 2, name: 'Groelandia', offset: Offset(30, 8));
  final vancouver = Territory(id: 3, name: 'Vancouver', offset: Offset(10, 20));
  final ohio = Territory(id: 4, name: 'Ohio', offset: Offset(18, 20));
  final labrador = Territory(id: 5, name: 'Labrador', offset: Offset(25, 18));
  final california =
      Territory(id: 6, name: 'California', offset: Offset(10, 26));
  final novaYork = Territory(id: 7, name: 'Nova York', offset: Offset(23, 24));
  final mexico = Territory(id: 8, name: 'Mexico', offset: Offset(17, 38));
  final venezuela = Territory(id: 9, name: 'Venezuela');
  final peru = Territory(id: 10, name: 'Peru');
  final brasil = Territory(id: 11, name: 'Brasil');
  final argentina = Territory(id: 12, name: 'Argentina');
  final islandia = Territory(id: 13, name: 'Islandia');
  final inglaterra = Territory(id: 14, name: 'Inglaterra');
  final suecia = Territory(id: 15, name: 'Suecia');
  final alemanha = Territory(id: 16, name: 'Alemanha');
  final moscou = Territory(id: 17, name: 'Moscou');
  final portugal = Territory(id: 18, name: 'Portugal');
  final italia = Territory(id: 19, name: 'Italia');
  final argelia = Territory(id: 20, name: 'Argelia');
  final egito = Territory(id: 20, name: 'Egito');
  final sudao = Territory(id: 20, name: 'Sudão');
  final congo = Territory(id: 20, name: 'Congo');
  final africaDoSul = Territory(id: 20, name: 'Africa do Sul');
  final madagascar = Territory(id: 20, name: 'Madagascar');
}
