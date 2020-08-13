import 'package:flutter/material.dart';
import 'package:xlo/blocs/login/field_state.dart';
import 'package:xlo/blocs/login/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final LoginBloc _loginBloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Entrar"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 11),
                child: Text(
                  "Acessar com E-mail",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[900]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, bottom: 4),
                child: Text(
                  "E-mail",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w700),
                ),
              ),
              StreamBuilder<FieldState>(
                builder: (context, snapshot) {
                  return TextField(
                    onChanged: _loginBloc.changeEmail,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      errorText: snapshot.data.errorText,
                      enabled: snapshot.data.enabled
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 26, left: 3, bottom: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Senha",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        "Esqueceu a senha?",
                        style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
              StreamBuilder<FieldState>(
                builder: (context, snapshot) {
                  return TextField(
                    onChanged: _loginBloc.changePassword,
                    obscureText: true,
                    autocorrect: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        errorText: snapshot.data.errorText,
                        enabled: snapshot.data.enabled),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
