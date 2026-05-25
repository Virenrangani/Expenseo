import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/widget/elevated_button/app_elevated_button.dart';
import 'package:expenseo/core/widget/text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/saving_cubit.dart';

class AddSavingGoal extends StatefulWidget {
  const AddSavingGoal({super.key});

  @override
  State<AddSavingGoal> createState() => _AddSavingGoalState();
}

class _AddSavingGoalState extends State<AddSavingGoal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController goalController = TextEditingController();
  final TextEditingController targetAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.edgeSymmetricHori24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              AppString.newSavingGoal,
              style: AppTextStyles.h5(),
            ),
          ),

          Text(AppString.goal,style: AppTextStyles.caption(color: AppColor.textPrimary)),
          AppGap.g4,
          AppFormField(
            controller: goalController,
            hintText: AppString.goalHint,
            prefixIcon: const Icon(Icons.savings_outlined ,color: AppColor.textSecondary,),
            fillColor: AppColor.primaryLight.withAlpha(50),
            validator:  (v) => v!.trim().isEmpty ? 'Title is required' : null,
          ),

          AppGap.g20,

          Row(
            children: [
              Text(AppString.targetAmount,style: AppTextStyles.caption(color: AppColor.textPrimary)),
              AppGap.g8,
              Expanded(
                child: AppFormField(
                  controller: targetAmountController,
                  hintText: AppString.targetAmountGoal,
                  prefixText: '₹ ',
                  fillColor: AppColor.primaryLight.withAlpha(50),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textAction: TextInputAction.done,
                ),
              ),
            ],
          ),

          AppGap.g20,

          AppElevatedButton(
              text: AppString.addGoal,
              onPressed: onSubmit,
            isEnabled: true,
          )
        ],
      ),
    );
  }
  void onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<SavingCubit>().createGoal(
      goal: goalController.text.trim(),
      targetAmount: double.parse(targetAmountController.text.trim()),
    );
  }
}
