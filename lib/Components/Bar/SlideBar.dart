import 'package:flutter/material.dart';

class SlideBar extends StatelessWidget {
  const SlideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 4,
          width: 60,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(4)),
        )
      ],
    );
  }
}
