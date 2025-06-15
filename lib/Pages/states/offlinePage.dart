import 'package:flutter/material.dart';
import 'dart:math' as math;

class OfflinePage extends StatefulWidget {
  const OfflinePage({Key? key}) : super(key: key);

  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _wifiAnimation;
  late Animation<double> _earthAnimation;
  late Animation<double> _opacityAnimation;

  // Colors defined as per requirements
  final Color primaryColor =
      const Color.fromRGBO(255, 203, 105, 1); // Warm yellow/orange
  final Color backgroundColor =
      const Color.fromRGBO(19, 20, 22, 1); // Dark gray/black

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: false); // Animation for the wifi icon pulsing
    _wifiAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.15)
            .chain(CurveTween(curve: Curves.easeInOutSine)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.15, end: 1.15)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.15, end: 0.95)
            .chain(CurveTween(curve: Curves.easeInOutSine)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.95, end: 0.95)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.95, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOutSine)),
        weight: 20,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0),
      ),
    ); // Animation for the earth rotating
    _earthAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOutSine),
      ),
    );

    // Animation for the connection line opacity
    _opacityAnimation = Tween<double>(begin: 0.2, end: 0.7).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title text
              Text(
                'Žádné připojení',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Momentálně jste offline',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 60),

              // Animation container
              SizedBox(
                height: 250,
                width: 250,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Earth
                    Positioned(
                      bottom: 0,
                      child: AnimatedBuilder(
                        animation: _earthAnimation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _earthAnimation.value,
                            child: child,
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.blue[600]!,
                                Colors.blue[800]!,
                              ],
                              stops: const [0.4, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.4),
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Container(
                              width: 96,
                              height: 96,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CustomPaint(
                                painter: EarthPainter(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ), // Connection line (broken)
                    AnimatedBuilder(
                      animation: _wifiAnimation,
                      builder: (context, child) {
                        return CustomPaint(
                          size: const Size(200, 200),
                          painter: ConnectionLinePainter(
                            opacity: _opacityAnimation.value,
                            primaryColor: primaryColor,
                            wifiScale: _wifiAnimation
                                .value, // Pass the current scale to the painter
                          ),
                        );
                      },
                    ), // WiFi Icon
                    Positioned(
                      top: 5, // Moved 20 pixels up from previous position (25)
                      child: AnimatedBuilder(
                        animation: _wifiAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _wifiAnimation.value,
                            child: child,
                          );
                        },
                        child: Icon(
                          Icons.wifi_off_rounded,
                          size: 80,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              // Retry button
              ElevatedButton(
                onPressed: () {
                  // Add reconnection logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Attempting to reconnect...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: backgroundColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Zkusit znovu',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom painter for the Earth with accurate continent shapes
class EarthPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Ocean background
    final oceanPaint = Paint()
      ..color = Colors.blue[700]!
      ..style = PaintingStyle.fill;

    // Land paint
    final landPaint = Paint()
      ..color = Colors.green[700]!
      ..style = PaintingStyle.fill;

    // Ice caps
    final icePaint = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..style = PaintingStyle.fill;

    // Draw oceans (already drawn by parent widget, just for clarity)
    canvas.drawCircle(center, radius, oceanPaint);

    // Draw accurate continent shapes

    // North America
    final northAmerica = Path();
    northAmerica.moveTo(center.dx - radius * 0.50,
        center.dy - radius * 0.10); // Central America
    northAmerica.lineTo(
        center.dx - radius * 0.55, center.dy - radius * 0.15); // Mexico
    northAmerica.lineTo(
        center.dx - radius * 0.52, center.dy - radius * 0.22); // US West Coast
    northAmerica.lineTo(center.dx - radius * 0.42,
        center.dy - radius * 0.35); // US/Canada West Coast
    northAmerica.lineTo(
        center.dx - radius * 0.40, center.dy - radius * 0.45); // Alaska
    northAmerica.lineTo(center.dx - radius * 0.25,
        center.dy - radius * 0.45); // Northern Canada
    northAmerica.lineTo(center.dx - radius * 0.15,
        center.dy - radius * 0.38); // Greenland connection
    northAmerica.lineTo(
        center.dx - radius * 0.20, center.dy - radius * 0.25); // East Coast
    northAmerica.lineTo(
        center.dx - radius * 0.30, center.dy - radius * 0.15); // Florida/Gulf
    northAmerica.lineTo(
        center.dx - radius * 0.40, center.dy - radius * 0.10); // Gulf of Mexico
    northAmerica.close();

    // South America
    final southAmerica = Path();
    southAmerica.moveTo(
        center.dx - radius * 0.42, center.dy + radius * 0.10); // Panama
    southAmerica.lineTo(
        center.dx - radius * 0.35, center.dy + radius * 0.15); // Colombia
    southAmerica.lineTo(center.dx - radius * 0.25,
        center.dy + radius * 0.38); // Brazil East Coast
    southAmerica.lineTo(center.dx - radius * 0.30,
        center.dy + radius * 0.45); // Southern Brazil
    southAmerica.lineTo(
        center.dx - radius * 0.40, center.dy + radius * 0.40); // Argentina
    southAmerica.lineTo(
        center.dx - radius * 0.45, center.dy + radius * 0.20); // Peru/Chile
    southAmerica.close();

    // Europe
    final europe = Path();
    europe.moveTo(
        center.dx + radius * 0.05, center.dy - radius * 0.35); // Western Europe
    europe.lineTo(
        center.dx + radius * 0.15, center.dy - radius * 0.30); // Central Europe
    europe.lineTo(
        center.dx + radius * 0.20, center.dy - radius * 0.35); // Eastern Europe
    europe.lineTo(center.dx + radius * 0.18,
        center.dy - radius * 0.25); // Southern Europe
    europe.lineTo(
        center.dx + radius * 0.10, center.dy - radius * 0.20); // Mediterranean
    europe.lineTo(
        center.dx + radius * 0.00, center.dy - radius * 0.25); // Spain/Portugal
    europe.close();

    // Africa
    final africa = Path();
    africa.moveTo(
        center.dx + radius * 0.10, center.dy - radius * 0.15); // North Africa
    africa.lineTo(
        center.dx + radius * 0.25, center.dy - radius * 0.05); // Horn of Africa
    africa.lineTo(
        center.dx + radius * 0.25, center.dy + radius * 0.25); // East Africa
    africa.lineTo(
        center.dx + radius * 0.15, center.dy + radius * 0.35); // South Africa
    africa.lineTo(
        center.dx - radius * 0.05, center.dy + radius * 0.20); // West Africa
    africa.lineTo(
        center.dx - radius * 0.00, center.dy + radius * 0.00); // Central Africa
    africa.lineTo(center.dx + radius * 0.05,
        center.dy - radius * 0.10); // Northwestern Africa
    africa.close();

    // Asia
    final asia = Path();
    asia.moveTo(
        center.dx + radius * 0.20, center.dy - radius * 0.30); // Eastern Europe
    asia.lineTo(
        center.dx + radius * 0.30, center.dy - radius * 0.35); // Russia West
    asia.lineTo(
        center.dx + radius * 0.45, center.dy - radius * 0.30); // Russia East
    asia.lineTo(
        center.dx + radius * 0.50, center.dy - radius * 0.20); // East Siberia
    asia.lineTo(
        center.dx + radius * 0.55, center.dy - radius * 0.10); // East Asia
    asia.lineTo(center.dx + radius * 0.48, center.dy + radius * 0.00); // China
    asia.lineTo(
        center.dx + radius * 0.40, center.dy + radius * 0.15); // Southeast Asia
    asia.lineTo(center.dx + radius * 0.30, center.dy + radius * 0.20); // India
    asia.lineTo(
        center.dx + radius * 0.25, center.dy + radius * 0.10); // Middle East
    asia.lineTo(
        center.dx + radius * 0.20, center.dy - radius * 0.05); // Middle East
    asia.lineTo(center.dx + radius * 0.25,
        center.dy - radius * 0.15); // Middle East/Turkey
    asia.lineTo(
        center.dx + radius * 0.20, center.dy - radius * 0.25); // Eastern Europe
    asia.close();

    // Australia
    final australia = Path();
    australia.moveTo(
        center.dx + radius * 0.45, center.dy + radius * 0.30); // Northwest
    australia.lineTo(
        center.dx + radius * 0.55, center.dy + radius * 0.25); // Northeast
    australia.lineTo(
        center.dx + radius * 0.55, center.dy + radius * 0.40); // Southeast
    australia.lineTo(
        center.dx + radius * 0.45, center.dy + radius * 0.45); // Southwest
    australia.close();

    // Antarctica (south pole ice cap)
    final antarctica = Path();
    antarctica.addOval(Rect.fromCircle(
        center: Offset(center.dx, center.dy + radius * 0.75),
        radius: radius * 0.25));

    // Arctic (north pole ice cap)
    final arctic = Path();
    arctic.addOval(Rect.fromCircle(
        center: Offset(center.dx, center.dy - radius * 0.75),
        radius: radius * 0.25));

    // Island of Greenland
    final greenland = Path();
    greenland.moveTo(center.dx - radius * 0.05, center.dy - radius * 0.40);
    greenland.lineTo(center.dx + radius * 0.05, center.dy - radius * 0.35);
    greenland.lineTo(center.dx + radius * 0.00, center.dy - radius * 0.25);
    greenland.lineTo(center.dx - radius * 0.10, center.dy - radius * 0.30);
    greenland.close();

    // Draw all land masses
    canvas.drawPath(northAmerica, landPaint);
    canvas.drawPath(southAmerica, landPaint);
    canvas.drawPath(europe, landPaint);
    canvas.drawPath(africa, landPaint);
    canvas.drawPath(asia, landPaint);
    canvas.drawPath(australia, landPaint);
    canvas.drawPath(greenland, landPaint);

    // Draw ice caps
    canvas.drawPath(antarctica, icePaint);
    canvas.drawPath(arctic, icePaint);

    // Add ocean shading for 3D effect
    final oceanShading = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.transparent,
          Colors.black.withOpacity(0.3),
        ],
        stops: const [0.7, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, oceanShading);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for the broken connection line
class ConnectionLinePainter extends CustomPainter {
  final double opacity;
  final Color primaryColor;
  final double wifiScale; // Add the scale parameter

  ConnectionLinePainter({
    required this.opacity,
    required this.primaryColor,
    required this.wifiScale, // Accept the WiFi icon's current scale
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = primaryColor.withOpacity(opacity)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw multiple segments to show broken connection
    final double startY = size.height * 0.8; // Earth position
    final double centerX =
        size.width / 2; // Calculate WiFi icon position and dimensions
    // The icon is positioned at top: 5 with size 80
    final double iconTop = 5;
    final double iconSize = 80;

    // Calculate the center of the WiFi icon
    final double iconCenterY = iconTop + (iconSize / 2);

    // The bottom of the first arc is at radius (0.35 * size) below the center
    final double radius = iconSize * 0.35;
    final double arcBottomY = iconCenterY + radius;

    // Adjust for the WiFi icon's scale factor
    final double adjustedArcY = arcBottomY + ((wifiScale - 1.0) * radius);

    // Segment 1 (bottom - starts from Earth)
    canvas.drawLine(
      Offset(centerX, startY - 5), // Starting 5 pixels above Earth
      Offset(centerX, startY - size.height * 0.15),
      paint,
    );

    // Gap

    // Segment 2 (middle-bottom)
    canvas.drawLine(
      Offset(centerX, startY - size.height * 0.25),
      Offset(centerX, startY - size.height * 0.35),
      paint,
    );

    // Gap

    // Segment 3 (middle-top)
    canvas.drawLine(
      Offset(centerX, startY - size.height * 0.45),
      Offset(centerX, startY - size.height * 0.55),
      paint,
    ); // Gap

    // Segment 4 (top - connects to WiFi icon's first arc)
    // This segment will always connect to the WiFi icon's first arc regardless of scale
    canvas.drawLine(
      Offset(centerX, startY - size.height * 0.65),
      Offset(centerX, adjustedArcY),
      paint,
    );

    // Small "x" marks for broken connection
    final xPaint = Paint()
      ..color = Colors.red.withOpacity(opacity)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    void drawX(double y, double size) {
      canvas.drawLine(
        Offset(centerX - size, y - size),
        Offset(centerX + size, y + size),
        xPaint,
      );
      canvas.drawLine(
        Offset(centerX + size, y - size),
        Offset(centerX - size, y + size),
        xPaint,
      );
    }

    drawX(startY - size.height * 0.2, 5);
    drawX(startY - size.height * 0.4, 5);
  }

  @override
  bool shouldRepaint(covariant ConnectionLinePainter oldDelegate) =>
      oldDelegate.opacity != opacity || oldDelegate.wifiScale != wifiScale;
}

// Custom painter for WiFi Off icon
class WifiOffPainter extends CustomPainter {
  final Color color;

  WifiOffPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;

    // Draw the WiFi arcs
    // First (bottom) arc - this is where our line should connect
    // Note this is drawn slightly higher up to help with the connection line
    canvas.drawArc(
      Rect.fromCenter(center: center, width: radius, height: radius),
      math.pi * 0.65, // start angle in radians
      math.pi * 0.7, // sweep angle in radians
      false, // don't include center
      paint,
    );

    // Second arc (middle)
    canvas.drawArc(
      Rect.fromCenter(
          center: center, width: radius * 1.5, height: radius * 1.5),
      math.pi * 0.7, // start angle
      math.pi * 0.6, // sweep angle
      false,
      paint,
    );

    // Third arc (outer)
    canvas.drawArc(
      Rect.fromCenter(center: center, width: radius * 2, height: radius * 2),
      math.pi * 0.75, // start angle
      math.pi * 0.5, // sweep angle
      false,
      paint,
    );

    // Draw the slash through the icon (for "off" state)
    canvas.drawLine(
      Offset(center.dx - radius * 0.8, center.dy + radius * 0.8),
      Offset(center.dx + radius * 0.8, center.dy - radius * 0.8),
      paint,
    );

    // Draw the dot at the bottom
    canvas.drawCircle(
      Offset(center.dx, center.dy + radius * 0.4),
      3,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );

    // For debugging - show the connection point
    // canvas.drawCircle(
    //   Offset(center.dx, center.dy + radius),
    //   3,
    //   Paint()..color = Colors.red..style = PaintingStyle.fill
    // );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
