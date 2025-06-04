import 'package:flutter/material.dart';

class RippleData {
  final double x;
  final double y;
  double radius;
  double opacity;
  final double maxRadius;
  final double speed;

  RippleData({
    required this.x,
    required this.y,
    this.radius = 0.0,
    this.opacity = 1.0,
    required this.maxRadius,
    required this.speed,
  });
}

class RipplePainter extends CustomPainter {
  final List<RippleData> ripples;
  final double animationValue;

  RipplePainter({required this.ripples, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (final ripple in ripples) {
      final x = ripple.x * size.width;
      final y = ripple.y * size.height;
      final currentRadius = ripple.radius * size.width;
      final progress = ripple.radius / ripple.maxRadius;
      final opacity = (1.0 - progress) * 0.6;

      paint.color = const Color(0xFFFFCB69).withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), currentRadius, paint);

      // Update ripple
      if (ripple.radius < ripple.maxRadius * size.width) {
        ripple.radius += ripple.speed * size.width;
        ripple.opacity =
            1.0 - (ripple.radius / (ripple.maxRadius * size.width));
      }
    }
  }

  @override
  bool shouldRepaint(RipplePainter oldDelegate) {
    return true; // Always repaint for smooth animation
  }
}
