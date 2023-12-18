
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class HomeIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromRGBO(15, 31, 129, 1.0)
      ..style = PaintingStyle.fill
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final path = Path()
    ..moveTo(size.width * 0.0,size.height * 0.6)
    ..lineTo(size.width * 0.5,size.height * 0.0)
    ..lineTo(size.width * 1.0,size.height * 0.6)
    ..lineTo(size.width * 0.85,size.height * 0.6)
    ..lineTo(size.width * 0.85,size.height * 1.0)
    ..lineTo(size.width * 0.6,size.height * 1.0)
    ..lineTo(size.width * 0.6,size.height * 0.6)
    ..lineTo(size.width * 0.4,size.height * 0.6)
    ..lineTo(size.width * 0.4,size.height * 1.0)
    ..lineTo(size.width * 0.15,size.height * 1.0)
    ..lineTo(size.width * 0.15,size.height * 0.6)
    ..lineTo(size.width * 0.0,size.height * 0.6)
    ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CustomersIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromRGBO(15, 31, 129, 1.0)
      ..style = PaintingStyle.fill
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final path1 = Path()
      ..moveTo(size.width * 0.25,size.height * 1.0)
      ..lineTo(size.width * 0.75,size.height * 1.0)
      ..arcToPoint(Offset(size.width * 0.65, size.height * 0.75), radius: Radius.circular(9), clockwise: false)
      ..arcToPoint(Offset(size.width * 0.35, size.height * 0.75), radius: Radius.circular(16), clockwise: true)
      ..arcToPoint(Offset(size.width * 0.25, size.height * 1.0), radius: Radius.circular(9), clockwise: false)
      ..close();

    final path2 = Path()
      ..moveTo(size.width * 0.0,size.height * 0.9)
      ..lineTo(size.width * 0.0,size.height * 0.8)
      ..arcToPoint(Offset(size.width * 0.1, size.height * 0.7), radius: Radius.circular(5), clockwise: true)
      ..lineTo(size.width * 0.2,size.height * 0.7)
      ..arcToPoint(Offset(size.width * 0.26, size.height * 0.76), radius: Radius.circular(5), clockwise: true)
      ..arcToPoint(Offset(size.width * 0.19, size.height * 0.9), radius: Radius.circular(9), clockwise: false)
      ..close();

    final path3 = Path()
      ..moveTo(size.width * 1.0,size.height * 0.9)
      ..lineTo(size.width * 1.0,size.height * 0.8)
      ..arcToPoint(Offset(size.width * 0.9, size.height * 0.7), radius: Radius.circular(5), clockwise: false)
      ..lineTo(size.width * 0.8,size.height * 0.7)
      ..arcToPoint(Offset(size.width * 0.73, size.height * 0.76), radius: Radius.circular(5), clockwise: false)
      ..arcToPoint(Offset(size.width * 0.8, size.height * 0.9), radius: Radius.circular(9), clockwise: true)
      ..close();

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
    canvas.drawPath(path3, paint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.56), 8.0, paint);
    canvas.drawCircle(Offset(size.width * 0.15, size.height * 0.56), 5.0, paint);
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.56), 5.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ProductIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.0), Offset(size.width * 1.0, size.height * 0.3), paint);
    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.0), Offset(size.width * 0.0, size.height * 0.3), paint);
    canvas.drawLine(Offset(size.width * 0.0, size.height * 0.3), Offset(size.width * 0.5, size.height * 0.6), paint);
    canvas.drawLine(Offset(size.width * 1.0, size.height * 0.3), Offset(size.width * 0.5, size.height * 0.6), paint);
    canvas.drawLine(Offset(size.width * 0.25, size.height * 0.15), Offset(size.width * 0.75, size.height * 0.45), paint);
    canvas.drawLine(Offset(size.width * 0.0, size.height * 0.3), Offset(size.width * 0.0, size.height * 0.75), paint);
    canvas.drawLine(Offset(size.width * 1.0, size.height * 0.3), Offset(size.width * 1.0, size.height * 0.75), paint);
    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.6), Offset(size.width * 0.5, size.height * 1.0), paint);
    canvas.drawLine(Offset(size.width * 0.0, size.height * 0.75), Offset(size.width * 0.5, size.height * 1.0), paint);
    canvas.drawLine(Offset(size.width * 1.0, size.height * 0.75), Offset(size.width * 0.5, size.height * 1.0), paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class NewOrderIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromRGBO(15, 31, 129, 1.0)
      ..style = PaintingStyle.fill
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.1), Offset(size.width * 0.0, size.height * 0.1), paint);
    canvas.drawLine(Offset(size.width * 0.0, size.height * 0.1), Offset(size.width * 0.0, size.height * 1.0), paint);
    canvas.drawLine(Offset(size.width * 0.0, size.height * 1.0), Offset(size.width * 0.9, size.height * 1.0), paint);
    canvas.drawLine(Offset(size.width * 0.9, size.height * 1.0), Offset(size.width * 0.9, size.height * 0.5), paint);
    canvas.drawLine(Offset(size.width * 0.6, size.height * 0.2), Offset(size.width * 1.0, size.height * 0.2), paint);
    canvas.drawLine(Offset(size.width * 0.8, size.height * 0.0), Offset(size.width * 0.8, size.height * 0.4), paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ReturnOrderIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromRGBO(15, 31, 129, 1.0)
      ..style = PaintingStyle.fill
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(size.width * 1.0, size.height * 0.0), Offset(size.width * 0.0, size.height * 0.0), paint);
    canvas.drawLine(Offset(size.width * 0.0, size.height * 0.0), Offset(size.width * 0.0, size.height * 1.0), paint);
    canvas.drawLine(Offset(size.width * 0.0, size.height * 1.0), Offset(size.width * 1.0, size.height * 1.0), paint);
    canvas.drawLine(Offset(size.width * 1.0, size.height * 1.0), Offset(size.width * 1.0, size.height * 0.0), paint);
    canvas.drawLine(Offset(size.width * 0.75, size.height * 0.25), Offset(size.width * 0.75, size.height * 0.6), paint);
    canvas.drawLine(Offset(size.width * 0.75, size.height * 0.6), Offset(size.width * 0.25, size.height * 0.6), paint);
    canvas.drawLine(Offset(size.width * 0.25, size.height * 0.6), Offset(size.width * 0.4, size.height * 0.4), paint);
    canvas.drawLine(Offset(size.width * 0.25, size.height * 0.6), Offset(size.width * 0.4, size.height * 0.8), paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PaymentIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromRGBO(15, 31, 129, 1.0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final path1 = Path()
    ..moveTo(size.width * 0.0, size.height * 0.2)
    ..lineTo(size.width * 0.0, size.height * 0.5)
    ..arcToPoint(Offset(size.width * 0.9, size.height * 0.5), radius: Radius.circular(40), clockwise: false)
    ..lineTo(size.width * 0.9, size.height * 0.2);

    final path2 = Path()
    ..moveTo(size.width * 0.0, size.height * 0.5)
    ..lineTo(size.width * 0.0, size.height * 0.8)
    ..arcToPoint(Offset(size.width * 0.9, size.height * 0.8), radius: Radius.circular(40), clockwise: false)
    ..lineTo(size.width * 0.9, size.height * 0.5);

    canvas.drawOval(Rect.fromPoints(
        Offset(size.width * 0.0, size.height * 0.0),
        Offset(size.width * 0.9, size.height * 0.3),
    ), paint);
    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


















