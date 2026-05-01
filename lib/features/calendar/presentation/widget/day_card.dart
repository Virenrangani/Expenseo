import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:flutter/material.dart';

class DayCard extends StatelessWidget {


  final int day;
  final String letter;
  final bool isActive;
  final bool isDim;
  final VoidCallback onTap;

  const DayCard({super.key,
    required this.day,
    required this.letter,
    required this.isActive,
    required this.isDim,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF6B6EF4) : Colors.transparent,
          borderRadius: AppBorderRadius.cir20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              letter,
              style: AppTextStyles.caption(color: isActive
              ? AppColor.background
                  : isDim
              ? AppColor.background.withAlpha(75)
                : AppColor.background.withAlpha(150),)
            ),
            AppGap.g8,
            Text(
              '$day',
              style: TextStyle(
                fontSize: 15,
                fontWeight:
                isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive
                    ? AppColor.background
                    : isDim
                    ? AppColor.background.withAlpha(75)
                    : AppColor.background,
              ),
            ),
          ],
        ),
      ),
    );
  }
}