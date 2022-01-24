import 'package:flutter/material.dart';
import 'package:war/src/models/user/user.dart';

class UserInfoWidget extends StatelessWidget {
  final User user;
  final int amountSoldiers;
  final int amountTerritories;
  const UserInfoWidget({
    Key? key,
    required this.user,
    required this.amountSoldiers,
    required this.amountTerritories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            user.name,
            style: TextStyle(color: Colors.white),
          ),
          Row(
            children: [
              Text(
                "Soldados ${amountSoldiers.toString()}",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 10),
              Text(
                "Territorios ${amountTerritories.toString()}",
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
