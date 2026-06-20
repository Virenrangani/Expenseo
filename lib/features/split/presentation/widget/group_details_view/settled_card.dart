import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/gap/app_gap.dart';
import '../../../../../core/constant/padding/app_padding.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';

class SettledCard extends StatelessWidget {
  const SettledCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.edgeAll16,
      decoration: BoxDecoration(
        color: AppColor.success.withAlpha(15),
        borderRadius: AppBorderRadius.cir12,
        border: Border.all(
            color: AppColor.success.withAlpha(75)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline,
              color: AppColor.success, size: 22),
          AppGap.g8,
          Text(AppString.allSettleUp,
              style: AppTextStyles.captionMedium(
                  color: AppColor.success)),
        ],
      ),
    );
  }
}