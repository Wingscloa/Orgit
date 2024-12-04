import 'package:flutter/material.dart';

import '../../../constants.dart';

class SearchNav extends StatefulWidget {
  const SearchNav({
    super.key,
  });

  @override
  State<SearchNav> createState() => _SearchNavState();
}

class _SearchNavState extends State<SearchNav> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              print("Search Osoba Clicked!");
              setState(() {
                _currentIndex = 0;
              });
            },
            child: Container(
              width: 100,
              child: Text(
                "Osoba",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 107, 66, 38),
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("Search Osoba Clicked!");
              setState(() {
                _currentIndex = 1;
              });
            },
            child: Container(
              width: 100,
              child: Text(
                "Oddíl",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 107, 66, 38),
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("Search Osoba Clicked!");
              setState(() {
                _currentIndex = 2;
              });
            },
            child: Container(
              width: 100,
              child: Text(
                "Středisko",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 107, 66, 38),
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 0),
            width: 120,
            height: 2,
            color: _currentIndex == 0
                ? Colors.black
                : Color.fromARGB(120, 255, 255, 255),
          ),
          Container(
            width: 120,
            height: 2,
            color: _currentIndex == 1
                ? Colors.black
                : Color.fromARGB(120, 255, 255, 255),
          ),
          Container(
            margin: EdgeInsets.only(right: 0),
            width: 120,
            height: 2,
            color: _currentIndex == 2
                ? Colors.black
                : Color.fromARGB(120, 255, 255, 255),
          ),
        ],
      )
    ]);
  }
}
