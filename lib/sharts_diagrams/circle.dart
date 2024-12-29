import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomCircularProgress extends StatefulWidget {
  final double progressValue; // A value between 0 and 1
  final Gradient progressGradient; // Gradient of the progress
  final double strokeWidth; // Stroke width for the circular progress

  const CustomCircularProgress({
    Key? key,
    required this.progressValue,
    required this.progressGradient,
    this.strokeWidth = 8.0,
  }) : super(key: key);

  @override
  _CustomCircularProgressState createState() => _CustomCircularProgressState();
}

class _CustomCircularProgressState extends State<CustomCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController with the duration of the animation
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Animation that progresses to the target progress value
    _animation = Tween<double>(begin: 0.0, end: widget.progressValue).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          width: 150, // Set width of the circular progress
          height: 150, // Set height of the circular progress
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                painter: _CircularProgressPainter(
                  progress: _animation.value,
                  progressGradient: widget.progressGradient,
                  strokeWidth: widget.strokeWidth,
                ),
                child: Container(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (_animation.value * 100).toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Gradient progressGradient;
  final double strokeWidth;

  _CircularProgressPainter({
    required this.progress,
    required this.progressGradient,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Paint for the background circle
    final Paint backgroundPaint = Paint()
      ..color = const Color.fromARGB(255, 245, 246, 249)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Paint for the progress circle
    final Rect gradientRect = Rect.fromCircle(center: center, radius: radius);
    final Paint progressPaint = Paint()
      ..shader = progressGradient.createShader(gradientRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    final double startAngle = -math.pi / 2;
    final double sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
