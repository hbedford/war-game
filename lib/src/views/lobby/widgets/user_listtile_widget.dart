import 'package:flutter/material.dart';
import 'package:war/src/models/user/user.dart';

class UserListTileWidget extends StatelessWidget {
  final int index;
  final User? user;

  const UserListTileWidget({
    Key? key,
    required this.index,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${index + 1}'),
      title: Text('${user != null ? user!.name : 'vaga disponivel'}'),
    );
  }
}
