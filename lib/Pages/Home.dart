import 'package:flutter/material.dart';
import 'package:my_awesome_namer/Pages/Profile.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'AKCE 2024/2025',
                    style: TextStyle(
                      color: Color.fromARGB(255, 107, 66, 38),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Celkem 7 akcí',
                    style: TextStyle(
                      color: Color.fromARGB(125, 107, 66, 38),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              ProfileIcon(
                size: 50,
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.90, // Šířka
            height: 170, // Výška
            decoration: BoxDecoration(
              color: Color(0x4DFFF1AD), // Fill barva s 30% neprůhledností
              border: Border.all(
                color: Color(0x1AFFFFFF), // Stroke barva s 10% neprůhledností
                width: 1, // Tloušťka obrysu
              ),
              borderRadius: BorderRadius.circular(32), // Zaoblené rohy
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 12,
                left: 26,
                right: 29,
                bottom: 12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Betlémské světlo',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          'Zip, Nemo',
                          style: TextStyle(
                              color: Colors.white.withAlpha(125),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ProfileIcon(size: 40),
                          SizedBox(
                            width: 11,
                          ),
                          ProfileIcon(size: 40),
                        ],
                      ),
                      Text(
                        '1.12.2024',
                        style: TextStyle(
                          color: Colors.white.withAlpha(125),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: 290,
            decoration: BoxDecoration(
              color: Color(0x1A000000), // Fill barva (světle modrá)
              border: Border.all(
                color: Color(
                    0x1A000000), // Stroke barva (černá, 10% neprůhlednost)
                width: 1, // Tloušťka obrysu
              ),
              borderRadius: BorderRadius.circular(32), // Zaoblené rohy
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                runSpacing: 16,
                children: [
                  CalendarButton(datum: 'dawdwadawd', nazev: 'BS-Vídeň'),
                  CalendarButton(datum: 'test', nazev: 'Podzimky'),
                  CalendarButton(datum: 'dawdw', nazev: 'Oddílova'),
                  CalendarButton(datum: 'test', nazev: '3. jezy'),
                  CalendarButton(datum: 'test', nazev: 'Pazourky'),
                  CalendarButton(datum: 'test', nazev: 'Bruslení'),
                  CalendarButton(datum: 'test', nazev: 'BS-Praha'),
                  CalendarButton(datum: 'test', nazev: 'Svojcikac'),
                  CalendarButton(datum: 'test', nazev: 'Plavení Jara'),
                  CalendarButton(datum: 'test', nazev: 'Tábor'),
                  CalendarButton(datum: 'test', nazev: 'BS-Praha'),
                  CalendarButton(datum: 'test', nazev: 'Svojcikac'),
                  CalendarButton(datum: 'test', nazev: 'Plavení Jara'),
                  CalendarButton(datum: 'test', nazev: 'Tábor'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
    return Column(
      children: [
        Container(
          height: 55,
          width: 55,
          decoration: new BoxDecoration(
              color: Color.fromARGB(125, 255, 241, 173),
              borderRadius: BorderRadius.circular(8)),
        ),
        Text(
          nazev,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
      ],
    );
  }
}
