import 'package:flutter/material.dart';
import 'package:orgit/Pages/Auth/Register.dart';
import 'package:orgit/Pages/Auth/profile_form.dart';
import 'package:orgit/Pages/group/join_group.dart';
import 'package:orgit/Pages/homepage.dart';
import 'package:orgit/services/auth/auth.dart';
import 'package:orgit/services/cache/cache_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';
import 'dart:async';

class NavigationUtils {
  // Konstanty pro stránky
  static const String PAGE_REGISTER = 'register';
  static const String PAGE_LOGIN = 'login';
  static const String PAGE_PROFILE = 'profile';
  static const String PAGE_JOIN_GROUP = 'join_group';
  static const String PAGE_HOMEPAGE = 'homepage';

  static final CacheService _cacheService = CacheService.instance;

  static Future<bool> _hasInternetConnection() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) return false;

      final socket =
          await Socket.connect('8.8.8.8', 53, timeout: Duration(seconds: 2));
      socket.destroy();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Jednoduchá navigace - vrátí destination string
  static Future<String> getInitialDestination() async {
    try {
      final hasInternet = await _hasInternetConnection();
      return hasInternet ? await _navigateOnline() : await _navigateOffline();
    } catch (e) {
      print("❌ Navigation error: $e");
      return PAGE_REGISTER;
    }
  }

  static Future<Widget> getInitialPage() async {
    await Future.delayed(Duration(milliseconds: 3500));
    final destination = await getInitialDestination();
    return getPageWidget(destination);
  }

  /// Vrátí Widget podle destination
  static Widget getPageWidget(String destination) {
    switch (destination) {
      case PAGE_REGISTER:
        return Register();
      case PAGE_PROFILE:
        return Profileform();
      case PAGE_JOIN_GROUP:
        return Joingroup();
      case PAGE_HOMEPAGE:
      default:
        return Homepage(initPage: 0);
    }
  }

  /// Online navigace
  static Future<String> _navigateOnline() async {
    final authService = AuthService();
    final isLoggedIn = await authService.isUserLoggedInAsync();

    if (isLoggedIn) {
      await _cacheService.setWasLoggedIn(true);

      // Cache-first přístup pro kontrolu stavu uživatele
      final isProfileComplete = await authService.isUserProfileComplete();
      final isUserInGroup = await authService.isUserInGroup();

      String destination;
      if (!isProfileComplete) {
        destination = PAGE_PROFILE;
      } else if (!isUserInGroup) {
        destination = PAGE_JOIN_GROUP;
      } else {
        destination = PAGE_HOMEPAGE;
      }

      // Ulož kompletní offline stav pro případ výpadku internetu
      await _cacheService.saveOfflineUserState(
        isLoggedIn: true,
        destination: destination,
        profileComplete: isProfileComplete,
        inGroup: isUserInGroup,
      );

      print('🧭 Online navigation: User logged in, destination: $destination');
      return destination;
    } else {
      await _cacheService.setWasLoggedIn(false);
      final wasLoggedIn = await _cacheService.getWasLoggedIn();
      final isRecent = await _cacheService.isRecentSession();
      final destination =
          (wasLoggedIn && isRecent) ? PAGE_LOGIN : PAGE_REGISTER;

      print(
          '🧭 Online navigation: User not logged in, destination: $destination');
      return destination;
    }
  }

  /// Offline navigace
  static Future<String> _navigateOffline() async {
    print('🔌 Offline navigation: Checking cached user state...');

    // Pokus se načíst uložený offline stav
    final offlineState = await _cacheService.getOfflineUserState();
    if (offlineState != null && offlineState['isLoggedIn'] == true) {
      final destination = offlineState['destination'] as String;
      print('🔌 Offline navigation: Found cached destination: $destination');
      return destination;
    }

    // Fallback na poslední stránku pokud není offline stav
    final lastPage = await _cacheService.getLastPage();
    if (lastPage != null) {
      print('🔌 Offline navigation: Using last visited page: $lastPage');
      return lastPage;
    }

    // Poslední fallback na základě session historie
    final wasLoggedIn = await _cacheService.getWasLoggedIn();
    final isRecent = await _cacheService.isRecentSession();
    final fallbackDestination =
        (wasLoggedIn && isRecent) ? PAGE_LOGIN : PAGE_REGISTER;

    print(
        '🔌 Offline navigation: No cached state, using fallback: $fallbackDestination');
    return fallbackDestination;
  }

  /// Jednoduchá navigace na widget
  static void navigateToWidget(BuildContext context, Widget targetWidget) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => targetWidget),
    );
  }

  /// Získá cílovou stránku po úspěšném přihlášení
  static Future<Widget> getPostLoginPage() async {
    try {
      print('🧭 Getting post-login page...');
      final authService = AuthService();

      // Cache-first přístup pro rychlé určení stavu
      final isProfileComplete = await authService.isUserProfileComplete();
      final isUserInGroup = await authService.isUserInGroup();

      String destination;
      if (!isProfileComplete) {
        destination = PAGE_PROFILE;
        print('🧭 Post-login: Profile incomplete, navigating to profile form');
      } else if (!isUserInGroup) {
        destination = PAGE_JOIN_GROUP;
        print(
            '🧭 Post-login: Profile complete but no group, navigating to join group');
      } else {
        destination = PAGE_HOMEPAGE;
        print('🧭 Post-login: User fully set up, navigating to homepage');
      }

      // Aktualizuj cache pro offline použití
      await _cacheService.saveOfflineUserState(
        isLoggedIn: true,
        destination: destination,
        profileComplete: isProfileComplete,
        inGroup: isUserInGroup,
      );

      await _cacheService.setLastPage(destination);

      return getPageWidget(destination);
    } catch (e) {
      print('🚨 Error in getPostLoginPage: $e');
      // Fallback na homepage při chybě
      return getPageWidget(PAGE_HOMEPAGE);
    }
  }
}
