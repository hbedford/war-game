import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => LoginViewModel(),
        child: Consumer<LoginViewModel>(
          builder: (_, provider, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Logar'),
              AnimatedOpacity(
                opacity: provider.isRegistering ? 1 : 0,
                duration: Duration(seconds: 1),
                child: Container(
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Nome'),
                    enabled: provider.isRegistering,
                    onChanged: provider.onChangedName,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: 400,
                child: TextField(
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: provider.onChangedEmail,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton.filled(
                    child:
                        Text(provider.isRegistering ? 'Registrar' : 'Entrar'),
                    onPressed: provider.isRegistering
                        ? provider.onRegistrar
                        : provider.onTap,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  TextButton(
                      onPressed: provider.changeIsRegistering,
                      child: Text(
                          provider.isRegistering ? 'Logar-se' : 'Cadastrar-se'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}