import 'package:flutter/material.dart';
import 'dart:math' as math;

class StarData {
  final double x;
  final double y;
  final double size;
  final double twinkleSpeed;
  final double phase;

  StarData({
    required this.x,
    required this.y,
    required this.size,
    required this.twinkleSpeed,
    required this.phase,
  });
}

class StarFieldPainter extends CustomPainter {
  final List<StarData> stars;
  final double animationValue;

  StarFieldPainter({required this.stars, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (final star in stars) {
      final x = star.x * size.width;
      final y = star.y * size.height;
      final twinkle = math.sin(
        animationValue * 2 * math.pi * star.twinkleSpeed + star.phase,
      );
      final opacity = (0.3 + 0.7 * twinkle).clamp(0.0, 1.0);
      final starSize = star.size * size.width * (0.5 + 0.5 * twinkle);

      paint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), starSize, paint);
    }
  }

  @override
  bool shouldRepaint(StarFieldPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
