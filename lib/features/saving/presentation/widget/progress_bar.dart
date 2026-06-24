import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/widget/format_amount/format_amount.dart';
import '../../domain/entity/saving_goal.dart';

class ProgressBar extends StatelessWidget {
  final SavingGoal goal;

  const ProgressBar({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    final double progress = goal.savedAmount / goal.targetAmount;
    return Padding(
      padding: AppPadding.edgeSymmetricHori12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatAmount(goal.savedAmount),
                style: AppTextStyles.captionBold(color: AppColor.background),
              ),

              Text(
                '${(progress * 100).toInt()}%',
                style: AppTextStyles.captionBold(color: AppColor.background),
              ),
            ],
          ),

          AppGap.g12,

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              backgroundColor: Colors.white.withAlpha(60),
              valueColor: const AlwaysStoppedAnimation(AppColor.background),
            ),
          ),
        ],
      ),
    );
  }
}
