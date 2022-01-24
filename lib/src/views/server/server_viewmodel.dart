import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:war/main.dart';
import 'package:war/src/models/continents/continent.dart';
import 'package:war/src/models/objective/objective.dart';
import 'package:war/src/models/server/server.dart';
import 'package:war/src/models/territory/territory.dart';
import 'package:war/src/models/user/user.dart';
import 'package:war/src/services/data.dart';
import 'package:war/src/services/war_api.dart';
import 'package:war/src/widgets/snackbar_error.dart';

Data data = Data();

int _durationDefault = Duration(minutes: 4).inMilliseconds;

class ServerViewModel with ChangeNotifier {
  List<Continent> _continents = [
    data.americaDoNorte,
    data.americaDoSul,
    data.europa,
    data.africa,
    data.asia,
    data.oceania
  ];
  List<Continent> get continents => _continents;

  int get territoriesLength {
    int value = 0;
    _continents.forEach((element) {
      value += element.length;
    });
    return value;
  }

  List<int> get amountSoldiersPerUser {
    List<int> list = List.filled(_users.length, 0);
    for (int i = 0; i < _users.length; i++) {
      int amount = 0;
      for (Territory territory in territories) {
        if (territory.userId == users[i].id) amount += territory.amountSoldiers;
      }

      list[i] = amount;
    }
    return list;
  }

  List<int> get amountTerritoriesPerUser {
    List<int> list = List.filled(_users.length, 0);
    for (int i = 0; i < _users.length; i++) {
      int amount = 0;
      for (Territory territory in territories) {
        if (territory.userId == users[i].id) amount++;
      }

      list[i] = amount;
    }
    return list;
  }

  List<Territory> get territoriesWithoutUser {
    List<Territory> list = [];
    _continents.forEach((continent) {
      list.addAll(
          continent.territories.where((territory) => territory.userId == null));
    });
    return list;
  }

  List<Territory> get territories {
    List<Territory> list = [];
    _continents.forEach((continent) => list.addAll(continent.territories));
    return list;
  }

  List<User> _users = [
    User(
        id: 0,
        email: '',
        name: 'Hugo',
        objective: Objective(id: 0, name: 'nao sei'),
        soldiers: 0),
    User(
        id: 1,
        email: '',
        name: 'Mayara',
        objective: Objective(id: 0, name: 'nao sei'),
        soldiers: 0),
  ];

  List<User> get users => _users;

  User? _userSelected;
  User? get userSelected => _userSelected;

  User? _me;
  User? get me => _me;

  Territory? _territorySelected;
  Territory? get territory => _territorySelected;

  int _currentTime = _durationDefault;
  int get currentTime => _currentTime;

  int get progressTimer => ((_currentTime * 100) / _durationDefault).round();

  bool _disposed = false;

  start() {
    int indexUser = 0;
    while (territoriesWithoutUser.length > 0) {
      Territory territory = (territoriesWithoutUser..shuffle()).first;
      addUserOnTerritory(territory, indexUser);
      if (indexUser + 1 == _users.length)
        indexUser = 0;
      else
        indexUser++;
    }
    changeSelectUser(_users.first);
    changeMe(_users.first);
    timer();
    /* addTerritories(); */
  }

  updateServer(Server? value) {}

  changeMe(User? value) {
    _me = value;
    notifyListeners();
  }

  addUserOnTerritory(Territory territory, int indexUser) {
    _continents[getIndexOfContinent(territory.id)]
        .territories
        .firstWhere((item) => item.id == territory.id)
        .userId = _users[indexUser].id;
    _continents[getIndexOfContinent(territory.id)]
        .territories
        .firstWhere((item) => item.id == territory.id)
        .amountSoldiers = 100;
    notifyListeners();
  }

  getIndexOfContinent(int id) {
    for (Continent continent in _continents) {
      if (continent.territories.any((element) => element.id == id))
        return _continents.indexOf(continent);
    }
  }

  attack(Territory territory, int userId) {
    if (_userSelected!.id != _me!.id) {
      ScaffoldMessenger.of(navigationApp.currentContext!).showSnackBar(
        SnackbarError(text: 'Não esta na sua vez'),
      );
      return;
    }

    if (_territorySelected == null && territory.userId != _userSelected!.id)
      return;

    if ((_territorySelected == null && territory.userId == _userSelected!.id) ||
        _territorySelected!.userId == userId) {
      changeSelectTerritory(territory);
      return;
    }

    if (_territorySelected!.amountSoldiers == 1) {
      changeSelectTerritory(null);
      return;
    }
    if (!_territorySelected!.neighbors.contains(territory.id)) {
      ScaffoldMessenger.of(navigationApp.currentContext!).showSnackBar(
          SnackbarError(text: 'Este territorio não é um vizinho atacavel'));
      return;
    }

    realizeAttack(territory);
  }

  realizeAttack(Territory territory) {
    //verifica quantos podem atacar, ate no maximo 3, mas mantendo 1 como dono do territorio
    int amountAtack = _territorySelected!.amountSoldiers > 3
        ? 3
        : _territorySelected!.amountSoldiers - 1;

    //verifica quantos podem defender, ate no maximo 3
    int amountDefense =
        territory.amountSoldiers > 2 ? 3 : territory.amountSoldiers;

    //randomiza a lista de valores sorteados e em ordem decrescente  em relaçao ao numero de soldados de cima
    List<int> attackSorted = getRandomValues(amountAtack);
    //randomiza a lista de valores sorteados e em ordem decrescente em relaçao ao numero de soldados de cima
    List<int> defenseSorted = getRandomValues(amountDefense);

    int position = 0;
    int lostDefense = 0;
    int lostAttack = 0;
    for (int value in attackSorted) {
      if (position <= defenseSorted.length - 1) {
        if (value > defenseSorted[position])
          lostDefense++;
        else
          lostAttack++;

        position++;
      }
    }
    print(lostAttack);
    print(lostDefense);
    if (lostDefense >= territory.amountSoldiers)
      changeTerritoryUser(territory.id);
    changeAmountSoldiers(lostDefense, territory);
    changeAmountSoldiers(lostAttack, _territorySelected!);
  }

  changeTerritoryUser(int territoryId) {
    Territory t = _continents
        .firstWhere(
            (element) => element.territories.any((t) => t.id == territoryId))
        .territories
        .firstWhere((element) => element.id == territoryId);
    t.userId = _userSelected!.id;
    t.amountSoldiers = 1;
    _territorySelected!.amountSoldiers--;
    notifyListeners();
  }

  changeAmountSoldiers(int amount, Territory territory) {
    _continents[getIndexOfContinent(territory.id)]
        .territories
        .firstWhere((element) => territory.id == element.id)
        .amountSoldiers -= amount;
    notifyListeners();
  }

  changeSelectUser(User? value) {
    if (value != null) value.soldiers = 4;
    _userSelected = value;
    notifyListeners();
  }

  changeSelectTerritory(Territory? value) {
    _territorySelected = value;
    notifyListeners();
  }

//quantidade de numeros aleatorios que queremos ter
  getRandomValues(int amount) {
    //Lista começa vazia
    List<int> list = [];
    //um loop q começa do zero e enquanto i for menor q quantidade de numeros
    for (int i = 0; i < amount; i++) {
      //adiciona um item randomizado a lista, mas esta nextInt, pois o é de 0 a 5, e o 1+ é para garantir q seja de 1 a 6 no final, entao incrementando no 0 a 5 fica 1 a 6
      list.add(1 + Random().nextInt(5));
    }
    //ordena decrescentemente
    list.sort((a, b) => b.compareTo(a));

    //devolve a lista la para onde a funçao getRandomValues foi chamada
    return list;
  }

  timer() {
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      if (_currentTime > 0) {
        _currentTime--;
        notifyListeners();
      } else {
        getNextUser();
        _currentTime = _durationDefault;
        notifyListeners();
      }
    });
  }

  getNextUser() {
    int index = _users.indexWhere((user) => user.id == _userSelected!.id);
    if (index == _users.length - 1)
      changeSelectUser(_users.first);
    else
      changeSelectUser(_users[index + 1]);
  }

  addTerritories() async {
    print('ola');
    WARAPI api = WARAPI();
    var result = await api.addContinents(
        territories.map<Map<String, dynamic>>((e) => e.toMap).toList());
    print(result);
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
