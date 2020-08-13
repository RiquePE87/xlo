import 'package:flutter/material.dart';
import 'package:xlo/models/filter.dart';
import 'package:xlo/screens/filter/widgets/animated_button.dart';
import 'package:xlo/screens/filter/widgets/order_by_field.dart';
import 'package:xlo/screens/filter/widgets/price_range_field.dart';
import 'package:xlo/screens/filter/widgets/section_title.dart';
import 'package:xlo/screens/filter/widgets/vendor_type_field.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Filter _filter = Filter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text("Filtrar busca"),
      ),
      body: Stack(
        children: [
          Form(
              key: _formKey,
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                children: [
                  const SectionTitle(title: "Ordenar Por"),
                  OrderByField(
                      initialValue: _filter.orderBy,
                      onSaved: (v) {
                        _filter.orderBy = v;
                      }),
                  const SectionTitle(title: "Preço (R\$)"),
                  PriceRangeField(
                    filter: _filter,
                  ),
                  const SectionTitle(title: "Tipo de Anunciante"),
                  VendorTypeField(
                    initialValue: _filter.vendorType,
                    onSaved: (v) {
                      _filter.vendorType = v;
                    },
                  ),
                  SizedBox(
                    height: 200,
                  )
                ],
              )),
          AnimatedButton(
            scrollController: _scrollController,
            onTap: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                if (_filter.minPrice != null && _filter.maxPrice != null) {
                  if (_filter.minPrice > _filter.maxPrice) {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text("Faixa de preço inválida!"),
                      backgroundColor: Colors.pink,
                    ));
                    return;
                  }
                }
              }
            },
          )
        ],
      ),
    );
  }
}
