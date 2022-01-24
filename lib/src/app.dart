import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:war/main.dart';
import 'package:war/src/screens/login/login_screen.dart';
import 'package:war/src/screens/server/server_screen.dart';

import 'screens/lobby/lobby_screen.dart';
import 'views/server/server_viewmodel.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ServerViewModel(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(brightness: Brightness.dark),
        navigatorKey: navigationApp,
        initialRoute: '/login',
        routes: {
          '/login': (_) => LoginScreen(),
          '/lobby': (_) => LobbyScreen(),
          '/server': (_) => ServerScreen(),
        },
      ),
    );
  }
}
