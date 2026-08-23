import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/extension/localization_extension.dart';

class ExpenseEmptyListScreen extends StatelessWidget {
  const ExpenseEmptyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.receipt_long_outlined,
            size: 64,
            color: AppColor.divider,
          ),
          AppGap.g16,
          Text(
            context.l10n.noExpenseYet,
            style: AppTextStyles.h5(color: AppColor.textSecondary),
          ),
          AppGap.g8,
          Text(context.l10n.addFirstExpense, style: AppTextStyles.caption()),
        ],
      ),
    );
  }
}
