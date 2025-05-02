import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:orgit/pages/settings/settings.dart';
import 'dart:async';

class UserInfo {
  static String uid = "";
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        navigationBarTheme: const NavigationBarThemeData(
            labelTextStyle: WidgetStatePropertyAll(TextStyle(
          fontSize: 16,
          color: Colors.white,
        ))),
        brightness: Brightness.light,
        primaryColor: const Color(0xFFFBE79F),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFFBE79F)),
      ),
      debugShowCheckedModeBanner: false,
      // home: FutureBuilder(
      //   future: _checkUserProfile(),
      //   builder: (context, AsyncSrnapshot<Widget> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Container();
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     } else {
      //       return snapshot.data!;
      //     }
      //   },
      // ),
      // home: Joingroup(),
      // home: Homepage(initPage: 0),
      home: Settings(),
    );
  }

  // Future<Widget> _checkUserProfile() async {
  //   // _LoadingScreenState().dispose();
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     //sign in
  //     UserInfo.uid = FirebaseAuth.instance.currentUser!.uid;
  //     // API service - Is profile made?
  //     try {
  //       Logger log = Logger();

  //       // log.i(response.detail.nickname);

  //       // if (response.detail.nickname == "") {
  //       //   return MakeProfile();
  //       // } else {
  //       //   return WelcomeScreen();
  //       // }
  //       return Joingroup();
  //       // return Modcreategroup();
  //     } on Exception catch (_) {
  //       Logger log = Logger();
  //       log.i(_);
  //       return ErrorPage();
  //     }
  //   } else {
  //     //sign out
  //     return Joingroup();
  //   }
  // }
}
