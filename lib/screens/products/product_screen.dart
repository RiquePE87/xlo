import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:xlo/models/ad.dart';

class ProductScreen extends StatelessWidget {

  final Ad ad;

  ProductScreen(this.ad);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anúncio"),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            height: 280,
            child: Carousel(
              dotSize: 4,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              autoplay: false,
              dotColor: Colors.pink,
              images: ad.images.map((f){
                return FileImage(f);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
