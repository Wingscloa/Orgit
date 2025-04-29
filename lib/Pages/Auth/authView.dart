import 'package:flutter/material.dart';
import 'package:Orgit/Pages/Auth/Intro/openingIntro.dart';
import 'package:Orgit/Pages/Auth/loginForm.dart';
import 'package:Orgit/Pages/Auth/Register.dart';
import 'package:Orgit/Pages/Auth/Intro/openingIntro.dart';

class Authview extends StatefulWidget {
  final bool isRegistered = false;
  bool inRegister = false;
  @override
  State<Authview> createState() => _MainMenuState();
}

class _MainMenuState extends State<Authview> {
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
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: controller,
        children: [
          if (!widget.isRegistered) Openingintro(),
          widget.inRegister
              ? LoginForm(onLogin: _toggleRegister)
              : Register(onRegister: _toggleRegister),
          if (widget.isRegistered) Openingintro(),
        ],
        onPageChanged: (pageIndex) {
          print("Stránka byla změněna na index $pageIndex");
        },
      ),
    );
  }
}
