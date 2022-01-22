import 'package:flutter/material.dart';
import 'package:war/src/views/home_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/background.jpg',
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: HomeView(),
          ),
        ],
      ),
    );
  }
}
