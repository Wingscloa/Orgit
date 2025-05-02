import 'package:flutter/material.dart';

class ShowHeader extends StatelessWidget {
  final double width;
  final double height;
  final Color panelColor;
  final String text;
  final double textSize;
  final Color textColor;
  final double gap;
  final GestureTapCallback onTap;

  ShowHeader(
      {required this.width,
      required this.height,
      required this.panelColor,
      required this.text,
      required this.textSize,
      required this.textColor,
      required this.gap,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width / 2 - gap,
          height: height,
          color: panelColor,
        ),
        SizedBox(
          width: gap,
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: textSize,
              color: textColor,
            ),
          ),
        ),
        SizedBox(
          width: gap,
        ),
        Container(
          width: width / 2 - gap,
          height: height,
          color: panelColor,
        ),
      ],
    );
  }
}
