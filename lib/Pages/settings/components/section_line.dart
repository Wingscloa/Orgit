import 'package:flutter/material.dart';

class SectionLine extends StatelessWidget {
  final double pTop;
  final double pBot;
  const SectionLine({
    super.key,
    this.pTop = 15,
    this.pBot = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: pTop, bottom: pBot),
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
