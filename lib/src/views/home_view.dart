import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:war/src/views/home_viewmodel.dart';
import 'package:war/src/views/lobby/lobby_viewmodel.dart';
import 'package:war/src/widgets/territory_item_widget.dart';
import 'package:war/src/widgets/user_info_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  getList(BuildContext context, bool isHeight, double position) =>
      (isHeight
          ? MediaQuery.of(context).size.height
          : MediaQuery.of(context).size.width) -
      (position * 3);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<LobbyViewModel, HomeViewModel>(
      create: (_) => HomeViewModel()..start(),
      update: (_, lobbyViewModel, homeViewModel) => homeViewModel!..start(),
      child: Consumer<HomeViewModel>(
        builder: (_, provider, child) => Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        'Usuario selecionado',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        provider.userSelected!.name,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: provider.users
                        .map<Widget>((user) => UserInfoWidget(
                              user: user,
                              amountSoldiers: provider.amountTerritoriesPerUser[
                                  provider.users.indexOf(user)],
                            ))
                        .toList(),
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width *
                            (provider.progressTimer / 100),
                        height: 10,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              fit: StackFit.expand,
              children: provider.territories
                  .map<Widget>((territory) => TerritoryItemWidget(
                        onTap: () => provider.attack(
                            territory,
                            provider.users.firstWhere(
                                (user) => user.id == territory.userId)),
                        territory: territory,
                        user: provider.users
                            .firstWhere((user) => user.id == territory.userId),
                      ))
                  .toList(),
            ),
            GestureDetector(
              onTapDown: (details) {
                print(getList(context, false, details.localPosition.dx));
                print(getList(context, true, details.globalPosition.dy));
              },
              child: Container(
                color: Colors.transparent,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
