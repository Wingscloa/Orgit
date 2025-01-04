import 'package:flutter/material.dart';

class BottomDots extends StatelessWidget {
  final int currentIndex;
  final int totalDots;

  BottomDots({required this.currentIndex, required this.totalDots});

  Widget _buildDot(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == index
            ? Color.fromARGB(255, 255, 201, 100)
            : Color.fromARGB(50, 205, 156, 32),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalDots, _buildDot),
    );
  }
}
