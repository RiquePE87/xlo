import 'package:flutter/material.dart';
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
      appBar: AppBar(title: Text("Inserir Anúncio"),
      elevation: 0,),
      drawer: CustomDrawer(),
      body: Form(
        key: _formKey,
          child: ListView(
            children: [
              ImagesField()
            ],
          )),
    );
  }
}
