import 'package:flutter/rendering.dart';

class Territory {
  final int id;
  final String name;
  int? userId;
  int amountSoldiers;
  Offset offset;
  List<int> neighbors;
  Territory({
    required this.id,
    required this.name,
    this.userId,
    this.amountSoldiers = 1,
    this.offset = Offset.zero,
    required this.neighbors,
  });
  Map<String, dynamic> get toMap => {
        'id': id,
        'name': name,
        'amountsoldiers': 0,
        'continent_id': 1,
        'offset': offset.toString(),
        'neighbors': neighbors
      };
}
