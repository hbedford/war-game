import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:war/src/views/lobby/lobby_viewmodel.dart';
import 'package:war/src/views/lobby/widgets/server_listtile_widget.dart';

class LobbyServersView extends StatelessWidget {
  const LobbyServersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LobbyViewModel>(
      builder: (_, provider, __) => Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Servidores criados'),
                  TextButton(
                    onPressed: provider.deslogar,
                    child: Text('Deslogar'),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
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
                                itemBuilder: (context, int index) => InkWell(
                                  onTap: () => provider
                                      .connectToServer(provider.servers[index]),
                                  child: ServerListTileWidget(
                                    index: index,
                                    server: provider.servers[index],
                                    amountUsers:
                                        provider.servers[index].amountUsers,
                                  ),
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
          provider.server != null && provider.server!.isLoading
              ? Positioned.fill(
                  child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ))
              : SizedBox()
        ],
      ),
    );
  }
}
