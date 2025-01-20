import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:my_awesome_namer/Auth/Auth.dart';
import 'package:my_awesome_namer/Pages/Register/MainMenu.dart';
import 'package:my_awesome_namer/Pages/Register/MakeProfile.dart';
import 'package:dio/dio.dart';
import 'package:my_awesome_namer/Pages/Register/WelcomeScreen.dart';
import 'package:my_awesome_namer/models/user_model.dart';
import 'package:my_awesome_namer/service/api_service.dart';
import 'dart:async';
import 'dart:math';
import 'package:my_awesome_namer/Pages/FigmaPages/ErrorPage.dart';

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
        brightness: Brightness.light,
        primaryColor: Color(0xFFFBE79F),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFFBE79F)),
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _checkUserProfile(),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return snapshot.data!;
          }
        },
      ),
    );
  }

  Future<Widget> _checkUserProfile() async {
    // _LoadingScreenState().dispose();
    if (FirebaseAuth.instance.currentUser != null) {
      //sign in
      UserInfo.uid = FirebaseAuth.instance.currentUser!.uid;
      // API service - Is profile made?
      try {
        final client = RestClient(Dio());

        ApiResponseUser response = await client.getUserByUid(UserInfo.uid);

        Logger log = Logger();

        log.i(response.detail.nickname);

        if (response.detail.nickname == "") {
          return MakeProfile();
        } else {
          return WelcomeScreen();
        }
      } on Exception catch (_) {
        Logger log = Logger();
        log.i(_);
        return ErrorPage();
      }
    } else {
      //sign out
      return MainMenu();
    }
  }
}

// class LoadingScreen extends StatefulWidget {
//   @override
//   _LoadingScreenState createState() => _LoadingScreenState();
// }

// class _LoadingScreenState extends State<LoadingScreen> {
//   List<String> loadingMessages = [
//     "Připravujeme všechno na váš den.",
//     "Už to skoro máme, plánujte zatím v hlavě!",
//     "Vaše úkoly jsou v bezpečí, stejně jako vaše kočka na parapetu.",
//     "Lepší organizace začíná právě teď.",
//     "Skládáme tým, prosím čekejte.",
//     "Dokončujeme poslední detaily.",
//     "Organizujeme jako šéf... a možná i lépe!",
//     "Všechny plány jsou na cestě. Doufáme, že i vaše káva!",
//     "Dobrý plán je jako mapa. I když ztratíte směr, víte, kam se vrátit.",
//     "Organizace přináší klid, jako slunečný den."
//   ];
//   String currentMessage = "";
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _setRandomMessage();
//   }

//   void _setRandomMessage() {
//     // Změna zprávy každé 3 sekundy
//     _timer = Timer.periodic(Duration(seconds: 3), (timer) {
//       setState(() {
//         currentMessage =
//             loadingMessages[Random().nextInt(loadingMessages.length)];
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.deactivate();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 26, 27, 29),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(
//               color: Colors.white,
//             ),
//             SizedBox(height: 20),
//             Text(
//               "ORGIT",
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               currentMessage,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.white70,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
