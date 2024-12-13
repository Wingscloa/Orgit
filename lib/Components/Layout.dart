import 'package:flutter/material.dart';
import 'package:my_awesome_namer/Pages/Home.dart';
// import 'Backgrounds/Background.dart';
import 'BottomNav.dart';
import '../Pages/Schuzka.dart';
import '../Pages/VytvareniAkce.dart';
import '../Pages/Profile.dart';
import '../Pages/Settings.dart';
import '../Components/Backgrounds/BckMain.dart';

// main kde se bude menit obsah
// dodelat push na jiny stranky

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    HomePage(),
    Schuzka(),
    VytvareniAkce(),
    Profile(),
    Settings()
  ];

  void _OnNavBarTapped(int index) {
    _pageController.jumpToPage(index);
  }

  void _OnPageChange(int index) {
    _currentIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MainBackground(),
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              _currentIndex.value = index;
            },
            children: _pages,
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
        selectedIndex: _currentIndex,
        onItemTapped: _OnNavBarTapped,
      ),
    );
  }
}
