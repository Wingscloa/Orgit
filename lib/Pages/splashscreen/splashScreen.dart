import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:orgit/Pages/splashscreen/data/bubble.dart';
import 'package:orgit/Pages/splashscreen/data/star.dart';
import 'package:orgit/Pages/splashscreen/data/ripple.dart';

class SplashScreen extends StatefulWidget {
  final Duration duration;
  final VoidCallback onFinish;

  const SplashScreen({
    Key? key,
    this.duration = const Duration(seconds: 3),
    required this.onFinish,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeInController;
  late AnimationController _assemblyController;
  late AnimationController _bubbleController;
  late AnimationController _backgroundController;
  late AnimationController _rippleController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _bubbleAnimation;
  late Animation<double> _backgroundAnimation;
  late Animation<double> _rippleAnimation;

  final List<BubbleData> _bubbles = [];
  final List<StarData> _stars = [];
  final List<RippleData> _ripples = [];
  final int _bubbleCount = 25;
  final int _starCount = 100;
  Offset? _fingerPosition;

  static const Color primaryColor = Color(0xFFFFCB69); // ffcb69
  static const Color backgroundColor = Color(0xFF131416); // 131416

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeBubbles();
    _initializeStars();
    _startSplashSequence();
  }

  void _initializeAnimations() {
    _fadeInController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _assemblyController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _bubbleController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeInController, curve: Curves.easeInOut),
    );
    _bubbleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _bubbleController, curve: Curves.linear));

    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _backgroundController, curve: Curves.linear),
    );

    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );
  }

  void _initializeBubbles() {
    final random = math.Random();
    for (int i = 0; i < _bubbleCount; i++) {
      final x = random.nextDouble();
      final y = random.nextDouble();
      _bubbles.add(
        BubbleData(
          x: x,
          y: y,
          originalX: x,
          originalY: y,
          targetX: x,
          targetY: y,
          size: random.nextDouble() * 0.04 + 0.01,
          speed: random.nextDouble() * 0.02 + 0.005,
          opacity: random.nextDouble() * 0.5 + 0.15,
          phase: random.nextDouble() * 2 * math.pi,
          direction: random.nextDouble() * 2 * math.pi,
          isInteracting: false,
          pulseSpeed: random.nextDouble() * 0.8 + 0.2,
        ),
      );
    }
  }

  void _initializeStars() {
    final random = math.Random();
    for (int i = 0; i < _starCount; i++) {
      _stars.add(
        StarData(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: random.nextDouble() * 0.008 + 0.002,
          twinkleSpeed: random.nextDouble() * 2.0 + 0.5,
          phase: random.nextDouble() * 2 * math.pi,
        ),
      );
    }
  }

  void _addRipple(Offset position) {
    final screenSize = MediaQuery.of(context).size;
    _ripples.add(
      RippleData(
        x: position.dx / screenSize.width,
        y: position.dy / screenSize.height,
        maxRadius: 0.3,
        speed: 0.005,
      ),
    );
    _rippleController.reset();
    _rippleController.forward();
  }

  void _startSplashSequence() {
    _fadeInController.forward();
    _backgroundController.repeat();
    _bubbleController.repeat();
    _assemblyController.forward();

    Future.delayed(widget.duration, () {
      _assemblyController.animateBack(1).whenComplete(() {
        widget.onFinish();
      });
    });
  }

  @override
  void dispose() {
    _fadeInController.stop();
    _assemblyController.stop();
    _bubbleController.stop();
    _backgroundController.stop();
    _rippleController.stop();
    _fadeInController.dispose();
    _assemblyController.dispose();
    _bubbleController.dispose();
    _backgroundController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _fingerPosition = details.localPosition;
          });
          _updateBubbleTargets();
        },
        onPanEnd: (details) {
          setState(() {
            _fingerPosition = null;
          });
          _resetBubbleTargets();
        },
        onTapDown: (details) {
          setState(() {
            _fingerPosition = details.localPosition;
          });
          _updateBubbleTargets();
          _addRipple(details.localPosition);
        },
        onTapUp: (details) {
          setState(() {
            _fingerPosition = null;
          });
          _resetBubbleTargets();
        },
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _fadeInAnimation,
            _assemblyController,
            _bubbleAnimation,
            _backgroundAnimation,
            _rippleAnimation,
          ]),
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _buildDynamicGradient(constraints),
                      _buildStars(constraints),
                      ..._buildBubbles(),
                      _buildRipples(constraints),
                      Positioned.fill(
                        child: Center(
                          child: FadeTransition(
                            opacity: _fadeInAnimation,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildAssemblyText(),
                                const SizedBox(height: 40),
                                _buildEnhancedLoadingIndicator(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildAssemblyText() {
    const letters = ['O', 'R', 'G', 'I', 'T'];

    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: letters.asMap().entries.map((entry) {
            return _buildSpecial3DLetter(entry.value, entry.key);
          }).toList(),
        ),
        _buildTextParticles(),
      ],
    );
  }

  Widget _buildSpecial3DLetter(String letter, int index) {
    final delay = index * 0.15;
    final endDelay = math.min(1.0, 0.6 + delay);

    final letterAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _assemblyController,
        curve: Interval(delay, endDelay, curve: Curves.elasticOut),
      ),
    );

    final rotationAnimation = Tween<double>(begin: -math.pi, end: 0.0).animate(
      CurvedAnimation(
        parent: _assemblyController,
        curve: Interval(delay, endDelay, curve: Curves.easeOutBack),
      ),
    );

    return AnimatedBuilder(
      animation: letterAnimation,
      builder: (context, child) {
        final progress = letterAnimation.value;
        final isFromLeft = index < 2; // O, R from left
        final isFromRight = index > 2; // I, T from right

        final maxOffset = MediaQuery.of(context).size.width * 0.4;
        double currentOffset = 0;

        if (isFromLeft) {
          currentOffset = -maxOffset * (1 - progress);
        } else if (isFromRight) {
          currentOffset = maxOffset * (1 - progress);
        }

        final scale = Tween<double>(begin: 0.3, end: 1.0)
            .animate(
              CurvedAnimation(
                parent: _assemblyController,
                curve: Interval(delay, endDelay, curve: Curves.elasticOut),
              ),
            )
            .value;

        final rotationY = rotationAnimation.value +
            math.sin(_backgroundAnimation.value * 2 * math.pi + index) * 0.1;

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Perspective
              ..translate(currentOffset, math.sin(progress * math.pi) * -20)
              ..rotateY(rotationY)
              ..scale(scale),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 3D depth layers (back to front)
                for (int i = 5; i > 0; i--)
                  Transform.translate(
                    offset: Offset(i * 1.5, i * 1.5),
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w900,
                        color: Colors.black.withOpacity(0.1 * i),
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                // Middle layer (colored)
                Transform.translate(
                  offset: Offset(1, 1),
                  child: Text(
                    letter,
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w900,
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.7),
                      letterSpacing: 3,
                    ),
                  ),
                ),
                // Top layer (bright)
                Text(
                  letter,
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 3,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 0),
                        blurRadius: 20,
                        color: primaryColor,
                      ),
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 8,
                        color: const Color.fromARGB(255, 133, 105, 26)
                            .withOpacity(0.8),
                      ),
                      Shadow(
                        offset: Offset(-1, -1),
                        blurRadius: 4,
                        color: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                // Metallic shine effect
                if (progress > 0.7)
                  ClipRect(
                    child: AnimatedBuilder(
                      animation: _backgroundAnimation,
                      builder: (context, child) {
                        final shinePosition =
                            (_backgroundAnimation.value + index * 0.2) % 1.0;
                        return Transform.translate(
                          offset: Offset(shinePosition * 60 - 30, 0),
                          child: Container(
                            width: 10,
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.transparent,
                                  const Color.fromARGB(255, 255, 255, 255)
                                      .withOpacity(0.2),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextParticles() {
    return AnimatedBuilder(
      animation: _assemblyController,
      builder: (context, child) {
        if (_assemblyController.value < 0.8) return Container();

        return Stack(
          children: List.generate(8, (index) {
            final angle = (index / 15) * 2 * math.pi;
            final radius = 150.0;
            final particleAnimation =
                (_backgroundAnimation.value + index * 0.1) % 1.0;

            final x =
                math.cos(angle + particleAnimation * 2 * math.pi) * radius;
            final y = math.sin(angle + particleAnimation * 2 * math.pi) *
                radius *
                0.2;

            return Transform.translate(
              offset: Offset(x, y),
              child: Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(
                    math.sin(particleAnimation * math.pi) * 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.5),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  List<Widget> _buildBubbles() {
    return _bubbles.map((bubble) {
      return _buildBubble(bubble);
    }).toList();
  }

  Widget _buildBubble(BubbleData bubble) {
    final screenSize = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _bubbleAnimation,
      builder: (context, child) {
        final currentX = _lerpDouble(bubble.x, bubble.targetX, 0.05);
        final currentY = _lerpDouble(bubble.y, bubble.targetY, 0.05);

        bubble.x = currentX;
        bubble.y = currentY;

        final pulseValue =
            math.sin(_bubbleAnimation.value * 2 * math.pi * bubble.pulseSpeed) *
                    0.2 +
                1.0;
        final currentSize = bubble.size * pulseValue;

        if (!bubble.isInteracting) {
          final floatX = math.sin(
                _bubbleAnimation.value * 2 * math.pi * bubble.speed +
                    bubble.phase,
              ) *
              0.02;
          final floatY = math.cos(
                _bubbleAnimation.value * 2 * math.pi * bubble.speed * 0.7 +
                    bubble.phase,
              ) *
              0.02;

          bubble.x = (bubble.originalX + floatX).clamp(0.0, 1.0);
          bubble.y = (bubble.originalY + floatY).clamp(0.0, 1.0);
        }

        return Positioned(
          left: bubble.x * screenSize.width,
          top: bubble.y * screenSize.height,
          child: Container(
            width: currentSize * screenSize.width,
            height: currentSize * screenSize.width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor.withOpacity(bubble.opacity.clamp(0.0, 1.0)),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _updateBubbleTargets() {
    if (_fingerPosition == null) return;

    final screenSize = MediaQuery.of(context).size;
    final fingerX = _fingerPosition!.dx / screenSize.width;
    final fingerY = _fingerPosition!.dy / screenSize.height;

    for (final bubble in _bubbles) {
      final distance = math.sqrt(
        math.pow(bubble.x - fingerX, 2) + math.pow(bubble.y - fingerY, 2),
      );

      if (distance < 0.3) {
        bubble.isInteracting = true;
        // Magnetic effect - bubbles are attracted to finger
        final attractionStrength = (0.3 - distance) / 0.3;
        bubble.targetX = _lerpDouble(
          bubble.x,
          fingerX,
          attractionStrength * 0.3,
        );
        bubble.targetY = _lerpDouble(
          bubble.y,
          fingerY,
          attractionStrength * 0.3,
        );
      }
    }
  }

  void _resetBubbleTargets() {
    for (final bubble in _bubbles) {
      bubble.isInteracting = false;
      bubble.targetX = bubble.originalX;
      bubble.targetY = bubble.originalY;
    }
  }

  Widget _buildStars(BoxConstraints constraints) {
    return Positioned.fill(
      child: SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: CustomPaint(
          painter: StarFieldPainter(
            stars: _stars,
            animationValue: _backgroundAnimation.value,
          ),
        ),
      ),
    );
  }

  Widget _buildRipples(BoxConstraints constraints) {
    return Positioned.fill(
      child: SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: CustomPaint(
          painter: RipplePainter(
            ripples: _ripples,
            animationValue: _rippleAnimation.value,
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedLoadingIndicator() {
    return Column(
      children: [
        Container(
          width: 200,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.grey.withOpacity(0.3),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: LinearGradient(
                    colors: [
                      primaryColor.withOpacity(0.5),
                      primaryColor,
                      primaryColor.withOpacity(0.3),
                    ],
                    stops: [0.0, _fadeInAnimation.value, 1.0],
                  ),
                ),
                width: 300 * _fadeInAnimation.value,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        AnimatedBuilder(
          animation: _bubbleAnimation,
          builder: (context, child) {
            final pulseValue =
                math.sin(_bubbleAnimation.value * 2 * math.pi * 3) * 0.3 + 0.7;
            return Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(pulseValue),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.4),
                    blurRadius: 8 +
                        4 * math.sin(_bubbleAnimation.value * 2 * math.pi * 2),
                    spreadRadius: 2,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDynamicGradient(BoxConstraints constraints) {
    return Positioned.fill(
      child: SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: AnimatedBuilder(
          animation: _backgroundAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(
                    math.sin(_backgroundAnimation.value * 2 * math.pi * 0.5) *
                        0.3,
                    math.cos(_backgroundAnimation.value * 2 * math.pi * 0.3) *
                        0.3,
                  ),
                  radius: 1.5,
                  colors: [
                    const Color.fromARGB(255, 21, 23, 27).withOpacity(0.8),
                    const Color.fromARGB(255, 18, 19, 19).withOpacity(0.9),
                    const Color.fromARGB(255, 88, 67, 39),
                  ],
                  stops: [0.0, 0.7, 1.0],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  double _lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }
}
