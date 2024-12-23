import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_awesome_namer/Pages/Settings/upozorneni.dart';
import 'package:my_awesome_namer/app_dimensions.dart';
import 'Components/Layout.dart';
import 'Pages/Auth/Registrace.dart';
import 'Pages/Settings/account.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await await Firebase.initializeApp();

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
        title: "Be Scout App",
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFFFBE79F),
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFFBE79F)),
        ),
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) {
            AppDimensions.initialize(context);
            // if (FirebaseAuth.instance.currentUser != null) {
            //   //sign in
            //   return MainLayout();
            // } else {
            //   //sign out
            //   return Registration();
            // }
            return Upozorneni();
          },
        ));
  }
}
