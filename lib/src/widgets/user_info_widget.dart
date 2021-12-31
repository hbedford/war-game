import 'package:flutter/material.dart';
import 'package:war/src/models/user/user.dart';

class UserInfoWidget extends StatelessWidget {
  final User user;
  final int amountSoldiers;
  const UserInfoWidget({
    Key? key,
    required this.user,
    required this.amountSoldiers,
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
          Text(
            amountSoldiers.toString(),
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
