import 'package:flutter/material.dart';
import 'package:my_awesome_namer/Components/Background/MenuBckg.dart';
import 'package:my_awesome_namer/Components/BottomDots.dart';
import 'package:my_awesome_namer/Components/FormInput.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:my_awesome_namer/Components/SocialButton.dart';
import 'package:my_awesome_namer/NavigationController.dart';

class Login extends StatelessWidget {
  final VoidCallback onLogin;

  final email = TextEditingController();

  final password = TextEditingController();

  Login({required this.onLogin}) {
    debugPrint("Navigace na stránku Login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            MenuBckg(),
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
                        height: 85,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => onLogin(),
                            child: Text(
                              'Registrovat se',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 203, 105),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ],
                      ),
                      Text(
                        'Přihlásit se',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.white),
                      ),
                      Text(
                        'Vítejte zpět!',
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
                            controller: email,
                            labelText: 'EMAIL',
                            icon: Icons.check,
                            iconColor: Colors.white,
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          FormInput(
                            labelText: 'HESLO',
                            controller: password,
                            obscureText: true,
                            showObscureText: true,
                            changePassword: true,
                            iconColor: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
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
                            'Přihlásit se',
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
                  ],
                ),
                SizedBox(
                  height: 70,
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
        ));
  }
}