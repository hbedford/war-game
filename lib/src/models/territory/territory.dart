import 'package:flutter/rendering.dart';

class Territory {
  final int id;
  int? serverId;
  final String name;
  int? userId;
  int amountSoldiers;
  Offset offset;
  List<int> neighbors;
  int continentId;
  Territory({
    required this.id,
    this.serverId,
    required this.name,
    this.userId,
    this.amountSoldiers = 1,
    this.offset = Offset.zero,
    required this.neighbors,
    required this.continentId,
  });
  factory Territory.fromJson(Map<String, dynamic> map) {
    List<String> offsetValue =
        map['offset'].replaceFirst('(', "").replaceFirst(')', "").split(',');
    List<int> neighborsValue =
        map['neighbors'].split(',').map<int>((i) => int.parse(i)).toList();
    return Territory(
      id: map['id'],
      serverId: map['server_id'],
      userId: map['user_id'],
      name: map['name'],
      offset: Offset(
          double.parse(offsetValue.first), double.parse(offsetValue.last)),
      neighbors: neighborsValue,
      continentId: map['continent_id'],
    );
  }
  Map<String, dynamic> get toMap => {
        'id': id,
        'server_id': serverId,
        'user_id': userId,
        'name': name,
        'amountsoldiers': amountSoldiers,
        'continent_id': continentId,
        'offset': "${offset.dx},${offset.dy}",
        'neighbors':
            neighbors.toString().replaceFirst('[', '').replaceFirst(']', ''),
      };
}
