import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:war/src/models/failure/failure.dart';
import 'package:war/src/services/resultlr.dart';
import 'package:war/src/views/lobby/lobby_viewmodel.dart';
import 'package:war/src/views/lobby/widgets/user_listtile_widget.dart';
import 'package:war/src/views/server/server_viewmodel.dart';
import 'package:war/src/widgets/snackbar_error.dart';

class CreationServerView extends StatelessWidget {
  const CreationServerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LobbyViewModel>(
      builder: (_, provider, __) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              TextButton(
                onPressed: provider.getOutServer,
                child: Icon(Icons.arrow_back_ios),
              ),
              Text('Lobby do server '),
            ],
          ),
          Flexible(
            child: Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Flexible(
                  child: ListView.builder(
                    itemCount: provider.totalUsers,
                    itemBuilder: (context, int index) => UserListTileWidget(
                      index: index,
                      user: provider.users.length < index
                          ? provider.users[index]
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<ServerViewModel>(
                builder: (_, serverProvider, child) => CupertinoButton.filled(
                  child: Text('Iniciar'),
                  onPressed: () async {
                    ResultLR<Failure, bool> result = await provider.startGame();
                    if (result.isRight()) {
                      serverProvider.start();
                      serverProvider.updateServer(provider.server);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/server', (route) => false);
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackbarError(
                        text: ((result as Left).value as Failure).error));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
