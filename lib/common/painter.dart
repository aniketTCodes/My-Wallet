import 'package:flutter/material.dart';

const color1 = Color.fromARGB(255, 191, 6, 74);
const color2 = Color.fromARGB(255, 140, 8, 118);
const color3 = Color.fromARGB(255, 112, 11, 140);
const color4 = Color.fromARGB(255, 89, 15, 191);

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromPoints(Offset.zero, Offset(size.width, size.height));
    LinearGradient gradient = const LinearGradient(
        colors: [color1, color2, color3, color4],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft);

    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
