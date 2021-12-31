import 'package:flutter/material.dart';
import 'package:war/src/models/territory/territory.dart';
import 'package:war/src/models/user/user.dart';

class TerritoryItemWidget extends StatelessWidget {
  final Territory territory;
  final User user;
  final Function() onTap;
  const TerritoryItemWidget({
    Key? key,
    required this.territory,
    required this.user,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return territory.offset == Offset.zero
        ? SizedBox()
        : Positioned(
            top: MediaQuery.of(context).size.height *
                (territory.offset.dy / 100),
            left:
                MediaQuery.of(context).size.width * (territory.offset.dx / 100),
            child: InkWell(
              onTap: onTap,
              child: Column(
                children: [
                  Text(
                    territory.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    user.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    territory.amountSoldiers.toString(),
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          );
  }
}
