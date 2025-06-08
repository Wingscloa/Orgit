import 'package:flutter/material.dart';

/// Statická třída poskytující hodnoty pro responzivní design
class ResponsiveUtils {
  // Hodnoty pro text
  static double getTitleFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return 28; // Mobile
    if (screenWidth < 900) return 32; // Tablet
    return 36; // Desktop
  }

  static double getHeadingFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return 24; // Mobile
    if (screenWidth < 900) return 28; // Tablet
    return 32; // Desktop
  }

  static double getSubtitleFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return 16; // Mobile
    if (screenWidth < 900) return 18; // Tablet
    return 20; // Desktop
  }

  static double getBodyFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return 14; // Mobile
    if (screenWidth < 900) return 15; // Tablet
    return 16; // Desktop
  }

  static double getBodyTextFontSize(BuildContext context) {
    return getBodyFontSize(context);
  }

  static double getSmallFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return 12; // Mobile
    if (screenWidth < 900) return 13; // Tablet
    return 14; // Desktop
  }

  static double getLabelFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return 10; // Mobile
    if (screenWidth < 900) return 11; // Tablet
    return 12; // Desktop
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

  // Speciální breakpoint metody
  static bool isVerySmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 400;
  }

  static bool isTablet(BuildContext context) {
    return isMediumScreen(context);
  }

  static bool isDesktop(BuildContext context) {
    return isLargeScreen(context);
  }

  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  // Responsive šířky pro komponenty
  static double getLoginButtonWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return screenWidth * 0.75; // Mobile
    if (screenWidth < 900) return screenWidth * 0.6; // Tablet
    return screenWidth * 0.4; // Desktop
  }

  static double getSocialButtonWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return screenWidth * 0.35; // Mobile
    if (screenWidth < 900) return screenWidth * 0.3; // Tablet
    return screenWidth * 0.25; // Desktop
  }

  static double getFormInputWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return screenWidth * 0.7; // Mobile
    if (screenWidth < 900) return screenWidth * 0.65; // Tablet
    return screenWidth * 0.6; // Desktop
  }

  // Univerzální metoda pro responsive šířky
  static double getResponsiveWidth(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return mobile;
    if (screenWidth < 900) return tablet;
    return desktop;
  }
}
