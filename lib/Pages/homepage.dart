import 'package:flutter/material.dart';
import 'package:orgit/pages/Calendar/calendar_page.dart';
import 'package:orgit/pages/Event/event_page.dart';
import 'package:orgit/pages/Group/group_page.dart';
import 'package:orgit/pages/profil/profil_page.dart';
import 'package:orgit/pages/Todo/todo_page.dart';
import 'package:orgit/global_vars.dart';

class Homepage extends StatefulWidget {
  final int initPage;

  Homepage({required this.initPage});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _pageController = PageController();
  int selectedIndex = 0;
  static double marginItem = 35;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.background,
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
              // v navbaru
              Calendarpage(),
              Eventpage(),
              Grouppage(),
              Todolistpage(),
              Profilpage(),
            ],
            onPageChanged: (page) {
              setState(() {
                selectedIndex = page;
              });
            },
          ),
        ],
      ),
    );
  }

  void onTapItem(int value) {
    setState(() {
      selectedIndex = value;
    });
    _pageController.jumpToPage(
      value,
    );
  }
}
