import 'dart:async';

import 'package:xlo/blocs/login/field_state.dart';

class LoginValidator {
  final StreamTransformer<String, FieldState> emailValidator =
      StreamTransformer<String, FieldState>.fromHandlers(handleData: (email, sink) {
    const Pattern pattern =
        r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";
    final RegExp regExp = RegExp(pattern);
    if (email.isEmpty) {
      sink.add(FieldState(error: "Campo Obrigatório"));
    } else if (!regExp.hasMatch(email)) {
      sink.add(FieldState(error: "E-mail inválido"));
    } else {
      sink.add(FieldState());
    }
  });

  final StreamTransformer<String, FieldState> passwordValidator =
      StreamTransformer<String, FieldState>.fromHandlers(handleData: (password, sink) {
    if (password.isEmpty) {
      sink.add(FieldState(error: "Campo Obrigatório"));
    } else {
      sink.add(FieldState());
    }
  });
}
