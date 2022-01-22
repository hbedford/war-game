import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:war/main.dart';
import 'package:war/src/screens/login/login_screen.dart';
import 'package:war/src/views/home_view.dart';
import 'package:war/src/views/lobby/lobby_view.dart';
import 'package:war/src/views/login/login_view.dart';

import 'screens/home/home_screen.dart';
import 'screens/lobby/lobby_screen.dart';
import 'views/login/login_viewmodel.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: MaterialApp(
        navigatorKey: navigationApp,
        initialRoute: '/login',
        routes: {
          '/login': (_) => LoginScreen(),
          '/lobby': (_) => LobbyScreen(),
          '/home': (_) => HomeScreen(),
        },
      ),
    );
  }
}
