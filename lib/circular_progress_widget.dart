import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularProgressWidget extends StatelessWidget {
  final double consumedCalories;
  final double allCalories;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;
  final TextStyle textStyle;

  CircularProgressWidget({
    required this.consumedCalories,
    required this.allCalories,
    this.strokeWidth = 20.0,
    this.progressColor = Colors.blue,
    this.backgroundColor = Colors.grey,
    this.textStyle = const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  });

  @override
  Widget build(BuildContext context) {
    double progress = consumedCalories / allCalories * 100;
    double remainingCalories = (2200 - consumedCalories).roundToDouble();
    return CustomPaint(
      painter: CircularProgressPainter(
        progress: progress,
        strokeWidth: strokeWidth,
        progressColor: progressColor,
        backgroundColor: backgroundColor,
      ),
      child: Align(
        alignment: FractionalOffset.center,
        child: Text(
          '$remainingCalories \nОсталось',
          textAlign: TextAlign.center,
          style: textStyle,
        ),
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width, size.height) / 6- strokeWidth / 2;

    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double startAngle = 3*math.pi/4;
    double sweepAngle = 3 * math.pi / 2 * progress / 100;
    double endAngle = startAngle + sweepAngle;

    Path backgroundPath = Path()
      ..addArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        3 * math.pi / 2,
      );

    canvas.drawPath(backgroundPath, backgroundPaint);

    Path progressPath = Path()
      ..addArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
      );

    canvas.drawPath(progressPath, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}