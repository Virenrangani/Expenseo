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

  const DayCard({
    super.key,
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
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(
            colors: [Color(0xFF8AB3FF), Color(0xFF6B6EF4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
          color: isActive ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          boxShadow: isActive
              ? [
            BoxShadow(
              color: const Color(0xFF6B6EF4).withAlpha(120),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: AppTextStyles.caption(
                  color: isActive
                      ? AppColor.background
                      : isDim
                      ? AppColor.background.withAlpha(80)
                      : AppColor.background.withAlpha(170),
                ),
                child: Text(letter),
              ),
              AppGap.g4,
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                  color: isActive
                      ? AppColor.background
                      : isDim
                      ? AppColor.background.withAlpha(80)
                      : AppColor.background,
                ),
                child: Text('$day'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
