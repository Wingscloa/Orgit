import 'package:flutter/material.dart';
import '../../constants.dart';

class LogInSubmit extends StatelessWidget {
  final bool register;
  final GestureTapCallback onTap;

  const LogInSubmit({
    super.key,
    required this.register,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 350, // Šířka
        height: 70, // Výška
        decoration: BoxDecoration(
          color: Color(0x26203145), // Barva s 15 % neprůhledností
          borderRadius: BorderRadius.circular(12), // Zaoblení rohů
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                register ? 'Registrovat se' : 'Přihlásit se',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
