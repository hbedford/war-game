import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:war/src/views/home_viewmodel.dart';
import 'package:war/src/widgets/territory_item_widget.dart';
import 'package:war/src/widgets/user_info_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel()..start(),
      child: Consumer<HomeViewModel>(
          builder: (_, provider, child) => Stack(
                children: [
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: provider.users
                            .map<Widget>((user) => UserInfoWidget(
                                  user: user,
                                  amountSoldiers:
                                      provider.amountTerritoriesPerUser[
                                          provider.users.indexOf(user)],
                                ))
                            .toList(),
                      )),
                  Stack(
                    fit: StackFit.expand,
                    children: provider.territories
                        .map<Widget>((territory) => TerritoryItemWidget(
                              onTap: () => provider.attack(
                                  territory,
                                  provider.users.firstWhere(
                                      (user) => user.id == territory.userId)),
                              territory: territory,
                              user: provider.users.firstWhere(
                                  (user) => user.id == territory.userId),
                            ))
                        .toList(),
                  ),
                ],
              )),
    );
  }
}
