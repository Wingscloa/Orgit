class BubbleData {
  double x;
  double y;
  final double originalX;
  final double originalY;
  double targetX;
  double targetY;
  final double size;
  final double speed;
  final double opacity;
  final double phase;
  final double direction;
  bool isInteracting;
  final double pulseSpeed;

  BubbleData({
    required this.x,
    required this.y,
    required this.originalX,
    required this.originalY,
    required this.targetX,
    required this.targetY,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.phase,
    required this.direction,
    required this.isInteracting,
    required this.pulseSpeed,
  });
}
