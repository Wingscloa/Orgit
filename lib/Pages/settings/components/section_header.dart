import 'package:flutter/material.dart';
import 'package:orgit/utils/responsive_utils.dart';

class SectionHeader extends StatelessWidget {
  final String header;

  const SectionHeader({
    super.key,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
            left: ResponsiveUtils.getPaddingHorizontal(context)),
        child: Text(
          header,
          style: TextStyle(
            color: Colors.grey.withAlpha(140),
            fontSize: ResponsiveUtils.getSubtitleFontSize(context) * 1.1,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
