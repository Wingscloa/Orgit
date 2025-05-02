import 'package:flutter/material.dart';

class Global {
  static Color background = Color.fromARGB(255, 19, 20, 22);
  static Color settings = Color.fromARGB(255, 19, 20, 22);

  static TextStyle defaultStyle(double fontSize, bool? bold) {
    return TextStyle(
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: bold == true ? FontWeight.bold : FontWeight.w600,
    );
  }

  static double settingsSpace = 20;

  static void nothing() {
    print("funguju hehe");
  }
}
