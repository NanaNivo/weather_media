import 'package:flutter/cupertino.dart';

class DrawCircle extends CustomPainter {
 late Paint _paint;
 late double radius;

  DrawCircle({required Color color,required double strokeWidth,required double radius, PaintingStyle style = PaintingStyle.fill}) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = style;
    this.radius = radius;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(const Offset(0.0, 0.0), radius, _paint);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}