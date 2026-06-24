import 'package:flutter/cupertino.dart';

class CardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double radius = 60;

    final path = Path()
      ..moveTo(radius, 0)
      ..quadraticBezierTo(size.width / 2, 10, size.width - radius, 0)
      ..quadraticBezierTo(size.width, 0, size.width, radius)
      ..lineTo(size.width, size.height - radius)
      ..quadraticBezierTo(
        size.width,
        size.height,
        size.width - radius,
        size.height,
      )
      ..quadraticBezierTo(size.width / 2, size.height - 10, radius, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - radius)
      ..lineTo(0, radius)
      ..quadraticBezierTo(0, 0, radius, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
