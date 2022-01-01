import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:war/src/services/war_api.dart';

class LoginViewModel with ChangeNotifier {
  WARAPI api = WARAPI();

  String _email = '';
  String get email => _email;

  String _name = '';
  String get name => _name;

  bool get isValidEmail => _email.contains('@');
  bool get isValidName => _name.length > 3;

  bool _isRegistering = false;
  bool get isRegistering => _isRegistering;

  onChangedEmail(String value) {
    _email = value;
    notifyListeners();
  }

  onChangedName(String value) {
    _name = value;
    notifyListeners();
  }

  onTap() async {
    if (isValidEmail) {
      var result = await api.getLogin(_email);
      if (result['data']['users'].isEmpty)
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  onRegistrar() async {
    if (isValidEmail && isValidName) {
      var result = await api.registerLogin(_email, _name);
      print(result);
    }
  }

  changeIsRegistering() {
    _isRegistering = !_isRegistering;
    notifyListeners();
  }
}
