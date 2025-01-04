import 'package:flutter/material.dart';

class MenuBckg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 19, 20, 22),
      ),
    );
  }
}
