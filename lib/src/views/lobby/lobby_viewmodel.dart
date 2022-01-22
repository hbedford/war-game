import 'package:flutter/cupertino.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:war/main.dart';
import 'package:war/src/models/server/server.dart';
import 'package:war/src/models/user/user.dart';
import 'package:war/src/services/war_api.dart';

class LobbyViewModel with ChangeNotifier {
  WARAPI api = WARAPI();

  Server? _server;
  Server? get server => _server;

  List<Server> _servers = [];
  List<Server> get servers => _servers;
  User? _user;
  User? get user => _user;
  List<User?> _users = List.filled(5, null);
  List<User?> get users => _users;

  updateUser(User? value) {
    changeUser(value);
  }

  changeUser(User? value) {
    _user = value;
    notifyListeners();
  }

  loadServer() async {
    Snapshot snapshot = await api.listenServer();
    snapshot.listen((result) {
      _servers = result['data']['server']
          .map<Server>((item) => Server.fromJson(item))
          .toList();
      notifyListeners();
    });
  }

  openServer() async {
    Map<String, dynamic> result = await api.openServer(_user!);
    print(result);
    _server =
        Server.fromJson(result['data']['insert_server']['returning'].first);
    _users[0] = _user;
    notifyListeners();
  }

  getOutServer() {
    _server = null;
    _users = List.filled(5, null);
    notifyListeners();
  }

  start() async {
    Map<String, dynamic> result = await api.start(_user!, _server!);
    Navigator.pushNamed(navigationApp.currentContext!, '/home');
  }
}
