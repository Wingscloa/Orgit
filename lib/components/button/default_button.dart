import 'package:flutter/material.dart';

class Defaultbutton extends StatelessWidget {
  final String text;
  final Color color;
  final double width;
  final double height;
  final Color? textColor;
  final GestureTapCallback onTap;

  const Defaultbutton(
      {super.key,
      required this.text,
      required this.color,
      required this.onTap,
      required this.width,
      required this.height,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
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
