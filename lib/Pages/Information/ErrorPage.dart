import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1B1D), // Pozadí - tmavá barva
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 100,
              color: Color(0xFFFFCB69), // Sekundární barva - světle žlutá
            ),
            SizedBox(height: 20),
            Text(
              'Došlo k chybě!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFCB69), // Sekundární barva - světle žlutá
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Omlouváme se, něco se pokazilo.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(180, 255, 255, 255),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Můžeš přidat funkci pro návrat nebo restart aplikace
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 255, 203, 105),
                  backgroundColor: Color.fromARGB(
                      255, 19, 20, 22) // Tlačítko s sekundární barvou
                  ),
              child: Text(
                'Zkuste to znovu',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 203, 105),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
