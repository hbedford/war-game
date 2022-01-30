import 'package:flutter/rendering.dart';

class Territory {
  final int id;
  final String name;
  int? userId;
  int amountSoldiers;
  Offset offset;
  List<int> neighbors;
  int continentId;
  Territory({
    required this.id,
    required this.name,
    this.userId,
    this.amountSoldiers = 1,
    this.offset = Offset.zero,
    required this.neighbors,
    required this.continentId,
  });
  factory Territory.fromJson(Map<String, dynamic> map) => Territory(
        id: map['id'],
        name: map['name'],
        neighbors: map['neighbors'].map<int>((e) => e).toList(),
        continentId: map['continent_id'],
      );
  Map<String, dynamic> get toMap => {
        /* 'id': id, */
        'name': name,
        'amountsoldiers': 0,
        'continent_id': continentId,
        'offset': offset.toString(),
        'neighbors': neighbors.toString(),
      };
}
