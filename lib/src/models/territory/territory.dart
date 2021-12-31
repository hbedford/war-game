import 'package:flutter/rendering.dart';

class Territory {
  final int id;
  final String name;
  int? userId;
  int amountSoldiers;
  Offset offset;
  Territory({
    required this.id,
    required this.name,
    this.userId,
    this.amountSoldiers = 1,
    this.offset = Offset.zero,
  });
}
