import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:orgit/utils/responsive_utils.dart';

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
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.height * 0.07,
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
                fontSize: ResponsiveUtils.getBodyFontSize(context),
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
