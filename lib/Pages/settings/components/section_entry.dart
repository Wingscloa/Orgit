import 'package:flutter/material.dart';
import 'dart:math' as math;

class SettingEntry extends StatelessWidget {
  final IconData icon;
  final String label;
  final GestureTapCallback onTap;

  const SettingEntry({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Transform.rotate(
              angle: math.pi,
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 22,
                shadows: [
                  Shadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(-2, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
