import 'package:flutter/material.dart';

class Eventpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color darkBackground = Color(0xFF131416);
    final Color softGold = Color(0xFFDDBC84);

    return Scaffold(
      backgroundColor: darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'AKCE',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: softGold.withOpacity(0.85),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 260,
                      height: 260,
                      child: Image.asset(
                        'assets/panda.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text(
                        "Panda na tom bambusově maká!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          color: softGold.withOpacity(0.9),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "Občas si dá pauzu na šlofíka...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontStyle: FontStyle.italic,
                          color: softGold.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
