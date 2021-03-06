import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {
  final String label;
  final BoxDecoration boxDecoration;
  final VoidCallback onPress;

  BarButton({this.label, this.boxDecoration, this.onPress});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          height: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: boxDecoration,
          child: Text(label,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 18,
            fontWeight: FontWeight.w400
          ),
          ),
        ),
      ),
    );
  }
}
