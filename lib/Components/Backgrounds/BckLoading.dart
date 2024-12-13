import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingBackground extends StatefulWidget {
  @override
  State<LoadingBackground> createState() => _LoadingBackgroundState();
}

class _LoadingBackgroundState extends State<LoadingBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height, // Výška obrazovky
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF6B4226), // Začátek gradientu
            Color(0xFFB37F4F), // Konec gradientu
          ],
        ),
      ),
      child: Stack(
        children: [
          // Uprostřed bude logo
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Kruh
                      color: Colors.white, // Barva pozadí loga
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/logo.png'), // Zde přidejte cestu k vašemu logu
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          // Zápatí s názvem aplikace
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Be Scout',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Barva textu
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
