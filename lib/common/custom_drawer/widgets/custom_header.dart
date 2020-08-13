import 'package:flutter/material.dart';
import 'package:xlo/screens/login/login_screen.dart';

class CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginScreen()));
      },
      child: Container(
        height: 115.0,
        padding: const EdgeInsets.only(left: 40.0),
        color: Colors.blue,
        child: Row(
          children: [
            Icon(
              Icons.person,
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Acesse sua conta agora!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "Clique Aqui",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
