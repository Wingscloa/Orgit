import 'package:flutter/material.dart';

class Schuzka extends StatefulWidget {
  @override
  State<Schuzka> createState() => _VytvareniAkce();
}

class _VytvareniAkce extends State<Schuzka> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Schůzka',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          )),
    );
  }
}
