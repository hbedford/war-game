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
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel()..checkLogin(),
      child: Consumer<LoginViewModel>(
        builder: (_, provider, child) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: provider.isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      provider.isRegistering ? 'Registrar Email' : 'Logar',
                      style: TextStyle(color: Colors.white),
                    ),
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
                        controller: provider.emailController,
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
                          child: Text(
                              provider.isRegistering ? 'Registrar' : 'Entrar'),
                          onPressed: provider.isRegistering
                              ? provider.onRegistrar
                              : provider.onLogin,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        TextButton(
                          onPressed: provider.changeIsRegistering,
                          child: Text(
                            provider.isRegistering
                                ? 'Logar-se'
                                : 'Cadastrar-se',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
