import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:war/main.dart';
import 'package:war/src/models/user/user.dart';
import 'package:war/src/services/war_api.dart';
import 'package:war/src/widgets/snackbar_error.dart';

class LoginViewModel with ChangeNotifier {
  WARAPI api = WARAPI();
  GetStorage _getStorage = GetStorage();

  User? _user;
  User? get user => _user;

  String _email = '';
  String get email => _email;

  String _name = '';
  String get name => _name;

  bool get isValidEmail => _email.contains('@');
  bool get isValidName => _name.length > 3;

  bool _isRegistering = false;
  bool get isRegistering => _isRegistering;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _disposed = false;
  TextEditingController emailController = TextEditingController();

  checkLogin() async {
    String? getData = _getStorage.read('user');
    print(getData);
    if (getData == null) return null;
    User userLoaded = User.fromJson(jsonDecode(getData));

    onChangedEmail(userLoaded.email);
    await onLogin();
  }

  onChangedEmail(String value) {
    _email = value;
    notifyListeners();
  }

  onChangedName(String value) {
    _name = value;
    notifyListeners();
  }

  changeIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  onLogin() async {
    if (!isValidEmail) {
      ScaffoldMessenger.of(navigationApp.currentContext!)
          .showSnackBar(SnackbarError(text: 'Digite um email valido'));
      return;
    }
    changeIsLoading(true);
    var result = await api.getLogin(_email.toLowerCase());
    List<User> list = result['data']['user']
        .map<User>((item) => User.fromJson(item))
        .toList();
    if (list.isEmpty) {
      ScaffoldMessenger.of(navigationApp.currentContext!).showSnackBar(
          SnackbarError(text: 'Nenhum usuario com esse email encontrado'));

      changeIsLoading(false);
      return;
    }
    changeUser(list.first);

    _getStorage.write('user', jsonEncode(list.first.toMap));
    print(_getStorage.read('user'));
    Navigator.pushNamedAndRemoveUntil(
        navigationApp.currentContext!, '/lobby', (route) => false);
  }

  changeUser(User value) {
    _user = value;
    notifyListeners();
  }

  onRegistrar() async {
    if (!isValidEmail) {
      ScaffoldMessenger.of(navigationApp.currentContext!)
          .showSnackBar(SnackbarError(text: 'Digite um email valido'));
      return;
    }
    if (!isValidName) {
      ScaffoldMessenger.of(navigationApp.currentContext!).showSnackBar(
          SnackbarError(text: 'Digite um nome com pelo menos 3 caracteres'));
      return;
    }
    if (isValidEmail && isValidName) {
      changeIsLoading(true);
      var result = await api.registerLogin(_email, _name);
      List<User> list = result['data']['insert_user']['returning']
          .map((item) => User.fromJson(item))
          .toList();
      if (list.isEmpty) {
        changeIsLoading(false);
        ScaffoldMessenger.of(navigationApp.currentContext!).showSnackBar(
            SnackbarError(
                text: 'Ocorreu algum problema ao cadastrar o usuario'));
        return;
      }
      changeUser(list.first);
      Navigator.pushNamedAndRemoveUntil(
          navigationApp.currentContext!, '/lobby', (route) => false);
    }
  }

  changeIsRegistering() {
    _isRegistering = !_isRegistering;
    notifyListeners();
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
