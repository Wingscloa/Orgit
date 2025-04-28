import 'package:flutter/material.dart';

class Calendarpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin: EdgeInsets.only(top: 90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'KALENDÁŘ',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
              ],
            )),
        Center(
            child: Container(
          width: 360,
          height: 75,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2.5),
            color: Color.fromARGB(255, 54, 54, 52),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              textAlign: TextAlign.center,
              "PRACUJE SE NA TOM",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 32,
              ),
            ),
          ),
        ))
      ],
    );
  }
}
