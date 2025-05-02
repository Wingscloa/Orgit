import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.only(left: 40),
        child: Text(
          header,
          style: TextStyle(
            color: Colors.grey.withAlpha(140),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
