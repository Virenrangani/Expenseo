import 'package:expenseo/features/saving/domain/entity/saving_goal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/string/app_string.dart';
import '../../../../core/widget/elevated_button/app_elevated_button.dart';
import '../../../../core/widget/snack_bar/custom_snack_bar.dart';
import '../../../../core/widget/text_field/app_text_field.dart';
import '../cubit/saving_cubit.dart';

class AddSavingAlertBox extends StatelessWidget {
  final SavingGoal goal;

  const AddSavingAlertBox({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    final savingAmountController = TextEditingController();

    return AlertDialog(
      title: const Text(AppString.addSaving),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppFormField(
            controller: savingAmountController,
            hintText: AppString.addAmount,
            prefixText: '₹ ',
            fillColor: AppColor.primaryLight.withAlpha(50),
          ),
        ],
      ),

      actions: [
        Row(
          children: [
            Expanded(
              child: AppElevatedButton(
                isEnabled: true,
                color: AppColor.error.withAlpha(100),
                text: AppString.cancel,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            AppGap.g8,
            Expanded(
              child: AppElevatedButton(
                isEnabled: true,
                text: AppString.save,
                onPressed: () {
                  context.read<SavingCubit>().addSavingAmount(
                    goal.id,
                    double.tryParse(savingAmountController.text) ?? 0,
                  );
                  Navigator.pop(context);

                  CustomSnacksBar.showSuccess(
                    context,
                    AppString.savingAmountAdded,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
