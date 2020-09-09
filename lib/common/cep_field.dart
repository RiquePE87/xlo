import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo/blocs/cep_bloc.dart';
import 'package:xlo/models/address.dart';

class CepField extends StatefulWidget {
  final InputDecoration decoration;
  final FormFieldSetter<Address> onSaved;

  CepField({this.decoration, this.onSaved});

  @override
  _CepFieldState createState() => _CepFieldState();
}

class _CepFieldState extends State<CepField> {
  InputDecoration get decoration => widget.decoration;
  FormFieldSetter<Address> get onSaved => widget.onSaved;
  CepBloc cepBloc;

  @override
  void initState() {
    super.initState();
    cepBloc = CepBloc();
  }

  @override
  void dispose() {
    cepBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CepBlocState>(
        stream: cepBloc.outCep,
        initialData: CepBlocState(cepFieldState: CepFieldState.INITIALIZING),
        builder: (context, snapshot) {
          if (snapshot.data.cepFieldState == CepFieldState.INITIALIZING) {
            return Container();
          }
          return Column(
            children: [
              TextFormField(
                initialValue: snapshot.data.cep,
                onChanged: cepBloc.onChanged,
                onSaved: (t) {
                  onSaved(snapshot.data.address);
                },
                decoration: decoration,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  CepInputFormatter(),
                ],
                validator: (c) {
                  switch (snapshot.data.cepFieldState) {
                    case CepFieldState.INITIALIZING:
                    case CepFieldState.INCOMPLETE:
                    case CepFieldState.INVALID:
                      return "Campo Obrigatório";
                    case CepFieldState.VALID:
                  }
                  return null;
                },
              ),
              buildInformation(snapshot.data)
            ],
          );
        });
  }

  Widget buildInformation(CepBlocState blocState) {
    switch (blocState.cepFieldState) {
      case CepFieldState.INITIALIZING:
      case CepFieldState.INCOMPLETE:
        return Container();
      case CepFieldState.INVALID:
        return Container(
          height: 50,
          padding: const EdgeInsets.all(8),
          color: Colors.red.withAlpha(100),
          alignment: Alignment.center,
          child: Text(
            "CEP Inválido!",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
          ),
        );
      case CepFieldState.VALID:
        final _address = blocState.address;
        return Container(
          height: 50,
          padding: const EdgeInsets.all(8),
          color: Colors.pink,
          alignment: Alignment.center,
          child: Text(
            "Localização: ${_address.district} - ${_address.city} - ${_address.federativeUnit}",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        );
    }
    return Container();
  }
}
