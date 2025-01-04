import 'package:flutter/material.dart';
import 'package:my_awesome_namer/Components/Background/MenuBckg.dart';
import 'package:my_awesome_namer/Components/BottomDots.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MenuBckg(),
        Column(
          children: [
            const Image(
              image: AssetImage('assets/map.png'),
            ),
            Text(
              'Vítej v Orgitu',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 203, 105),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 296,
              child: Text(
                'poslední krok, který tě čeká. Musíš se přihlásit buď do již existující skupiny, nebo ji sám můžeš vytvořit',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Button(
                  color: Color.fromARGB(255, 255, 203, 105),
                  text: 'Vytvořit skupinu',
                  textColor: Colors.black,
                ),
                SizedBox(
                  height: 20,
                ),
                Button(
                  text: 'Připojit se ke skupině',
                  color: Color.fromARGB(255, 60, 60, 60),
                )
              ],
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BottomDots(currentIndex: 2, totalDots: 3),
            SizedBox(
              height: 18,
            )
          ],
        )
      ],
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final Color color;
  final Color? textColor;

  const Button(
      {super.key,
      required this.text,
      required this.color,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Center(
        child: InkWell(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
