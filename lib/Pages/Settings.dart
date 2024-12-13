import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_awesome_namer/Pages/Auth/Auth.dart';
import '../app_dimensions.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                width: 35,
              ),
              Text(
                'Nastavení',
                style: TextStyle(
                  color: Color.fromARGB(255, 107, 66, 38),
                  fontSize: AppDimensions.FontCalc * 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 75,
          ),
          Container(
            margin: EdgeInsets.only(right: 250, bottom: 10),
            child: Text(
              'OBECNÉ',
              style: TextStyle(
                color: Color.fromARGB(125, 255, 255, 255),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SelectBar(
            icon: Icons.person,
            nazev: 'Účet',
            onTap: () => {print('Ucet')},
          ),
          SizedBox(
            height: 15,
          ),
          SelectBar(
            icon: Icons.notifications,
            nazev: 'Upozornění',
            onTap: () => {print('Upozorneni')},
          ),
          SizedBox(
            height: 15,
          ),
          SelectBar(
            icon: Icons.format_paint,
            nazev: 'Motiv',
            onTap: () => {print('Motiv')},
          ),
          SizedBox(
            height: 15,
          ),
          SelectBar(
            icon: Icons.logout,
            nazev: 'Odhlásit se',
            onTap: () => {
              print('Odhlaseni'),
              _auth.signOut(),
            },
          ),
          SizedBox(
            height: 15,
          ),
          SelectBar(
            icon: Icons.delete_sharp,
            nazev: 'Smazat účet',
            onTap: () => {print('Smazat ucet')},
          ),
          SizedBox(
            height: 60,
          ),
          Container(
            margin: EdgeInsets.only(right: 200, bottom: 10),
            child: Text(
              'ZPĚTNÁ VAZBA',
              style: TextStyle(
                color: Color.fromARGB(125, 255, 255, 255),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SelectBar(
            icon: Icons.report_problem_rounded,
            nazev: 'Nahlásit chybu',
            onTap: () => {print('Nahlaseni chybu')},
          ),
          SizedBox(
            height: 15,
          ),
          SelectBar(
            icon: Icons.info,
            nazev: 'Informace o aplikaci',
            onTap: () => {print('Informace o aplikaci')},
          ),
        ],
      ),
    );
  }
}

class SelectBar extends StatelessWidget {
  final IconData icon;
  final String nazev;
  final GestureTapCallback onTap;

  SelectBar({required this.icon, required this.nazev, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 275,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      nazev,
                      style: TextStyle(
                          fontSize: AppDimensions.FontCalc,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Icon(
                  Icons.arrow_right,
                  color: Colors.white,
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              height: 1,
              width: 275,
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 107, 66, 38)),
            )
          ],
        ),
      ),
    );
  }
}
