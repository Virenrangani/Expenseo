import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/widget/text_field/app_text_field.dart';
import 'package:flutter/material.dart';

class AddSavingGoal extends StatefulWidget {
  const AddSavingGoal({super.key});

  @override
  State<AddSavingGoal> createState() => _AddSavingGoalState();
}

class _AddSavingGoalState extends State<AddSavingGoal> {
  final TextEditingController goalController = TextEditingController();
  final TextEditingController targetAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.edgeSymmetricHori24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(AppString.goal,style: AppTextStyles.caption(color: AppColor.textPrimary)),
          AppGap.g4,
          AppFormField(
            controller: goalController,
            hintText: AppString.goalHint,
            prefixIcon: const Icon(Icons.savings_outlined ,color: AppColor.textSecondary,),
            fillColor: AppColor.primaryLight.withAlpha(50),
          ),

          AppGap.g16,

          Row(
            children: [
              Text(AppString.targetAmount,style: AppTextStyles.caption(color: AppColor.textPrimary)),
              AppGap.g8,
              Expanded(
                child: AppFormField(
                  controller: targetAmountController,
                  hintText: AppString.targetAmountGoal,
                  fillColor: AppColor.primaryLight.withAlpha(50),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
