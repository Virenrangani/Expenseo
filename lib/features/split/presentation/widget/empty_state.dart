import 'dart:math' as math;

import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/image/app_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';

class FloatingAvatar {
  final double orbitRadius;
  final double angle;
  final double size;
  final Color bgColor;
  final String imagePath;

  FloatingAvatar({
    required this.orbitRadius,
    required this.angle,
    required this.size,
    required this.bgColor,
    required this.imagePath,
  });
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    const innerOrbitRadius = 90.0;
    const outerOrbitRadius = 150.0;
    const widgetSize = 350.0;

    final avatars = <FloatingAvatar>[
      FloatingAvatar(
        orbitRadius: innerOrbitRadius,
        angle: math.pi * 1.25,
        size: 50,
        bgColor: Colors.pink.shade100,
        imagePath: AppImage.A,
      ),
      FloatingAvatar(
        orbitRadius: innerOrbitRadius,
        angle: math.pi * 1.9,
        size: 56,
        bgColor: Colors.lightBlue.shade100,
        imagePath: AppImage.B,
      ),

      FloatingAvatar(
        orbitRadius: outerOrbitRadius,
        angle: math.pi * 0.2,
        size: 64,
        bgColor: Colors.indigo.shade100,
        imagePath: AppImage.C,
      ),
      FloatingAvatar(
        orbitRadius: outerOrbitRadius,
        angle: math.pi * 0.8,
        size: 44,
        bgColor: Colors.pink.shade100,
        imagePath: AppImage.D,
      ),
      FloatingAvatar(
        orbitRadius: outerOrbitRadius,
        angle: math.pi * 1.1,
        size: 70,
        bgColor: Colors.amber.shade100,
        imagePath: AppImage.E,
      ),
      FloatingAvatar(
        orbitRadius: outerOrbitRadius,
        angle: math.pi * 1.6,
        size: 75,
        bgColor: Colors.teal.shade100,
        imagePath: AppImage.F,
      ),
      FloatingAvatar(
        orbitRadius: innerOrbitRadius,
        angle: math.pi * 2.6,
        size: 65,
        bgColor: Colors.greenAccent,
        imagePath: AppImage.G,
      ),
    ];

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: widgetSize,
            height: widgetSize,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                CustomPaint(
                  size: const Size(widgetSize, widgetSize),
                  painter: _OrbitPainter(
                    innerRadius: innerOrbitRadius,
                    outerRadius: outerOrbitRadius,
                  ),
                ),

                const Icon(Icons.add, size: 36, color: AppColor.divider),
                ...avatars.map(
                  (avatar) => _buildPositionedAvatar(widgetSize, avatar),
                ),
              ],
            ),
          ),

          AppGap.g32,

          Text(
            'No groups yet',
            style: AppTextStyles.h4().copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPositionedAvatar(double widgetSize, FloatingAvatar avatar) {
    final double center = widgetSize / 2;

    final double x = center + avatar.orbitRadius * math.cos(avatar.angle);
    final double y = center + avatar.orbitRadius * math.sin(avatar.angle);

    return Positioned(
      left: x - (avatar.size / 2),
      top: y - (avatar.size / 2),
      child: Container(
        width: avatar.size,
        height: avatar.size,
        decoration: BoxDecoration(
          color: avatar.bgColor,
          shape: BoxShape.circle,
        ),
        child: Center(child: Image.asset(avatar.imagePath)),
      ),
    );
  }
}

class _OrbitPainter extends CustomPainter {
  final double innerRadius;
  final double outerRadius;

  _OrbitPainter({required this.innerRadius, required this.outerRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final outerPaint = Paint()
      ..color = AppColor.primary.withAlpha(30)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(center, outerRadius, outerPaint);

    final innerPaint = Paint()
      ..color = AppColor.primary.withAlpha(40)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    _drawDashedCircle(canvas, center, innerRadius, innerPaint);
  }

  void _drawDashedCircle(
    Canvas canvas,
    Offset center,
    double radius,
    Paint paint,
  ) {
    const dashWidth = 6.0;
    const dashSpace = 6.0;

    final double circumference = 2 * math.pi * radius;
    final int dashCount = (circumference / (dashWidth + dashSpace)).floor();

    final double dashAngle = (dashWidth / circumference) * 2 * math.pi;
    final double spaceAngle = (dashSpace / circumference) * 2 * math.pi;

    double currentAngle = 0;

    for (var i = 0; i < dashCount; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        dashAngle,
        false,
        paint,
      );
      currentAngle += dashAngle + spaceAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
