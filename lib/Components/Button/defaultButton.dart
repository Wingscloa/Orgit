import 'package:flutter/material.dart';

class Defaultbutton extends StatelessWidget {
  final String text;
  final Color color;
  final Color? textColor;
  final GestureTapCallback onTap;

  const Defaultbutton(
      {super.key,
      required this.text,
      required this.color,
      required this.onTap,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 240,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 17.5,
              fontWeight: FontWeight.w900,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
