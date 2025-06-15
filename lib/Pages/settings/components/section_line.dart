import 'package:flutter/material.dart';
import 'package:orgit/utils/responsive_utils.dart';

class SectionLine extends StatelessWidget {
  final double? pTop;
  final double? pBot;
  const SectionLine({
    super.key,
    this.pTop,
    this.pBot,
  });

  @override
  Widget build(BuildContext context) {
    // Použití responzivních hodnot nebo defaultní hodnoty
    final topPadding = pTop ?? ResponsiveUtils.getSpacingSmall(context) * 1.5;
    final bottomPadding =
        pBot ?? ResponsiveUtils.getSpacingSmall(context) * 1.5;

    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: ResponsiveUtils.isSmallScreen(context) ? 0.3 : 0.5,
        decoration: BoxDecoration(
          color: Colors.grey.withAlpha(125),
        ),
      ),
    );
  }
}
