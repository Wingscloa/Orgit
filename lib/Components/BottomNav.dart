import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  // ---------------------------------------- //
  final ValueNotifier<int> selectedIndex;
  final Function(int) onItemTapped;

  BottomNav({
    required this.selectedIndex,
    required this.onItemTapped,
    super.key,
  });

  static const List<BottomNavigationBarItem> item = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "",
      backgroundColor: Colors.black,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_2),
      label: "",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.plus_one_rounded),
      label: "",
    ),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
  ];

  // ---------------------------------------- //

  @override
  Widget build(BuildContext build) {
    return BottomNavigationBar(
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: item,
      onTap: (index) {
        selectedIndex.value = index;
        onItemTapped(index);
        print("Bottom Nav index : ${selectedIndex.value}");
      },
    );
  }
}
