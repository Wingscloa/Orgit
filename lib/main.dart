import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:my_awesome_namer/Pages/Register/MainMenu.dart';
import 'package:my_awesome_namer/Pages/Register/MakeProfile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

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
          brightness: Brightness.light,
          primaryColor: Color(0xFFFBE79F),
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFFBE79F)),
        ),
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) {
            // if (FirebaseAuth.instance.currentUser != null) {
            //   //sign in
            //   return MainLayout();
            // } else {
            //   //sign out
            //   return Registration();
            // }
            return MakeProfile();
          },
        ));
  }
}
