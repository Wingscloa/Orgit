import 'package:flutter/material.dart';
import 'package:orgit/Components/Feature/bottom_dots.dart';

class Openingintro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
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
      ),
    );
  }
}
