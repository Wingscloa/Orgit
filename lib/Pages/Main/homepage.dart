import 'package:flutter/material.dart';
import 'package:Orgit/Pages/Main/Calendar/calendarPage.dart';
import 'package:Orgit/Pages/Main/Event/eventPage.dart';
import 'package:Orgit/Pages/Main/Group/groupPage.dart';
import 'package:Orgit/Pages/Main/Profil/profilPage.dart';
import 'package:Orgit/Pages/Main/TodoList/todolistPage.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:Orgit/statics.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _pageController = new PageController();
  int _selectedIndex = 0;
  static double marginItem = 35;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Statics.background,
      bottomNavigationBar: Container(
        height: 55,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
          color: Color.fromARGB(255, 35, 35, 35),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 35,
            ),
            InkWell(
              onTap: () => onTapItem(0),
              child: Icon(
                Icons.calendar_month,
                color: Colors.white,
                size: 40,
              ),
            ),
            SizedBox(
              width: marginItem,
            ),
            InkWell(
              onTap: () => onTapItem(1),
              child: Icon(
                Icons.calendar_month,
                color: Colors.white,
                size: 40,
              ),
            ),
            SizedBox(
              width: marginItem,
            ),
            InkWell(
              onTap: () => onTapItem(2),
              child: Icon(
                Icons.calendar_month,
                color: Colors.white,
                size: 40,
              ),
            ),
            SizedBox(
              width: marginItem,
            ),
            InkWell(
              onTap: () => onTapItem(3),
              child: Icon(
                Icons.calendar_month,
                color: Colors.white,
                size: 40,
              ),
            ),
            SizedBox(
              width: marginItem,
            ),
            InkWell(
              onTap: () => onTapItem(4),
              child: Icon(
                Icons.calendar_month,
                color: Colors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            children: <Widget>[
              Calendarpage(),
              Eventpage(),
              Grouppage(),
              Todolistpage(),
              Profilpage(),
            ],
            onPageChanged: (page) {
              setState(() {
                _selectedIndex = page;
              });
            },
          ),
        ],
      ),
    );
  }

  void onTapItem(int value) {
    setState(() {
      _selectedIndex = value;
    });
    _pageController.jumpToPage(
      value,
    );
  }
}
