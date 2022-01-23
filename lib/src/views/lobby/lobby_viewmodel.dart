import 'package:flutter/cupertino.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:war/src/models/failure/failure.dart';
import 'package:war/src/models/server/server.dart';
import 'package:war/src/models/user/user.dart';
import 'package:war/src/services/resultlr.dart';
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

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _disposed = false;

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

  loadServer() async {
    changeIsLoading(true);
    Snapshot snapshot = await api.listenServer();
    snapshot.listen((result) {
      _servers = result['data']['server']
          .map<Server>((item) => Server.fromJson(item))
          .toList();
      notifyListeners();
      changeIsLoading(false);
    });
  }

  openServer() async {
    Map<String, dynamic> result = await api.openServer(_user!);
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

  Future<ResultLR<Failure, Server>> startGame() async {
    changeIsLoading(true);
    ResultLR<Failure, Server> result =
        await api.startGame(_server!.id, _user!.id);
    if (result.isLeft()) changeIsLoading(false);
    return result;
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
