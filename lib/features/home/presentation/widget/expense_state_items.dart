import 'package:flutter/material.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';

class StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const StatItem({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            label,
            style: AppTextStyles.caption(
              color: AppColor.textLight,
            )
        ),
        AppGap.g4,
        Text(
            value,
            style: AppTextStyles.captionBold(
              color: valueColor,
            )
        ),
      ],
    );
  }
}