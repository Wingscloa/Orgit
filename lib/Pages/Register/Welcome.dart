import 'package:flutter/material.dart';
import 'package:my_awesome_namer/Components/Background/MenuBckg.dart';
import 'package:my_awesome_namer/Components/BottomDots.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MenuBckg(),
        Column(
          children: [
            SizedBox(
              height: 50,
            ),
            const Image(
              image: AssetImage('assets/map.png'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Orgit',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 203, 105),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BottomDots(currentIndex: 0, totalDots: 3),
            SizedBox(
              height: 18,
            )
          ],
        )
      ],
    );
  }
}
