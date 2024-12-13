import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainBackground extends StatefulWidget {
  @override
  State<MainBackground> createState() => _MainBackgroundState();
}

class _MainBackgroundState extends State<MainBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height, // Výška obrazovky
      decoration: BoxDecoration(
        color: Color(0xFFFFF1AD), // Světle žluté pozadí
      ),
      child: Stack(
        children: [
          // Čtvercové pozadí s gradientem
          Center(
            child: ClipPath(
              clipper: MountainClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF6B4226), // Začátek gradientu
                      Color(0xFFB37F4F), // Konec gradientu
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Vytváření masky pro hory
class MountainClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.26);
    path.lineTo(size.width * 0.44, size.height * 0.2);
    path.lineTo(size.width * 0.63, size.height * 0.2);
    path.lineTo(size.width * 0.76, size.height * 0.16);
    path.lineTo(size.width * 0.89, size.height * 0.16);
    path.lineTo(size.width, size.height * 0.21);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.35);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
