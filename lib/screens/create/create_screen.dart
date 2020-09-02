import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo/api/api_postalcode.dart';
import 'package:xlo/common/cep_field.dart';
import 'package:xlo/common/custom_drawer/custom_drawer.dart';
import 'package:xlo/screens/create/widgets/images_field.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inserir Anúncio"),
        elevation: 0,
      ),
      drawer: CustomDrawer(),
      body: Form(
          key: _formKey,
          child: ListView(
            children: [
              ImagesField(
                onSaved: (images) {
                  print(images);
                },
                initialValue: [],
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Título *",
                    contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.w800, color: Colors.grey, fontSize: 18)),
                validator: (text) {
                  if (text.isEmpty) return "Campo obrigatório";
                  return null;
                },
                onSaved: (t) {},
              ),
              TextFormField(
                maxLines: null,
                decoration: InputDecoration(
                    labelText: "Descrição *",
                    contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.w800, color: Colors.grey, fontSize: 18)),
                validator: (text) {
                  if (text.trim().isEmpty) return "Campo obrigatório";
                  if (text.trim().length < 10) return "Texto muito curto";
                  return null;
                },
                onSaved: (t) {},
              ),
              CepField(
                decoration: InputDecoration(labelText: "CEP *",
                    contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                    labelStyle:
                    TextStyle(fontWeight: FontWeight.w800, color: Colors.grey, fontSize: 18)),
              ),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: true),
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  RealInputFormatter(centavos: true)
                ],
                decoration: InputDecoration(
                    labelText: "Preço *",
                    contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.w800, color: Colors.grey, fontSize: 18)),
                validator: (text) {
                  if (text.trim().isEmpty) return "Campo obrigatório";
                  if (double.tryParse(text) == null) return "Utilize Valores Válidos";
                  return null;
                },
                onSaved: (price) {},
              ),
              Container(
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    getAdressFromAPI("54.270-320");
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                    }
                  },
                  color: Colors.pink,
                  child: Text(
                    "Enviar",
                    style:
                        TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
