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

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _passwordVerification = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Stack(
            children: [
              LoginPageBackground(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
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
                        register: true,
                        onTap: () => {
                          if (signIn()) {goToHome(context)}
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
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
                  )
                ],
              ),
            ],
          ),
        ));
  }

  signIn() async {
    log(_email.text.length.toString());
    log(_password.text.length.toString());
    final user =
        await _auth.logInUserWithEmailAndPassword(_email.text, _password.text);

    if (user != null) {
      log('User Created Succesfully');
      return true;
    }
  }

  goToRegistration(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => Registration()));

  goToHome(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => MainLayout()));
}
