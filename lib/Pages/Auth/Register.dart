import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:orgit/Components/Feature/bottom_dots.dart';
import 'package:orgit/Components/Inputs/from_input.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:orgit/Components/Button/social_button.dart';
import 'package:logger/logger.dart';
import 'package:orgit/services/auth/auth.dart';
import 'package:orgit/global_vars.dart';
import 'package:orgit/services/api/api_client.dart';

class Register extends StatefulWidget {
  final VoidCallback onRegister;

  Register({required this.onRegister}) {
    debugPrint("Navigace na stránku Register");
  }

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailCont = TextEditingController();
  String emailError = "";
  Color emailValid = Colors.white;

  TextEditingController passwordCont = TextEditingController();
  String passwordError = "";
  Color passwordValid = Colors.white;

  TextEditingController repeatPasswordCont = TextEditingController();
  String repeatPasswordError = "";
  Color repeatPasswordValid = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.background,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => widget.onRegister(),
                          child: Text(
                            'Přihlásit se',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 203, 105),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Registrovat se',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          letterSpacing: 2,
                          color: Colors.white),
                    ),
                    Text(
                      'Vítejte v orgitu!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 203, 105),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      children: [
                        FormInput(
                          controller: emailCont,
                          labelText: 'EMAIL',
                          icon: Icons.check,
                          iconColor: emailValid,
                          righText: emailError,
                          rightTextColor: Colors.red,
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        FormInput(
                          labelText: 'HESLO',
                          controller: passwordCont,
                          obscureText: true,
                          showObscureText: true,
                          iconColor: passwordValid,
                          righText: passwordError,
                          rightTextColor: Colors.red,
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        FormInput(
                          labelText: 'HESLO ZNOVU',
                          controller: repeatPasswordCont,
                          obscureText: true,
                          showObscureText: false,
                          iconColor: repeatPasswordValid,
                          righText: repeatPasswordError,
                          rightTextColor: Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => register(emailCont.text, passwordCont.text,
                        repeatPasswordCont.text, context),
                    child: Container(
                      width: 240,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 203, 105),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          bottomLeft: Radius.circular(6),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Registrovat se',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.arrow_right_alt_rounded,
                            size: 50,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'nebo pokračovat',
                    style: TextStyle(
                      wordSpacing: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialButton(
                    color: Color.fromARGB(255, 66, 95, 131),
                    onPressed: () => (),
                    text: 'Facebook',
                    brand: Brand(Brands.facebook),
                  ),
                  SocialButton(
                      text: 'Google',
                      brand: Brand(Brands.google),
                      color: Color.fromARGB(255, 44, 105, 61),
                      onPressed: () => ()),
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BottomDots(currentIndex: 1, totalDots: 3),
              SizedBox(
                height: 18,
              )
            ],
          )
        ],
      ),
    );
  }

  Future<bool> emailValidation(String email) async {
    if (email.isEmpty) {
      setState(() {
        emailError = "Nezadal si email";
        emailValid = Colors.red;
      });
      return false;
    } else if (!EmailValidator.validate(email)) {
      setState(() {
        emailError = "Email není validní";
        emailValid = Colors.red;
      });
      return false;
    }
    // check if email already exists
    ApiClient _api = ApiClient();
    bool doesExists = await _api.getWithParams(
      "/email/",
      {"email": email},
    );
    if (doesExists) {
      setState(() {
        emailError = "Email již existuje";
        emailValid = Colors.red;
      });
      return false;
    }

    // Alls good
    setState(() {
      emailError = "";
      emailValid = Colors.green;
    });

    return true;
  }

  Future<bool> passwordValidation(
      String password, String repeatPassword) async {
    if (repeatPassword.isEmpty) {
      setState(() {
        repeatPasswordError = "Nezadal si heslo";
        repeatPasswordValid = Colors.red;
      });
    } else {
      setState(() {
        repeatPasswordError = "";
      });
    }

    RegExp regExp = RegExp(r'[!@#\$%\^&\*\(\)_\+\-=\[\]{};:"\\|,.<>\/?]');
    // password is empty
    if (password.isEmpty) {
      setState(() {
        passwordError = "Nezadal si heslo";
        passwordValid = Colors.red;
      });
      return false;
      // password doesnt have special symbol
    } else if (!regExp.hasMatch(password)) {
      setState(() {
        passwordError = "Heslo neobsahuje speciální znak";
        passwordValid = Colors.red;
      });
      return false;
      // password doesnt match with repeat password
    } else if (password != repeatPassword) {
      setState(() {
        passwordError = "Hesla se neshodují";
        repeatPasswordError = "Hesla se neshodují";
        passwordValid = Colors.red;
        repeatPasswordValid = Colors.red;
      });
      return false;
    }

    setState(() {
      passwordError = "";
      passwordValid = Colors.green;
      repeatPasswordValid = Colors.green;
    });
    return true;
  }

  Future<void> register(
    String email,
    String password,
    String repeatPassword,
    BuildContext context,
  ) async {
    print("Email: $email");
    print("Password: $password");
    print("Repeat Password: $repeatPassword");
    try {
      bool isValidEmail = await emailValidation(email);
      bool isValidPassword = await passwordValidation(password, repeatPassword);

      if (isValidEmail && isValidPassword) {
        // register
        try {
          await AuthService().createUserWithEmailAndPassword(email, password);
          // taking useruid
          // String userUID = FirebaseAuth.instance.currentUser!.uid;
          // ini. model
          // userAddSchema user = userAddSchema(
          //     useruid: userUID,
          //     firstname: "",
          //     lastname: "",
          //     nickname: "",
          //     email: email,
          //     profileicon: Uint8List.fromList([0]),
          //     telephoneprefix: "",
          //     telephonenumber: "",
          //     lastactive: DateTime.now(),
          //     birthday: DateTime.now());
          // // API service
          // final dio = Dio();
          // final client = RestClient(dio);
          // await client.createUser(user.toJson()); // des. user and post to API
          // Push to page
          // Navigationcontroller.goToMakeProfile(context);
        } on Exception catch (_) {
          Logger log = Logger();
          log.i(_);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
