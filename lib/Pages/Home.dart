import 'package:flutter/material.dart';
import 'package:my_awesome_namer/Pages/Profile.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      //Profilovka
      Container(
        margin: EdgeInsets.only(top: 50, right: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ProfileIcon(
              size: 50,
            )
          ],
        ),
      ),
      //Text Akce + Soucet akci
      Container(
        margin: EdgeInsets.only(top: 125, left: 110),
        child: Column(
          children: [
            Text(
              'AKCE 2024/2025',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Celkem 7 akcí',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      // informace o nejblizsi schuzce
      Container(
        margin: EdgeInsets.only(top: 200, left: 25),
        padding: EdgeInsets.all(20),
        width: 350,
        height: 160,
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: new LinearGradient(
                colors: [
                  Color.fromRGBO(20, 33, 49, 1),
                  Color.fromRGBO(0, 1, 19, 0.098)
                ],
                stops: [
                  0.0,
                  1.0
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                tileMode: TileMode.repeated)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nazev akce
            Text(
              'Betlémské světlo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Jmena vedouciho a 18+ dozoru
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                'Zip, Nemo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ProfileIcon(
                        size: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ProfileIcon(
                        size: 40,
                      )
                    ],
                  ),
                  Text(
                    '1.12.2024',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // kalendar
          ],
        ),
      ),
      // kalendar
      Container(
          width: 280,
          height: 320,
          margin: EdgeInsets.only(top: 375, left: 55),
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: new LinearGradient(
                  colors: [
                    Color.fromRGBO(20, 33, 49, 1),
                    Color.fromRGBO(0, 1, 19, 0.098)
                  ],
                  stops: [
                    0.0,
                    1.0
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  tileMode: TileMode.repeated)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Prosinec 2024',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(child: CalendarButton(datum: '2024', nazev: 'nazev'))
            ],
          )),
    ]);
  }
}

class ProfileIcon extends StatelessWidget {
  final double size;
  const ProfileIcon({
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.network(
        'https://via.placeholder.com/200',
        width: size,
        height: size,
      ),
    );
  }
}

class CalendarButton extends StatelessWidget {
  final String datum;
  final String nazev;
  const CalendarButton({
    required this.datum,
    required this.nazev,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                Color.fromRGBO(20, 33, 49, 1),
                Color.fromRGBO(0, 1, 19, 0.098)
              ],
                  stops: [
                0.0,
                1.0
              ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  tileMode: TileMode.repeated)),
          child: Column(children: [
            Text(
              "ahoj",
              textAlign: TextAlign.center,
            ),
          ]),
        ),
      ],
    );
  }
}
