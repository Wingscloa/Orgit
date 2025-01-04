import 'package:flutter/material.dart';
import 'package:my_awesome_namer/Pages/Register/WelcomeScreen.dart';
import 'package:my_awesome_namer/Pages/Register/welcome.dart';
import 'package:my_awesome_namer/Pages/Register/Login.dart';
import 'package:my_awesome_namer/Pages/Register/Register.dart';

class MainMenu extends StatefulWidget {
  final bool isRegistered = false;
  bool inRegister = false;
  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final controller = PageController(initialPage: 0);

  void _toggleRegister() {
    setState(() {
      print('Do i work');
      widget.inRegister = !widget.inRegister;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          if (!widget.isRegistered) WelcomePage(),
          widget.inRegister
              ? Register(onRegister: _toggleRegister)
              : Login(onLogin: _toggleRegister),
          if (widget.isRegistered) WelcomeScreen(),
        ],
        onPageChanged: (pageIndex) {
          print("Stránka byla změněna na index $pageIndex");
        },
      ),
    );
  }
}
