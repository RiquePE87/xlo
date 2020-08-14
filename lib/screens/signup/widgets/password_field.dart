import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {

  final FormFieldSetter onSaved;

  PasswordField({this.onSaved});
  @override
  Widget build(BuildContext context) {
    Widget buildBar(int n, String pass) {
      final int level = _calcScore(pass);
      return Expanded(
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
            border: n > level ? Border.all(color: Colors.grey) : null,
            borderRadius: BorderRadius.circular(5),
            color: n <= level ? _getColor(level) : Colors.transparent),
      ));
    }

    return FormField<String>(
      onSaved: onSaved,
        initialValue: "",
        validator: (text){
          if (text.isEmpty || _calcScore(text) > 2){
            return "Senha inválida";
          }else{
            return null;
          }
        },
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                obscureText: true,
                onChanged: state.didChange,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              if (state.value.isNotEmpty)
              Container(
                height: 8,
                margin: const EdgeInsets.only(top: 6),
                child: Row(
                  children: [
                    buildBar(0, state.value),
                    buildBar(1, state.value),
                    buildBar(2, state.value),
                    buildBar(3, state.value),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 10),
                child: state.value.isNotEmpty || state.hasError ? Text(
                  state.value.isNotEmpty ? _getText(_calcScore(state.value)) : state.errorText,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 12,
                    color: _getColor(_calcScore(state.value))
                  ),
                ) : Container(),
              ),
            ],
          );
        });
  }

  int _calcScore(String text) {
    int score = 0;

    if (text.length > 8) {
      score++;
    }
    if (text.contains(RegExp(r'[0-9]'))) {
      score++;
    }
    if (text.contains(RegExp(r'[A-Z]'))) {
      score++;
    }
    return score;
  }

  Color _getColor(int level) {
    switch (level) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.greenAccent;
      case 3:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  String _getText(int level) {
    switch (level) {
      case 0:
        return "Senha muito fraca";
      case 1:
        return "Senha razoavelmente fraca";
      case 2:
        return "Senha razoavelmente forte";
      case 3:
        return "Senha forte";
      default:
        return "";
    }
  }
}
