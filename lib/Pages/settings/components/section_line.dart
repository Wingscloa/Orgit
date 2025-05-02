import 'package:flutter/material.dart';

class SectionLine extends StatelessWidget {
  final double p_top;
  final double p_bot;
  const SectionLine({
    super.key,
    this.p_top = 15,
    this.p_bot = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: p_top, bottom: p_bot),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 0.5,
        decoration: BoxDecoration(
          color: Colors.grey.withAlpha(125),
        ),
      ),
    );
  }
}
