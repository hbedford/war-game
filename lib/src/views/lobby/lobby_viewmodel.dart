import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:war/main.dart';
import 'package:war/src/models/failure/failure.dart';
import 'package:war/src/models/server/server.dart';
import 'package:war/src/models/user/user.dart';
import 'package:war/src/services/resultlr.dart';
import 'package:war/src/services/war_api.dart';

class LobbyViewModel with ChangeNotifier {
  GetStorage _getStorage = GetStorage();
  WARAPI api = WARAPI();

  Server? _server;
  Server? get server => _server;

  List<Server> _servers = [];
  List<Server> get servers => _servers;

  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _disposed = false;
  int get totalUsers => 5;
  bool get isHost => _server != null && _server!.hostUser.id == _user!.id;

  updateUser(User? value) {
    changeUser(value);
  }

  changeIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  changeUser(User? value) {
    _user = value;
    notifyListeners();
  }

  loadServers() async {
    changeIsLoading(true);
    User user = User.fromJson(jsonDecode(_getStorage.read('user')));
    changeUser(user);
    Snapshot snapshot = await api.listenServer();
    snapshot.listen((result) {
      changeServers(result['data']['server']
          .map<Server>((item) => Server.fromJson(item))
          .toList());

      if (_server != null) {
        changeServer(_servers.firstWhere((s) => s.id == _server!.id));
      }
      changeIsLoading(false);
    });
  }

  deslogar() {
    _getStorage.write('user', null);
    Navigator.pushNamedAndRemoveUntil(
        navigationApp.currentContext!, '/login', (route) => false);
  }

  openServer() async {
    Map<String, dynamic> result = await api.openServer(_user!);
    _server =
        Server.fromJson(result['data']['insert_server']['returning'].first);
    notifyListeners();
  }

  changeServer(Server? value) {
    _server = value;
    notifyListeners();
  }

  changeServers(List<Server> value) {
    _servers = value;
    notifyListeners();
  }

  getOutServer() {
    _server = null;
    notifyListeners();
  }

  Future<ResultLR<Failure, bool>> startGame() async {
    changeIsLoading(true);
    ResultLR<Failure, bool> result = await api.startGame(_server!.id);
    if (result.isLeft()) changeIsLoading(false);
    return result;
  }

  connectToServer(Server value) async {
    ResultLR<Failure, bool> result =
        await api.connectToServer(value.id, _user!.id);
    if (result.isRight()) {
      changeServer(_servers.firstWhere((element) => element.id == value.id));
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
