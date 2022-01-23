import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:war/src/models/failure/failure.dart';
import 'package:war/src/models/server/server.dart';
import 'package:war/src/services/resultlr.dart';
import 'package:war/src/views/lobby/lobby_viewmodel.dart';
import 'package:war/src/views/login/login_viewmodel.dart';
import 'package:war/src/views/server/server_viewmodel.dart';
import 'package:war/src/widgets/snackbar_error.dart';

import 'widgets/server_listtile_widget.dart';
import 'widgets/user_listtile_widget.dart';

class LobbyView extends StatelessWidget {
  const LobbyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<LoginViewModel, LobbyViewModel>(
      create: (_) => LobbyViewModel()..loadServer(),
      update: (_, loginViewModel, lobbyViewModel) =>
          lobbyViewModel!..updateUser(loginViewModel.user),
      child: Consumer<LobbyViewModel>(
        builder: (_, provider, child) => Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
          child: provider.server != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: provider.getOutServer,
                          child: Icon(Icons.arrow_back_ios),
                        ),
                        Text('Aguardando os jogadores confirmarem '),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: ListView.builder(
                            itemCount: provider.users.length,
                            itemBuilder: (context, int index) =>
                                UserListTileWidget(
                              index: index,
                              user: provider.users[index],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<ServerViewModel>(
                          builder: (_, serverProvider, child) =>
                              CupertinoButton.filled(
                            child: Text('Iniciar'),
                            onPressed: () async {
                              ResultLR<Failure, Server> result =
                                  await provider.startGame();
                              if (result.isRight()) {
                                serverProvider.start();
                                serverProvider
                                    .updateServer((result as Right).value);
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/server', (route) => false);
                                return;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackbarError(
                                      text: ((result as Left).value as Failure)
                                          .error));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Servidores criados'),
                    Row(
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: provider.isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : provider.servers.isEmpty
                                  ? Center(
                                      child: Text('Nenhum servidor encontrado'),
                                    )
                                  : ListView.builder(
                                      itemCount: provider.servers.length,
                                      itemBuilder: (context, int index) =>
                                          ServerListTileWidget(
                                        index: index,
                                        server: provider.servers[index],
                                      ),
                                    ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoButton.filled(
                          child: Text('Criar servidor'),
                          onPressed: provider.openServer,
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
