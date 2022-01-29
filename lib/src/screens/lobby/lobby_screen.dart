import 'package:flutter/material.dart';
import 'package:war/src/views/lobby/lobby_view.dart';

class LobbyScreen extends StatelessWidget {
  const LobbyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: LobbyView(),
        ),
      ),
    );
  }
}
