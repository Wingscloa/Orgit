import 'package:flutter/material.dart';
import 'package:orgit/global_vars.dart';

class OverlayHeader extends StatelessWidget {
  final String label;
  final GestureTapCallback? onTap;
  const OverlayHeader({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
        ),
        Text(
          label,
          style: Global.defaultStyle(28, true),
        ),
      ],
    );
  }
}
