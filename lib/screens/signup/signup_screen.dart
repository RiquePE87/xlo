import 'package:flutter/material.dart';
import 'package:xlo/screens/signup/widgets/field_title.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Cadastrar"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
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
            ),
            const FieldTitle(
              title: "Senha",
              subtitle: "Use números, letras e caracteres especiais.",
            )
          ],
        ),
      ),
    );
  }
}
