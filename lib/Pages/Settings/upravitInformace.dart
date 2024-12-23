import 'package:flutter/material.dart';
import '../../Components/Backgrounds/BckMain.dart';

class Upravitinformace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [MainBackground()],
      ),
    );
  }
}
