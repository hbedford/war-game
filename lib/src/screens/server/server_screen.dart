import 'package:flutter/material.dart';
import 'package:war/src/views/server/server_view.dart';

class ServerScreen extends StatelessWidget {
  const ServerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background.jpg',
            fit: BoxFit.fill,
          ),
          Positioned.fill(
            child: ServerView(),
          ),
        ],
      ),
    );
  }
}
