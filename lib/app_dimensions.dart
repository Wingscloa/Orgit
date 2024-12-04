import 'package:flutter/material.dart';

class AppDimensions {
  // Statická proměnná pro výpočet
  static double PaddingCalc = 0.0;
  static double FontCalc = 0.0;

  // Inicializační metoda pro výpočet pouze jednou
  static void initialize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    PaddingCalc = ((size.width + size.height) / 1326) * 16;
    FontCalc = PaddingCalc; // podobný přístup jak k paddingu
    16; // Výpočet paddingu, součet sířky a výšky podílem originálního mobilu přes figmu a ziskání správného respon. kalkulace
  }
}
