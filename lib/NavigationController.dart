import 'package:flutter/material.dart';
import 'package:my_awesome_namer/Pages/Register/WelcomeScreen.dart';

class Navigationcontroller {
  static void goToWelcomeScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }
}
