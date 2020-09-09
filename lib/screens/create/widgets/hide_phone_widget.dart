import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HidePhoneWidget extends FormField<bool>{

  HidePhoneWidget({FormFieldSetter onSaved, bool initialValue}) : super(
    initialValue: initialValue,
    onSaved: onSaved,
    builder: (state){
      return Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            Checkbox(value: state.value, onChanged: (s){
              state.didChange(s);
            }),
            const Text( "Ocultar meu número de telefone neste anúncio")
          ],
        ),
      );
    }
  );

}
