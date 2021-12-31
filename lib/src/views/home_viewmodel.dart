import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:war/src/models/continents/continent.dart';
import 'package:war/src/models/objective/objective.dart';
import 'package:war/src/models/territory/territory.dart';
import 'package:war/src/models/user/user.dart';
import 'package:war/src/services/data.dart';

Data data = Data();

class HomeViewModel with ChangeNotifier {
  List<Continent> _continents = [
    data.americaDoNorte,
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
      name: 'Hugo',
      objective: Objective(id: 0, name: 'nao sei'),
    ),
    User(
      id: 1,
      name: 'Mayara',
      objective: Objective(id: 0, name: 'nao sei'),
    ),
  ];
  List<User> get users => _users;

  User? _userSelected;
  User? get userSelected => _userSelected;

  Territory? _territorySelected;
  Territory? get territory => _territorySelected;

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
    _userSelected = _users.first;
    notifyListeners();
    print(_continents.first.territories.last.userId);
  }

  addUserOnTerritory(Territory territory, int indexUser) {
    _continents[getIndexOfContinent(territory.id)]
        .territories
        .firstWhere((item) => item.id == territory.id)
        .userId = _users[indexUser].id;
    _continents[getIndexOfContinent(territory.id)]
        .territories
        .firstWhere((item) => item.id == territory.id)
        .amountSoldiers = 3;
    notifyListeners();
  }

  getIndexOfContinent(int id) {
    for (Continent continent in _continents) {
      if (continent.territories.any((element) => element.id == id))
        return _continents.indexOf(continent);
    }
  }

  attack(Territory territory, User user) {
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
    int amountAtack = _territorySelected!.amountSoldiers > 3
        ? 3
        : _territorySelected!.amountSoldiers - 1;
    int amountDefense =
        territory.amountSoldiers > 2 ? 3 : territory.amountSoldiers;

    List<int> attackSorted = getRandomValues(amountAtack);
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

  getRandomValues(int amount) {
    List<int> list = [];
    for (int i = 0; i < amount; i++) {
      list.add(1 + Random().nextInt(5));
    }

    list.sort((a, b) => b.compareTo(a));
    return list;
  }
}
