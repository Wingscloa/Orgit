import 'package:flutter/material.dart';
import 'dart:math' show sin, pi;

class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage>
    with SingleTickerProviderStateMixin {
  // Colors defined as per requirements
  final Color backgroundColor =
      const Color(0xFF131416); // Dark background color

  // Animation controller for shake effect
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the shake animation controller
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Create a shake animation using a custom Tween
    _shakeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _shakeController,
        curve: Curves.easeInOut,
      ),
    );

    // Add a listener to reset the controller when animation completes
    _shakeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _shakeController.reset();
      }
    });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  // Method to trigger the shake animation
  void _triggerShake() {
    _shakeController.forward();
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
              // Panda image with shake animation
              GestureDetector(
                onTap: _triggerShake,
                child: AnimatedBuilder(
                  animation: _shakeAnimation,
                  builder: (context, child) {
                    // Apply both translation and rotation for a more dynamic effect
                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001) // perspective
                        ..translate(sin(_shakeAnimation.value * 2 * pi * 3) *
                            10) // horizontal shake
                        ..rotateZ(sin(_shakeAnimation.value * 2 * pi * 2) *
                            0.05) // slight z-axis rotation
                        ..rotateY(sin(_shakeAnimation.value * 2 * pi) *
                            0.08), // slight y-axis tilt
                      alignment: Alignment.center,
                      child: child!,
                    );
                  },
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/panda.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Error message
              Text(
                'Ups! Něco se pokazilo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Subtext
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Nebojte se, naše panda už na tom pracuje!',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
