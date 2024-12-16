import 'dart:developer';
import '../../Components/Layout.dart';
import 'Registrace.dart';
import 'package:flutter/material.dart';
import 'package:my_awesome_namer/Pages/Auth/Auth.dart';
import '../../../constants.dart';
import '../../Components/LogInRegister/LoginInput.dart';
import '../../Components/LogInRegister/LoginSubmit.dart';
import '../../Components/Backgrounds/BckLogin.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = AuthService();

  var user;
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          LoginPageBackground(
            position: 150,
          ),
          Container(
            margin: EdgeInsets.only(top: 110, left: 40),
            child: Text(
              'Přihlášení',
              style: TextStyle(
                color: Color.fromARGB(255, 107, 66, 38),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 100),
                  height: 410,
                  width: 350,
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(
                      color: Color(0x1A142131),
                      border: Border.all(
                        color: Color(0x1AFFFFFF),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(32)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Logininput(
                        title: EmailTitle,
                        hint: EmailHint,
                        password: false,
                        controller: _email,
                      ),
                      SizedBox(
                        height: 13.5,
                      ),
                      Logininput(
                        title: PasswordTitle,
                        hint: PasswordHint,
                        password: true,
                        controller: _password,
                      ),
                      SizedBox(
                        height: 27,
                      ),
                      LogInSubmit(
                        register: false,
                        onTap: () => {signIn(context)},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => {signInGoogle(context)},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/googleIcon.png", // Ujistěte se, že máte Google logo v assets
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Nemáte žádný účet?',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () => {
                              print('Login'),
                              goToRegistration(context),
                            },
                            child: Text(
                              'Zaregistrujte se!',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 241, 173),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> signIn(BuildContext context) async {
    log(_email.text.length.toString());
    log(_password.text.length.toString());

    user =
        await _auth.logInUserWithEmailAndPassword(_email.text, _password.text);

    if (user == null) {
      log('Přihlášení se nezdařilo');
      // Můžete zde přidat další logiku, například zobrazení chybového hlášení
    } else {
      log('Přihlášení úspěšné');
      goToHome(context);
      // Další akce po úspěšném přihlášení
    }
  }

  Future<void> signInGoogle(BuildContext context) async {
    try {
      await _auth.loginWithGoogle();
      goToHome(context);
    } catch (e) {
      print(e.toString());
    }
  }

  goToRegistration(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => Registration()));

  goToHome(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => MainLayout()));
}
