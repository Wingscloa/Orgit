import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:orgit/auth/auth.dart';
import 'package:orgit/models/user.dart';
import 'dart:async';
import 'package:orgit/services/api_client.dart';
import 'package:orgit/auth/auth.dart';
import 'package:orgit/Pages/group/join_group.dart';
import 'package:orgit/Pages/Auth/Register.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserInfo {
  static String uid = "";
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await dotenv.load(fileName: ".vars");

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _auth = AuthService();

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
        primaryColor: const Color.fromARGB(255, 5, 5, 4),
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 0, 0)),
      ),
      debugShowCheckedModeBanner: false,
      home: wrapped(auth: _auth),
      // home: FutureBuilder(
      //   future: Firebase.initializeApp(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       _auth.signOut();
      //       if (!_auth.isUserLoggedIn()) {
      //         return Register(onRegister: () => print("ahoj"));
      //       } else {
      //         return Joingroup();
      //       }
      //     }
      //     if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     }
      //     return Center(child: CircularProgressIndicator());
      //   },
      // ),
    );
  }
}

class wrapped extends StatelessWidget {
  const wrapped({
    super.key,
    required AuthService auth,
  }) : _auth = auth;

  final AuthService _auth;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            spacing: 10,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 190, 155, 155),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () => _auth.logInUserWithEmailAndPassword(
                        "8filipino@gmail.com", "99tablet"),
                    child: Text(
                      "Prihlasit se",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 190, 155, 155),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () => print(ApiClient.getBaseUrl()),
                    child: Text(
                      "Print IpHost",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 190, 155, 155),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () => _auth.getIdToken().then((value) {
                      print(value);
                    }),
                    child: Text(
                      "idToken",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 190, 155, 155),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () => createAccount(),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Vytvorit uzivatele",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              apiTesting(
                endpoint: "/email/",
                header: "Email",
              ),
              apiTesting(
                endpoint: "/email/",
                header: "Todos2",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createAccount() {
    AuthService auth = AuthService();
    auth.signOut();
    if (!auth.isUserLoggedIn()) {
      String email = "9filipino@gmail.com";
      String password = "99tablet";
      auth.createUserWithEmailAndPassword(email, password);
      UserRegister user =
          UserRegister(useruid: auth.getUserUid(), email: email);
      ApiClient()
          .post(
        '/User/',
        user.toJson(),
      )
          .then((value) {
        print(value);
      });
    }
  }
}

class apiTesting extends StatelessWidget {
  final String endpoint;
  final String header;
  const apiTesting({
    required this.endpoint,
    this.header = "Musis me kliknout",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        print("Klikl si me"),
        // beru data a filtruju je podle parametru
        // ApiClient().getWithParams(
        //     endpoint, {"email": "8filipino@gmail.com"}).then((value) {
        //   print(value);
        // }),
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 193, 95, 95),
          borderRadius: BorderRadius.circular(20),
        ),
        width: 125,
        height: 125,
        child: Center(
          child: Text(
            header,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
