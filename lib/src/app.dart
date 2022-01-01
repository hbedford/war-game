import 'package:flutter/material.dart';
import 'package:war/src/views/lobby/lobby_view.dart';
import 'package:war/src/views/login/login_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginView(),
    );
  }
}
