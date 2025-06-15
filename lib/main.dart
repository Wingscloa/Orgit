import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:orgit/Pages/Auth/Register.dart';
import 'package:orgit/Pages/splashscreen/splashScreen.dart';
import 'package:orgit/utils/navigation_utils.dart';
import 'package:orgit/Pages/states/errorPage.dart';

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
      home: FutureBuilder<Widget>(
        future: NavigationUtils.getNavigation(
          duration: Duration(milliseconds: 2500), // Přidáno zpoždění 2500ms
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen(
              duration: const Duration(seconds: 2),
              onFinish: () {}, // Prázdný  callback
            );
          }

          if (snapshot.hasData) {
            return snapshot.data!;
          }

          return ErrorPage(); // Fallback to ErrorPage if no data
        },
      ),
    );
  }
}
