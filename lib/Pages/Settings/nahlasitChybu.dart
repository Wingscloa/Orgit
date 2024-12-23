import 'package:flutter/material.dart';
import 'package:my_awesome_namer/constants.dart';
import '../../Components/Backgrounds/BckMain.dart';

class Nahlasitchybu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          MainBackground(),
          Container(
            margin: EdgeInsets.only(top: 50, left: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nahlásit',
                  style: TextStyle(
                    color: Color.fromARGB(255, 107, 66, 38),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'chybu',
                  style: TextStyle(
                    color: Color.fromARGB(255, 107, 66, 38),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
