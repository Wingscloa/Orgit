import 'package:flutter/material.dart';
import 'package:orgit/components/icons/icon.dart';
import 'package:orgit/utils/geometry_clippers.dart';

class RoleIcon extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? function;
  final bool? choosen;
  const RoleIcon({
    this.width = 42,
    this.height = 42,
    required this.color,
    required this.icon,
    required this.iconColor,
    this.function,
    this.choosen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: ClipPath(
        clipper: HexagonClipper(),
        child: Container(
          decoration: BoxDecoration(
              color: choosen == true ? color.withAlpha(100) : color),
          width: width,
          height: height,
          child: Icon(
            icon,
            color: choosen == true ? iconColor.withAlpha(100) : iconColor,
          ),
        ),
      ),
    );
  }
}
