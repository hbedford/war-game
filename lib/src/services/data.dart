import 'package:flutter/rendering.dart';
import 'package:war/src/models/continents/continent.dart';
import 'package:war/src/models/territory/territory.dart';

DataTerritory data = DataTerritory();

class Data {
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
  final alaska = Territory(
    id: 1,
    name: 'Alaska',
    offset: Offset(8, 15),
    neighbors: [2, 4, 31],
  );
  final mackenzie = Territory(
      id: 2, name: 'Mackenzie', offset: Offset(15, 15), neighbors: [3, 4, 1]);
  final groelandia = Territory(
    id: 3,
    name: 'Groelandia',
    offset: Offset(30, 8),
    neighbors: [6, 2, 14],
  );
  final vancouver = Territory(
    id: 4,
    name: 'Vancouver',
    offset: Offset(10, 20),
    neighbors: [7, 5, 2, 1],
  );
  final ottawa = Territory(
    id: 5,
    name: 'Ottawa',
    offset: Offset(18, 20),
    neighbors: [6, 8, 7, 4, 2],
  );
  final labrador = Territory(
    id: 6,
    name: 'Labrador',
    offset: Offset(25, 18),
    neighbors: [8, 5, 3],
  );
  final california = Territory(
    id: 7,
    name: 'California',
    offset: Offset(10, 26),
    neighbors: [9, 8, 4, 5],
  );
  final novaYork = Territory(
    id: 8,
    name: 'Nova York',
    offset: Offset(23, 24),
    neighbors: [9, 7, 6, 5],
  );
  final mexico = Territory(
    id: 9,
    name: 'Mexico',
    offset: Offset(17, 38),
    neighbors: [10, 8, 7],
  );
  final venezuela = Territory(
    id: 10,
    name: 'Venezuela',
    neighbors: [12, 11, 9],
  );
  final peru = Territory(
    id: 11,
    name: 'Peru',
    neighbors: [13, 12, 10],
  );
  final brasil = Territory(
    id: 12,
    name: 'Brasil',
    neighbors: [13, 11, 10, 22],
  );
  final argentina = Territory(
    id: 13,
    name: 'Argentina',
    neighbors: [12, 11],
  );
  final islandia = Territory(
    id: 14,
    name: 'Islandia',
    neighbors: [15, 3],
  );
  final inglaterra = Territory(
    id: 15,
    name: 'Inglaterra',
    neighbors: [16, 14, 17, 19],
  );
  final suecia = Territory(
    id: 16,
    name: 'Suecia',
    neighbors: [18, 15],
  );
  final alemanha = Territory(
    id: 17,
    name: 'Alemanha',
    neighbors: [20, 19, 15],
  );
  final moscou = Territory(
    id: 18,
    name: 'Moscou',
    neighbors: [20, 35, 32, 28, 16],
  );
  final portugal = Territory(
    id: 19,
    name: 'França',
    neighbors: [23, 22, 20, 17, 15],
  );
  final italia = Territory(
    id: 20,
    name: 'Polonia',
    neighbors: [23, 35, 18, 17, 19],
  );
  final argelia = Territory(
    id: 22,
    name: 'Argelia',
    neighbors: [23, 24, 25, 12, 19],
  );
  final egito = Territory(
    id: 23,
    name: 'Egito',
    neighbors: [24, 22, 35, 20, 19],
  );
  final sudao = Territory(
    id: 24,
    name: 'Sudão',
    neighbors: [26, 25, 27, 22, 23],
  );
  final congo = Territory(
    id: 25,
    name: 'Congo',
    neighbors: [26, 24, 22],
  );
  final africaDoSul =
      Territory(id: 26, name: 'Africa do Sul', neighbors: [27, 25, 24]);
  final madagascar = Territory(
    id: 27,
    name: 'Madagascar',
    neighbors: [26, 24],
  );
  final omsk = Territory(
    id: 28,
    name: 'Omsk',
    neighbors: [29, 34, 32, 37],
  );
  final dudinka = Territory(
    id: 29,
    name: 'Dudinka',
    neighbors: [30, 33, 34, 28],
  );
  final siberia = Territory(id: 30, name: 'Sibéria', neighbors: [31, 33, 29]);
  final vladvostok = Territory(
    id: 31,
    name: 'Vladvostok',
    neighbors: [1, 30, 33, 37, 38],
  );
  final aral = Territory(
    id: 32,
    name: 'Aral',
    neighbors: [28, 37, 35, 36, 18],
  );
  final tchita = Territory(
    id: 33,
    name: 'Tchita',
    neighbors: [34, 37, 31, 30, 28, 29],
  );
  final mongolia = Territory(
    id: 34,
    name: 'Mongólia',
    neighbors: [37, 33, 29, 28],
  );
  final orienteMedio = Territory(
    id: 35,
    name: 'Oriente Médio',
    neighbors: [36, 32, 18, 20, 23],
  );
  final india = Territory(
    id: 36,
    name: 'Índia',
    neighbors: [40, 39, 35, 32, 37],
  );
  final china = Territory(
    id: 37,
    name: 'China',
    neighbors: [39, 36, 38, 32, 28, 34, 33, 31],
  );
  final japao = Territory(
    id: 38,
    name: 'Japão',
    neighbors: [37, 31],
  );
  final vietna = Territory(
    id: 39,
    name: 'Vietnã',
    neighbors: [41, 36, 37],
  );
  final sumatra = Territory(
    id: 40,
    name: 'Sumatra',
    neighbors: [36, 43],
  );
  final borneo = Territory(
    id: 41,
    name: 'Borneo',
    neighbors: [43, 42, 39],
  );
  final novaGuine = Territory(
    id: 42,
    name: 'Nova Guine',
    neighbors: [43, 41],
  );
  final australia = Territory(
    id: 43,
    name: 'Austrália',
    neighbors: [42, 41, 40],
  );
}
