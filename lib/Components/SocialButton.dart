import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final Color color;
  final Brand brand;
  final VoidCallback onPressed;

  SocialButton({
    required this.text,
    required this.color,
    required this.brand,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 140,
        height: 70,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            brand,
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
