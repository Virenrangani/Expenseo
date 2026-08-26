import 'package:expenseo/core/extension/snackbar_extension.dart';
import 'package:expenseo/features/saving/domain/entity/saving_goal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/extension/localization_extension.dart';
import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/widget/elevated_button/app_elevated_button.dart';
import '../../../../core/widget/text_field/app_text_field.dart';
import '../cubit/saving_cubit.dart';

class AddSavingAlertBox extends StatefulWidget {
  final SavingGoal goal;

  const AddSavingAlertBox({super.key, required this.goal});

  @override
  State<AddSavingAlertBox> createState() => _AddSavingAlertBoxState();
}

class _AddSavingAlertBoxState extends State<AddSavingAlertBox> {
  final savingAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.addSaving),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppFormField(
            controller: savingAmountController,
            hintText: context.l10n.addAmount,
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
                text: context.l10n.cancel,
                onPressed: () {
                  context.pop(context);
                },
              ),
            ),
            AppGap.g8,
            Expanded(
              child: AppElevatedButton(
                isEnabled: true,
                text: context.l10n.save,
                onPressed: () {
                  context.read<SavingCubit>().addSavingAmount(
                    widget.goal.id,
                    double.tryParse(savingAmountController.text) ?? 0,
                  );
                  context.pop(context);
                  context.showSuccessSnackBar(context.l10n.savingAmountAdded);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
