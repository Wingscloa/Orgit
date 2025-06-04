import 'package:flutter/material.dart';

/// Statická třída poskytující hodnoty pro responzivní design
class ResponsiveUtils {
  // Hodnoty pro text
  static double getHeadingFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.08; // 8% šířky obrazovky
  }

  static double getSubtitleFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.035; // 3.5% šířky obrazovky
  }

  static double getBodyTextFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.03; // 3% šířky obrazovky
  }

  // Hodnoty pro velikosti komponent
  static double getButtonWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.5; // 50% šířky obrazovky
  }

  static double getButtonHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.07; // 7% výšky obrazovky
  }

  // Hodnoty pro padding a mezery
  static double getPaddingHorizontal(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.06; // 6% šířky obrazovky
  }

  static double getPaddingVertical(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.03; // 3% výšky obrazovky
  }

  static double getSpacingSmall(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.01; // 1% výšky obrazovky
  }

  static double getSpacingMedium(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.025; // 2.5% výšky obrazovky
  }

  static double getSpacingLarge(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.04; // 4% výšky obrazovky
  }

  // Rozlišení velikosti obrazovky pro podmíněné vykreslování
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 900;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 900;
  }

  // Speciální hodnoty pro obrázky
  static double getImageWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.8; // 80% šířky obrazovky
  }

  // Hodnoty pro ikony
  static double getIconSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.06; // 6% šířky obrazovky
  }
}
