import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Image.network(
                          'https://via.placeholder.com/200',
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 350,
                  width: 325,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(100, 255, 241, 173)),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 50),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(),
                                Text(
                                  'Filip Mesiáš Éder',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '3. oddíl vodních skautů Děčín',
                                  style: TextStyle(
                                    color: Color.fromARGB(125, 0, 1, 19),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildIconButton(Icons.group, 'Hledat'),
                                  buildIconButton(Icons.group, 'Oddíl'),
                                  buildIconButton(Icons.checklist, 'To Do'),
                                  buildIconButton(Icons.event, 'Akce'),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildIconButton(Icons.map, 'Stezka'),
                                  buildIconButton(Icons.sports, 'Slingo'),
                                  buildIconButton(
                                      Icons.family_restroom, 'Rodiče'),
                                  buildIconButton(Icons.edit, 'Upravit'),
                                ],
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget buildIconButton(IconData icon, String label) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 7.5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 107, 66, 38),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
      SizedBox(height: 8),
      Text(
        label,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 12,
        ),
      ),
    ],
  );
}
