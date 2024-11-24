import 'package:flutter/material.dart';

class VytvareniAkce extends StatefulWidget {
  @override
  State<VytvareniAkce> createState() => _VytvareniAkce();
}

class _VytvareniAkce extends State<VytvareniAkce> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Vytvareni Akce',
          style: TextStyle(fontSize: 24, color: Colors.white)),
    );
  }
}
