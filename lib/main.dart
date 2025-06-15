import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:orgit/Pages/Auth/Register.dart';
import 'package:orgit/Pages/group/group_page.dart';
import 'package:orgit/Pages/todo/todo_page.dart';
import 'package:orgit/Pages/splashscreen/splashScreen.dart';
import 'package:orgit/services/auth/auth.dart';
import 'package:orgit/services/cache/cache.dart';
import 'package:orgit/utils/navigation_utils.dart';
import 'package:orgit/Pages/calendar/calendar_page.dart';

class UserInfo {
  static String uid = "";
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Orgit",
      theme: ThemeData(
        navigationBarTheme: const NavigationBarThemeData(
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        brightness: Brightness.light,
        primaryColor: const Color.fromARGB(255, 5, 5, 4),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      home: Calendarpage(),
      // home: FutureBuilder<Widget>(5
      //   future: NavigationUtils.getInitialPage(),
      //   builder: (context, snapshot) {
      //     // final AuthService authService = AuthService();
      //     // authService.signOut();
      //     final CacheService cacheService = CacheService.instance;
      //     cacheService.debugAllSharedPreferences();
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return SplashScreen(
      //         duration: const Duration(seconds: 2),
      //         onFinish: () {}, // Prázdný  callback
      //       );
      //     }

      //     if (snapshot.hasData) {
      //       return snapshot.data!;
      //     }
      //     return Register();
      //   },
      // ),
    );
  }
}
