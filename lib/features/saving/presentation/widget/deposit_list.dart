import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/features/saving/domain/entity/saving_goal.dart';
import 'package:expenseo/features/saving/presentation/widget/deposit_tile.dart';
import 'package:expenseo/features/saving/presentation/widget/showing_goal_data.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/text_style/app_text_style.dart';
import '../../domain/entity/deposit.dart';

class DepositList extends StatelessWidget {
  final List<Deposit> deposits;
  final SavingGoal goal;

  const DepositList({super.key, required this.deposits, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShowingGoalData(goal: goal),
        AppGap.g20,
        Padding(
          padding: AppPadding.edgeSymmetricHori16,
          child: Text('Deposit History', style: AppTextStyles.caption()),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: deposits.length,
            itemBuilder: (context, index) {
              final deposit = deposits[index];
              return DepositTile(deposit: deposit);
            },
          ),
        ),
      ],
    );
  }
}
