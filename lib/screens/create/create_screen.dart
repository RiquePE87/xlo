import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo/api/api_postalcode.dart';
import 'package:xlo/common/cep_field.dart';
import 'package:xlo/common/custom_drawer/custom_drawer.dart';
import 'package:xlo/models/ad.dart';
import 'package:xlo/screens/create/widgets/hide_phone_widget.dart';
import 'package:xlo/screens/create/widgets/images_field.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Ad ad = Ad();

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
                 ad.images = images;
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
                onSaved: (t) {
                  ad.title = t;
                },
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
                onSaved: (d) {
                  ad.description = d;
                },
              ),
              CepField(
                decoration: InputDecoration(labelText: "CEP *",
                    contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                    labelStyle:
                    TextStyle(fontWeight: FontWeight.w800, color: Colors.grey, fontSize: 18)),
                onSaved: (c){
                  ad.address = c;

                }
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
                  if (int.tryParse(getSanitizedText(text)) == null) return "Utilize Valores Válidos";
                  return null;
                },
                onSaved: (price) {
                  ad.price = int.parse(getSanitizedText(price)) / 100;
                },
              ),
              HidePhoneWidget(
                onSaved: (s){
                  ad.hidePhone = s;

                },
                initialValue: false,
              ),
              Container(
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      print(ad);
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
  String getSanitizedText(String text){
    return text.replaceAll(RegExp(r'[^\d]'), "");
  }
}
