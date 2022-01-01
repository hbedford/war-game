import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:war/src/views/lobby/lobby_viewmodel.dart';

class LobbyView extends StatelessWidget {
  const LobbyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => LobbyViewModel()..loadServer(),
        child: Consumer<LobbyViewModel>(
          builder: (_, provider, child) => Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
