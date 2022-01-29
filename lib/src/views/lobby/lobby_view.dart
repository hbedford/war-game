import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:war/src/models/server/server.dart';
import 'package:war/src/views/lobby/lobby_viewmodel.dart';

import 'lobby_servers_view.dart';
import 'creation_server_view.dart';

class LobbyView extends StatelessWidget {
  const LobbyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LobbyViewModel>(
      create: (_) => LobbyViewModel()..loadServers(),
      child: Selector<LobbyViewModel, Server?>(
        selector: (_, provider) => provider.server,
        builder: (_, server, child) =>
            server != null ? CreationServerView() : LobbyServersView(),
      ),
    );
  }
}
