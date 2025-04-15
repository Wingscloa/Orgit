import 'package:flutter/material.dart';

class OrgitNavigation extends StatefulWidget {
  @override
  State<OrgitNavigation> createState() => _OrgitNavigationState();
}

class _OrgitNavigationState extends State<OrgitNavigation> {
  int currentIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentIndex = index;
        });;
      },
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      selectedIndex: currentIndex,
      indicatorColor: Color.fromARGB(255, 224, 176, 29),
      indicatorShape: CircleBorder(),
      backgroundColor: Color.fromARGB(255, 35, 35, 35),
      animationDuration: Duration(milliseconds: 400),
      height: 45,
      destinations: const <Widget>[
      NavigationDestination(icon: Icon(Icons.calendar_month_outlined, color: Color.fromARGB(255, 255, 255, 255)),  label: ""),
      NavigationDestination(icon: Icon(Icons.groups_2_outlined, color: Color.fromARGB(255, 255, 255, 255),), label: ""),
      NavigationDestination(icon: Icon(Icons.school_outlined, color: Color.fromARGB(255, 255, 255, 255),), label: ""),
      NavigationDestination(icon: Icon(Icons.list_alt_outlined, color: Color.fromARGB(255, 255, 255, 255),), label: ""),
      NavigationDestination(icon: Icon(Icons.account_box_outlined, color: Color.fromARGB(255, 255, 255, 255),), label: ""),
    ],);
  }
}

