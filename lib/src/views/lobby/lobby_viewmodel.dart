import 'package:flutter/cupertino.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:war/src/models/server/server.dart';
import 'package:war/src/models/user/user.dart';
import 'package:war/src/services/war_api.dart';

class LobbyViewModel with ChangeNotifier {
  WARAPI api = WARAPI();
  Server? _server;
  Server? get server => _server;
  User? _user;
  User? get user=>_user;

  loadServer() async {
    Snapshot snapshot = await api.listenServer();
    snapshot.listen((event) {
      event.first
      if(_user!=null && _user!.id == event)
    });
  }
}
