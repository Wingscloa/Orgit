import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:orgit/Pages/splashscreen/splashScreen.dart';
import 'package:orgit/services/auth/auth.dart';
import 'package:orgit/Pages/Auth/Register.dart';
import 'package:orgit/Pages/Auth/profile_form.dart';
import 'package:orgit/Pages/group/join_group.dart';
import 'package:orgit/Pages/homepage.dart';

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
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
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
      debugShowCheckedModeBanner: false,
      // home: Homepage(initPage: 0),
      home: SplashScreen(
        duration: const Duration(seconds: 2),
        onFinish: () async {
          try {
            final AuthService authService = AuthService();

            final String destination =
                await authService.determineUserDestination();

            switch (destination) {
              case 'register':
                navigatorKey.currentState?.pushReplacement(
                  MaterialPageRoute(builder: (context) => Register()),
                );
                break;
              case 'profile':
                navigatorKey.currentState?.pushReplacement(
                  MaterialPageRoute(builder: (context) => Profileform()),
                );
                break;
              case 'join_group':
                navigatorKey.currentState?.pushReplacement(
                  MaterialPageRoute(builder: (context) => Joingroup()),
                );
                break;
              case 'homepage':
              default:
                navigatorKey.currentState?.pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => Homepage(initPage: 0)),
                );
                break;
            }
          } catch (e) {
            print("❌ Chyba při určování destinace: $e");
            if (context.mounted) {
              navigatorKey.currentState?.pushReplacement(
                MaterialPageRoute(builder: (context) => Register()),
              );
            }
          }
        },
      ),
    );
  }
}
