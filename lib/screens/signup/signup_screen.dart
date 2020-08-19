import 'package:flutter/material.dart';
import 'package:xlo/blocs/signup_bloc.dart';
import 'package:xlo/screens/signup/widgets/field_title.dart';
import 'package:xlo/screens/signup/widgets/password_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignUpBloc _signUpBloc;

  @override
  void initState() {
    super.initState();
    _signUpBloc = SignUpBloc();
  }

  @override
  void dispose() {
    _signUpBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Cadastrar"),
      ),
      body: Form(
        key: _formKey,
        child: StreamBuilder<SignUpBlocState>(
            stream: _signUpBloc.outState,
            builder: (context, snapshot) {
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: [
                  const FieldTitle(
                    title: "Apelido",
                    subtitle: "Como aparecerá nos seus anúncios.",
                  ),
                  TextFormField(
                    validator: (text) {
                      if (text.length < 6) {
                        return "Apelido muito curto";
                      } else {
                        return null;
                      }
                    },
                    decoration:
                        InputDecoration(border: OutlineInputBorder(), hintText: "Exemplo João S."),
                    onSaved: _signUpBloc.setName,
                    enabled: snapshot.data.state != signUpState.LOADING,
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  const FieldTitle(
                    title: "E-mail",
                    subtitle: "Enviaremos um e-mail de confirmação.",
                  ),
                  TextFormField(
                    validator: (text) {
                      if (text.length < 6 || !text.contains('@')) {
                        return "E-mail inválido";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    onSaved: _signUpBloc.setEmail,
                    //enabled: snapshot.data.state != signUpState.LOADING,
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  const FieldTitle(
                    title: "Senha",
                    subtitle: "Use números, letras e caracteres especiais.",
                  ),
                  PasswordField(
                    enabled: snapshot.data.state != signUpState.LOADING,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 24),
                    height: 50,
                    child: RaisedButton(
                      color: Colors.pink,
                      disabledColor: Colors.pink.withAlpha(150),
                      child: snapshot.data.state == signUpState.LOADING
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              "Cadastre-se",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                      onPressed: snapshot.data.state != signUpState.LOADING ? _signUp : null,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Já tem conta? ",
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 16,
                                color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }

  void _signUp() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _signUpBloc.SignUp();
    }
  }
}
