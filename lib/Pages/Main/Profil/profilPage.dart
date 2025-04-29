import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

class Profilpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Blur(
          blur: 4,
          blurColor: Color.fromARGB(255, 100, 100, 100),
          child: const Image(
            image: AssetImage('assets/map.png'),
          ),
        ),
        Column(
          children: [
            // < profil [settings]
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  Text(
                    "Profil",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            // profile
            Center(
              // profile
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  border: Border.all(
                    color: Color.fromARGB(255, 224, 176, 29),
                  ),
                ),
                height: 140,
                width: 140,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/profile.png"),
                  backgroundColor: Color.fromARGB(255, 53, 54, 55),
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            // prezdivka
            Text(
              "Víčko",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 36,
                letterSpacing: 4,
              ),
            ),
            SizedBox(
              height: 2.5,
            ),
            // cele jmeno
            Text(
              "Šimon Bumba",
              style: TextStyle(
                color: Color.fromARGB(255, 170, 140, 80),
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 3.5,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            // menu
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 36, 37, 39),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 33),
                  child: Column(
                    spacing: 33,
                    children: [
                      profilPageButton(
                        icon: Icons.edit,
                        label: "upravit profil",
                        onTap: () => {print("mam upravit profil")},
                      ),
                      profilPageButton(
                        onTap: () => {
                          print("mam ukazat todolist"),
                        },
                        label: "todo list",
                        icon: Icons.checklist,
                      ),
                      profilPageButton(
                        onTap: () => {
                          print("mam spravovat dochazku"),
                        },
                        label: "docházka",
                        icon: Icons.person_pin_rounded,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class profilPageButton extends StatelessWidget {
  const profilPageButton({
    required this.onTap,
    required this.label,
    required this.icon,
    super.key,
  });

  final GestureTapCallback onTap;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: 240,
          height: 55,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(255),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 4),
              )
            ],
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 26, 27, 29),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  textAlign: TextAlign.center,
                  label.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
