import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xlo/blocs/create_bloc.dart';
import 'package:xlo/blocs/drawer_bloc.dart';
import 'package:xlo/blocs/home_bloc.dart';
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
  CreateBloc _createBloc;
  Ad ad = Ad();

  @override
  void initState() {
    super.initState();
    _createBloc = CreateBloc();
  }

  @override
  void dispose() {
    _createBloc?.dispose();
    super.dispose();
  }

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
          child: StreamBuilder<CreateState>(
              stream: _createBloc.outState,
              builder: (context, snapshot) {
                if (snapshot.data == CreateState.LOADING) {
                  return Center(
                    child: Container(
                      width: 300,
                      height: 300,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                        strokeWidth: 5.0,
                      ),
                    ),
                  );
                }

                return ListView(
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
                          contentPadding:
                              const EdgeInsets.fromLTRB(16, 10, 12, 10),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.grey,
                              fontSize: 18)),
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
                          contentPadding:
                              const EdgeInsets.fromLTRB(16, 10, 12, 10),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.grey,
                              fontSize: 18)),
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
                        decoration: InputDecoration(
                            labelText: "CEP *",
                            contentPadding:
                                const EdgeInsets.fromLTRB(16, 10, 12, 10),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.grey,
                                fontSize: 18)),
                        onSaved: (c) {
                          ad.address = c;
                        }),
                    TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        RealInputFormatter(centavos: true)
                      ],
                      decoration: InputDecoration(
                          labelText: "Preço *",
                          contentPadding:
                              const EdgeInsets.fromLTRB(16, 10, 12, 10),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.grey,
                              fontSize: 18)),
                      validator: (text) {
                        if (text.trim().isEmpty) return "Campo obrigatório";
                        if (int.tryParse(getSanitizedText(text)) == null)
                          return "Utilize Valores Válidos";
                        return null;
                      },
                      onSaved: (price) {
                        ad.price = int.parse(getSanitizedText(price)) / 100;
                      },
                    ),
                    HidePhoneWidget(
                      onSaved: (h) {
                        ad.hidePhone = h;
                      },
                      initialValue: false,
                    ),
                    Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            Provider.of<HomeBloc>(context).addAd(ad);

                            final bool success = await _createBloc.saveAd(ad);

                            if (success) {
                              Provider.of<DrawerBloc>(context).setPage(0);
                            }
                          }
                        },
                        color: Colors.pink,
                        child: Text(
                          "Enviar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                );
              })),
    );
  }

  String getSanitizedText(String text) {
    return text.replaceAll(RegExp(r'[^\d]'), "");
  }
}
