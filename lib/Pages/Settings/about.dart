import 'package:flutter/material.dart';
import '../../Components/Backgrounds/BckMain.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          MainBackground(),
          Container(
            margin: EdgeInsets.only(top: 50, left: 40),
            child: Column(
              children: [
                Text(
                  'Informace',
                  style: TextStyle(
                    color: Color.fromARGB(255, 107, 66, 38),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'o aplikaci',
                  style: TextStyle(
                    color: Color.fromARGB(255, 107, 66, 38),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ScoutApp',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    LatestVersion(
                      version: '2.0',
                    ),
                    UserVersion(
                      version: '1.9',
                    ),
                    AboutAppContainer(
                        support: 'ScoutApp@gmail.com, +420 774 434 756'),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Aplikace nebyla vytvořena za účelem získání zisku!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.white),
                    ),
                    Text(
                      'Aplikace by měla zjednodušit práci při fungování skautských oddílů a družin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LatestVersion extends StatelessWidget {
  final String version;
  const LatestVersion({required this.version});
  @override
  Widget build(BuildContext context) {
    return Text(
      'Nejnovější dostupná verze aplikace $version',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: Colors.white,
      ),
    );
  }
}

class UserVersion extends StatelessWidget {
  final String version;
  const UserVersion({required this.version});
  @override
  Widget build(BuildContext context) {
    return Text(
      'Vaše aktuální nainstalovaná verze $version',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: Colors.white,
      ),
    );
  }
}

class AboutAppContainer extends StatelessWidget {
  final String support;
  const AboutAppContainer({required this.support});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      width: 360,
      height: 315,
      decoration: BoxDecoration(
          color: Color.fromARGB(66, 255, 255, 255),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AboutText(header: 'Název aplikace', note: 'ScoutApp'),
            SizedBox(
              height: 10,
            ),
            AboutText(header: 'Datum vytvoření', note: '15.7.2024'),
            SizedBox(
              height: 10,
            ),
            AboutText(header: 'Vývojáři', note: 'Filip Éder, Lukáš Buriánek'),
            SizedBox(
              height: 10,
            ),
            AboutText(header: 'Podpora', note: support),
          ],
        ),
      ),
    );
  }
}

class AboutText extends StatelessWidget {
  final String header;
  final String note;
  const AboutText({required this.header, required this.note});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          note,
          style: TextStyle(
            color: Colors.white.withOpacity(0.46),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
