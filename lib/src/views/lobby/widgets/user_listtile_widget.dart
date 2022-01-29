import 'package:flutter/material.dart';
import 'package:war/src/models/user/user.dart';

class UserListTileWidget extends StatelessWidget {
  final int index;
  final User? user;

  const UserListTileWidget({
    Key? key,
    required this.index,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: Row(children: [
        Text('${index + 1}'),
        Text('${user?.name ?? 'Vaga disponivel'}'),
      ]),
    );
  }
}
