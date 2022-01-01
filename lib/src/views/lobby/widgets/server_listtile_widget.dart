import 'package:flutter/material.dart';
import 'package:war/src/models/server/server.dart';

class ServerListTileWidget extends StatelessWidget {
  final int index;
  final Server server;

  const ServerListTileWidget({
    Key? key,
    required this.index,
    required this.server,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${index + 1}'),
      title: Text(server.hostUser.name),
    );
  }
}
