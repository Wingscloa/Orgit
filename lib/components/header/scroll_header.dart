import 'package:flutter/material.dart';

class Scrollheader extends StatelessWidget {
  final String text;
  final double fontSize;

  final bool isOpened;

  Scrollheader({
    required this.text,
    required this.fontSize,
    this.isOpened = false,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 7),
          child: SizedBox(
            width: 325,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: fontSize,
                  ),
                ),
                // Based on IsOpened Variable
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    isOpened ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 1,
          width: 325,
          color: Colors.grey,
        )
      ],
    );
  }
}
