import 'package:flutter/material.dart';
import 'package:xlo/blocs/login/login_bloc.dart';
import 'package:xlo/blocs/login/login_bloc_state.dart';

class FacebookButton extends StatelessWidget {

  final LoginBloc loginBloc;

  FacebookButton(this.loginBloc);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 50,
      child: StreamBuilder<LoginBlocState>(
        builder: (context, snapshot){
          return RaisedButton(
            color: Colors.blue[900],
            onPressed: (){},
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
            ),
            child: Text("Entrar com o Facebook",
              style: TextStyle(
                color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),),
          );
        },
      ),
    );
  }
}
