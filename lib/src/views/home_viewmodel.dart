import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:war/src/models/continents/continent.dart';
import 'package:war/src/models/objective/objective.dart';
import 'package:war/src/models/server/server.dart';
import 'package:war/src/models/territory/territory.dart';
import 'package:war/src/models/user/user.dart';
import 'package:war/src/services/data.dart';
import 'package:war/src/services/war_api.dart';

Data data = Data();

class HomeViewModel with ChangeNotifier {
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

  List<int> get amountTerritoriesPerUser {
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
    ),
    User(
      id: 1,
      email: '',
      name: 'Mayara',
      objective: Objective(id: 0, name: 'nao sei'),
    ),
  ];
  List<User> get users => _users;

  User? _userSelected;
  User? get userSelected => _userSelected;

  User? _me;
  User? get me => _me;

  Territory? _territorySelected;
  Territory? get territory => _territorySelected;

  int _currentTime = 18000;
  int get currentTime => _currentTime;
  int get progressTimer => ((_currentTime * 100) / 18000).round();
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
        .amountSoldiers = 1;
    notifyListeners();
  }

  getIndexOfContinent(int id) {
    for (Continent continent in _continents) {
      if (continent.territories.any((element) => element.id == id))
        return _continents.indexOf(continent);
    }
  }

  attack(Territory territory, User user) {
    if (_userSelected!.id != _me!.id) return;

    if (_territorySelected == null && territory.userId != _userSelected!.id)
      return;

    if ((_territorySelected == null && territory.userId == _userSelected!.id) ||
        _territorySelected!.userId == user.id) {
      changeSelectTerritory(territory);
      return;
    }

    if (_territorySelected!.amountSoldiers == 1) {
      changeSelectTerritory(null);
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
      if (value > defenseSorted[position])
        lostDefense++;
      else
        lostAttack++;

      position++;
    }
    print(lostAttack);
    print(lostDefense);
    changeAmountSoldiers(lostDefense, territory);
    changeAmountSoldiers(lostAttack, _territorySelected!);
  }

  changeAmountSoldiers(int amount, Territory territory) {
    _continents[getIndexOfContinent(territory.id)]
        .territories
        .firstWhere((element) => territory.id == element.id)
        .amountSoldiers -= amount;
    notifyListeners();
  }

  changeSelectUser(User? value) {
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
        _currentTime = 18000;
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
}
