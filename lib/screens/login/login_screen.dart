import 'package:flutter/material.dart';
import 'package:xlo/blocs/login/field_state.dart';
import 'package:xlo/blocs/login/login_bloc.dart';
import 'package:xlo/screens/login/widgets/facebook_button.dart';
import 'package:xlo/screens/login/widgets/login_button.dart';
import 'package:xlo/screens/login/widgets/or_divider.dart';
import 'package:xlo/screens/signup/signup_screen.dart';

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
              FacebookButton(_loginBloc),
              OrDivider(),
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
                  style:
                      TextStyle(fontSize: 16, color: Colors.grey[800], fontWeight: FontWeight.w700),
                ),
              ),
              StreamBuilder<FieldState>(
                stream: _loginBloc.outEmail,
                initialData: FieldState(),
                builder: (context, snapshot) {
                  return TextField(
                    onChanged: _loginBloc.changeEmail,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        errorText: snapshot.data.error,
                        enabled: snapshot.data.enabled),
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
                            fontSize: 16, color: Colors.grey[800], fontWeight: FontWeight.w700),
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
                stream: _loginBloc.outPassword,
                initialData: FieldState(),
                builder: (context, snapshot) {
                  return TextField(
                    onChanged: _loginBloc.changePassword,
                    obscureText: true,
                    autocorrect: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        errorText: snapshot.data.error,
                        enabled: snapshot.data.enabled),
                  );
                },
              ),
              LoginButton(_loginBloc),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Não tem conta? ", style: TextStyle(fontSize: 16)),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
                      },
                      child: Text(
                        "Cadastre-se",
                        style: TextStyle(
                            decoration: TextDecoration.underline, color: Colors.blue, fontSize: 16),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
