import 'dart:math' as math;

import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/extension/localization_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/text_style/app_text_style.dart';
import '../../../../../core/widget/format_amount/format_amount.dart';

class ChartData {
  final String name;
  final double amount;
  final Color color;

  ChartData(this.name, this.amount, this.color);
}

class GroupSplitChart extends StatelessWidget {
  final List<ChartData> data;
  final double totalAmount;

  const GroupSplitChart({
    super.key,
    required this.data,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    const chartSize = 220.0;
    const strokeWidth = 22.0;
    const avatarSize = 44.0;

    return SizedBox(
      width: chartSize,
      height: chartSize,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(context.l10n.total, style: AppTextStyles.captionMedium()),
              AppGap.g4,
              Text(formatAmount(totalAmount), style: AppTextStyles.h3()),
            ],
          ),

          CustomPaint(
            size: const Size(chartSize, chartSize),
            painter: _DonutPainter(
              data: data,
              totalAmount: totalAmount,
              strokeWidth: strokeWidth,
            ),
          ),

          ..._buildAvatars(chartSize, strokeWidth, avatarSize),
        ],
      ),
    );
  }

  List<Widget> _buildAvatars(
    double chartSize,
    double strokeWidth,
    double avatarSize,
  ) {
    final List<Widget> avatars = [];

    double currentAngle = -math.pi / 2;

    final double radius = (chartSize - strokeWidth) / 2;

    final center = Offset(chartSize / 2, chartSize / 2);

    for (final item in data) {
      final double sweepAngle = (item.amount / totalAmount) * 2 * math.pi;

      final double x = center.dx + radius * math.cos(currentAngle);
      final double y = center.dy + radius * math.sin(currentAngle);

      avatars.add(
        Positioned(
          left: x - (avatarSize / 2),
          top: y - (avatarSize / 2),
          child: Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: item.color,
              border: Border.all(color: AppColor.background, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(40),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                item.name[0].toUpperCase(),
                style: AppTextStyles.captionBold(color: AppColor.background),
              ),
            ),
          ),
        ),
      );

      currentAngle += sweepAngle;
    }

    return avatars;
  }
}

class _DonutPainter extends CustomPainter {
  final List<ChartData> data;
  final double totalAmount;
  final double strokeWidth;

  _DonutPainter({
    required this.data,
    required this.totalAmount,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    double startAngle = -math.pi / 2;

    const gapAngle = 0.08;

    for (final item in data) {
      final double sweepAngle = (item.amount / totalAmount) * 2 * math.pi;

      final paint = Paint()
        ..color = item.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        rect,
        startAngle + (gapAngle / 2),
        sweepAngle - gapAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
