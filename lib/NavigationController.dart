import 'package:flutter/material.dart';
import 'package:Orgit/Pages/Main/Group/joinGroup.dart';
import 'package:Orgit/Pages/Auth/profileForm.dart';

class Navigationcontroller {
  static void goToWelcomeScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Joingroup()));
  }

  static void goToMakeProfile(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Profileform()));
  }
}
