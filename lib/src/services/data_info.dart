import 'package:flutter/rendering.dart';
import 'package:war/src/models/continents/continent.dart';
import 'package:war/src/models/territory/territory.dart';

DataTerritory data = DataTerritory();

class DataInfo {
  Continent americaDoNorte = Continent(
    id: 1,
    name: 'America do Norte',
    territories: [
      data.alaska,
      data.mackenzie,
      data.groelandia,
      data.vancouver,
      data.ottawa,
      data.labrador,
      data.california,
      data.novaYork,
      data.mexico
    ],
    bonus: 5,
  );
  Continent americaDoSul = Continent(
    id: 2,
    name: 'America do Sul',
    territories: [data.venezuela, data.peru, data.brasil, data.argelia],
    bonus: 2,
  );
  Continent europa = Continent(
    id: 3,
    name: 'Europa',
    territories: [
      data.islandia,
      data.inglaterra,
      data.suecia,
      data.alemanha,
      data.moscou,
      data.portugal,
      data.italia
    ],
    bonus: 5,
  );

  Continent africa = Continent(
    id: 4,
    name: 'Africa',
    territories: [
      data.argelia,
      data.egito,
      data.sudao,
      data.congo,
      data.africaDoSul,
      data.madagascar
    ],
    bonus: 3,
  );
  Continent asia = Continent(
    id: 5,
    name: 'Asia',
    territories: [
      data.omsk,
      data.dudinka,
      data.siberia,
      data.vladvostok,
      data.aral,
      data.tchita,
      data.mongolia,
      data.orienteMedio,
      data.india,
      data.china,
      data.japao,
      data.vietna
    ],
    bonus: 7,
  );
  Continent oceania = Continent(
    id: 6,
    name: 'Oceania',
    territories: [data.sumatra, data.borneo, data.novaGuine, data.australia],
    bonus: 2,
  );
}

class DataTerritory {
  List<Territory> get territories => [
        alaska,
        mackenzie,
        groelandia,
        vancouver,
        ottawa,
        labrador,
        california,
        novaYork,
        mexico,
        venezuela,
        peru,
        brasil
      ];
  final alaska = Territory(
    id: 1,
    continentId: 1,
    name: 'Alaska',
    offset: Offset(8, 10),
    neighbors: [2, 4, 30],
  );
  final mackenzie = Territory(
    id: 2,
    continentId: 1,
    name: 'Mackenzie',
    offset: Offset(15, 10),
    neighbors: [3, 4, 1],
  );
  final groelandia = Territory(
    id: 3,
    continentId: 1,
    name: 'Groelandia',
    offset: Offset(29, 8),
    neighbors: [6, 2, 14],
  );
  final vancouver = Territory(
    id: 4,
    continentId: 1,
    name: 'Vancouver',
    offset: Offset(10, 20),
    neighbors: [7, 5, 2, 1],
  );
  final ottawa = Territory(
    id: 5,
    continentId: 1,
    name: 'Ottawa',
    offset: Offset(18, 20),
    neighbors: [6, 8, 7, 4, 2],
  );
  final labrador = Territory(
    id: 6,
    continentId: 1,
    name: 'Labrador',
    offset: Offset(22, 15),
    neighbors: [8, 5, 3],
  );
  final california = Territory(
    id: 7,
    continentId: 1,
    name: 'California',
    offset: Offset(10, 30),
    neighbors: [9, 8, 4, 5],
  );
  final novaYork = Territory(
    id: 8,
    continentId: 1,
    name: 'Nova York',
    offset: Offset(18, 28),
    neighbors: [9, 7, 6, 5],
  );
  final mexico = Territory(
    id: 9,
    continentId: 1,
    name: 'Mexico',
    offset: Offset(17, 37),
    neighbors: [10, 8, 7],
  );
  final venezuela = Territory(
    id: 10,
    continentId: 2,
    name: 'Venezuela',
    offset: Offset(20, 50),
    neighbors: [12, 11, 9],
  );
  final peru = Territory(
    id: 11,
    continentId: 2,
    name: 'Peru',
    neighbors: [13, 12, 10],
  );
  final brasil = Territory(
      id: 12,
      continentId: 2,
      name: 'Brasil',
      neighbors: [13, 11, 10, 21],
      offset: Offset(24, 46));
  final argentina = Territory(
    id: 13,
    continentId: 2,
    name: 'Argentina',
    neighbors: [12, 11],
  );
  final islandia = Territory(
    id: 14,
    continentId: 3,
    name: 'Islandia',
    neighbors: [15, 3],
  );
  final inglaterra = Territory(
    id: 15,
    continentId: 3,
    name: 'Inglaterra',
    neighbors: [16, 14, 17, 19],
  );
  final suecia = Territory(
    id: 16,
    continentId: 3,
    name: 'Suecia',
    neighbors: [18, 15],
  );
  final alemanha = Territory(
    id: 17,
    continentId: 3,
    name: 'Alemanha',
    neighbors: [20, 19, 15],
  );
  final moscou = Territory(
    id: 18,
    continentId: 3,
    name: 'Moscou',
    neighbors: [20, 34, 31, 27, 16],
  );
  final portugal = Territory(
    id: 19,
    continentId: 3,
    name: 'França',
    neighbors: [22, 21, 20, 17, 15],
  );
  final italia = Territory(
    id: 20,
    continentId: 3,
    name: 'Polonia',
    neighbors: [22, 34, 18, 17, 19],
  );
  final argelia = Territory(
    id: 21,
    continentId: 4,
    name: 'Argelia',
    neighbors: [22, 23, 24, 12, 19],
  );
  final egito = Territory(
    id: 22,
    continentId: 4,
    name: 'Egito',
    neighbors: [23, 21, 34, 20, 19],
  );
  final sudao = Territory(
    id: 23,
    continentId: 4,
    name: 'Sudão',
    neighbors: [25, 24, 26, 21, 22],
  );
  final congo = Territory(
    id: 24,
    continentId: 4,
    name: 'Congo',
    neighbors: [25, 23, 21],
  );
  final africaDoSul = Territory(
    id: 25,
    continentId: 4,
    name: 'Africa do Sul',
    neighbors: [26, 24, 23],
  );
  final madagascar = Territory(
    id: 26,
    continentId: 4,
    name: 'Madagascar',
    neighbors: [25, 23],
  );
  final omsk = Territory(
    id: 27,
    continentId: 5,
    name: 'Omsk',
    neighbors: [28, 33, 31, 36],
  );
  final dudinka = Territory(
    id: 28,
    continentId: 5,
    name: 'Dudinka',
    neighbors: [29, 32, 33, 27],
  );
  final siberia = Territory(
    id: 29,
    continentId: 5,
    name: 'Sibéria',
    neighbors: [30, 32, 28],
  );
  final vladvostok = Territory(
    id: 30,
    continentId: 5,
    name: 'Vladvostok',
    neighbors: [1, 29, 32, 36, 37],
  );
  final aral = Territory(
    id: 31,
    continentId: 5,
    name: 'Aral',
    neighbors: [27, 36, 34, 35, 18],
  );
  final tchita = Territory(
    id: 32,
    continentId: 5,
    name: 'Tchita',
    neighbors: [33, 36, 30, 29, 27, 28],
  );
  final mongolia = Territory(
    id: 33,
    continentId: 5,
    name: 'Mongólia',
    neighbors: [36, 32, 28, 27],
  );
  final orienteMedio = Territory(
    id: 34,
    continentId: 5,
    name: 'Oriente Médio',
    neighbors: [35, 31, 18, 20, 22],
  );
  final india = Territory(
    id: 35,
    continentId: 5,
    name: 'Índia',
    neighbors: [39, 38, 34, 31, 36],
  );
  final china = Territory(
    id: 36,
    continentId: 5,
    name: 'China',
    neighbors: [38, 35, 37, 31, 27, 33, 32, 30],
  );
  final japao = Territory(
    id: 37,
    continentId: 5,
    name: 'Japão',
    neighbors: [36, 30],
  );
  final vietna = Territory(
    id: 38,
    continentId: 5,
    name: 'Vietnã',
    neighbors: [40, 35, 36],
  );
  final sumatra = Territory(
    id: 39,
    continentId: 6,
    name: 'Sumatra',
    neighbors: [35, 42],
  );
  final borneo = Territory(
    id: 40,
    continentId: 6,
    name: 'Borneo',
    neighbors: [42, 41, 38],
  );
  final novaGuine = Territory(
    id: 41,
    continentId: 6,
    name: 'Nova Guine',
    neighbors: [42, 40],
  );
  final australia = Territory(
    id: 42,
    continentId: 6,
    name: 'Austrália',
    neighbors: [41, 40, 39],
  );
}
