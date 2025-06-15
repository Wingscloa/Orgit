import 'package:flutter/material.dart';
import 'package:orgit/Pages/Auth/Register.dart';
import 'package:orgit/Pages/Auth/profile_form.dart';
import 'package:orgit/Pages/group/join_group.dart';
import 'package:orgit/Pages/homepage.dart';
import 'package:orgit/services/api/api_client.dart';
import 'package:orgit/services/auth/auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';
import 'package:orgit/Pages/states/errorPage.dart';
import 'package:orgit/Pages/states/offlinePage.dart';
import 'dart:async';

class NavigationUtils {
  static Future<Widget> getNavigation({Duration? duration}) async {
    if (duration != null) {
      await Future.delayed(duration);
    }
    try {
      bool isOnline = await hasInternetConnection();
      if (isOnline) {
        String userUid = await AuthService().getUserUidAsync();
        if (userUid == "-1") // neni prihlaen
        {
          return Register();
        } else {
          // prihlasen
          try {
            ApiClient apiClient = ApiClient();
            final user = await apiClient.get('/User/$userUid');
            print('User response: $user');

            if (user['firstname'] == null) {
              return Profileform();
            }
            final isInGroup =
                await apiClient.get("/User/in-group/?useruid=$userUid");
            if (isInGroup['in_group'] == false) {
              return Joingroup();
            } else {
              return Homepage(initPage: 1);
            }
          } catch (e) {
            return ErrorPage(); // Fallback to error page on API error
          }
        }
      } else {
        return OfflinePage();
      }
    } catch (e) {
      return ErrorPage();
    }
  }

  static Future<bool> hasInternetConnection() async {
    try {
      // Nejprve zkontrolujeme stav konektivity, což je rychlá lokální operace
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false; // Zařízení není připojeno k žádné síti
      }

      // Zkrátíme timeout a použijeme try-catch pro zachycení timeoutu
      try {
        final socket = await Socket.connect('8.8.8.8', 53,
            timeout: Duration(milliseconds: 500));
        socket.destroy();
        return true;
      } catch (socketError) {
        print('Socket connection error: $socketError');
        return false;
      }
    } catch (e) {
      print('Internet connection check error: $e');
      return false;
    }
  }
}
