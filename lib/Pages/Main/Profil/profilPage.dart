import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

class Profilpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Blur(
              blur: 4,
              blurColor: Color.fromARGB(255, 100, 100, 100),
              child: const Image(
                image: AssetImage('assets/map.png'),
              ),
            )
          ],
        )
      ],
    );
  }
}
