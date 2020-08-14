import 'package:flutter/material.dart';
import 'package:xlo/blocs/login/button_state.dart';
import 'package:xlo/blocs/login/login_bloc.dart';

class LoginButton extends StatelessWidget {
  final LoginBloc loginBloc;

  LoginButton(this.loginBloc);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      height: 50,
      child: StreamBuilder<ButtonState>(
        initialData: ButtonState(loading: false, enabled: false),
        stream: loginBloc.outButtonState,
        builder: (context, snapshot) {
          return RaisedButton(
            color: Colors.pink,
            disabledColor: Colors.pink.withAlpha(150),
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            onPressed: snapshot.data.enabled
                ? () async {
                    final bool success = await loginBloc.loginWithEmail();
                    if (success) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
            child: snapshot.data.loading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(
                    "Entrar",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
          );
        },
      ),
    );
  }
}
