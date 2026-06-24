import 'package:expenseo/features/saving/domain/entity/saving_goal.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/text_style/app_text_style.dart';

class GoalDetailAppBar extends StatelessWidget {
  final SavingGoal goal;
  final bool showDepositTitle;

  const GoalDetailAppBar({
    super.key,
    required this.showDepositTitle,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 42,
      left: 8,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: AppColor.background,
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Text(
              showDepositTitle ? 'Deposit History' : 'Goal Details',
              key: ValueKey(showDepositTitle),
              style: AppTextStyles.h4(color: AppColor.background),
            ),
          ),
        ],
      ),
    );
  }
}
