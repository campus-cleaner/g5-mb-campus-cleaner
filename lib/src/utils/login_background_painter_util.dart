import 'package:flutter/material.dart';

class LoginBackgroundPainterUtil extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final green = Paint()
      ..color = const Color(0xFF2A6955)
      ..style = PaintingStyle.fill;

    // Dibujar el fondo verde oscuro
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height * 1), green);

    // Dibujar los círculos
    final circlePaint = Paint()..color = const Color(0xFF59C785);

    // Círculo grande
    canvas.drawCircle(
        Offset(size.width * 0.9, size.height * 0.05), 100, circlePaint);

    // Círculo mediano
    canvas.drawCircle(
        Offset(size.width * 0.17, size.height * 0.88), 30, circlePaint);

    // Círculo pequeño
    canvas.drawCircle(
        Offset(size.width * 0.02, size.height * 0.72), 15, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
