import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPageBackground extends StatefulWidget {
  @override
  State<LoginPageBackground> createState() => _LoginPageBackgroundState();
}

class _LoginPageBackgroundState extends State<LoginPageBackground> {
  @override
  Widget build(BuildContext context) {
    return Container( 
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height, // Výška obrazovky
      decoration: BoxDecoration(
        color: Color(0xFFFFF1AD), // Světle žluté pozadí
      ),
      child: Stack(
        children: [
          // Čtvercové pozadí s gradientem
          Positioned(
            top: 160, // Odsazení ze shora
            left: 0,
            child: Container(
              width: MediaQuery.of(context)
                  .size
                  .width, // Šířka čtverce (celá šířka mobilu)
              height: MediaQuery.of(context)
                  .size
                  .height, // Výška čtverce (celková výška mobilu)
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF6B4226), // Začátek gradientu
                    Color(0xFFB37F4F), // Konec gradientu
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft:
                      Radius.circular(120), // Zaoblený roh v levém horním rohu
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
