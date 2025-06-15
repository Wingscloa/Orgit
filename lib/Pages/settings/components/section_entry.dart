import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:orgit/utils/responsive_utils.dart';

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
        width: MediaQuery.of(context).size.width *
            (ResponsiveUtils.isSmallScreen(context) ? 0.85 : 0.8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: ResponsiveUtils.getIconSize(context) * 0.85,
                ),
                SizedBox(
                  width: ResponsiveUtils.getSpacingMedium(context) * 0.6,
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize:
                        ResponsiveUtils.getSubtitleFontSize(context) * 1.1,
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
                size: ResponsiveUtils.isSmallScreen(context) ? 18 : 22,
                shadows: [
                  Shadow(
                    color: Colors.grey,
                    blurRadius: ResponsiveUtils.isSmallScreen(context) ? 3 : 4,
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
