import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/string/app_string.dart';
import '../../../../core/widget/format_amount/format_amount.dart';
import 'expense_state_items.dart';

class ExpenseStats extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;

  const ExpenseStats({
    super.key,
    required this.totalIncome,
    required this.totalExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StatItem(
          label: AppString.income,
          value: '+₹${formatAmount(totalIncome)}',
          valueColor: AppColor.secondary,
        ),
        Container(width: 3, height: 28, color: Colors.white.withAlpha(75),),
        StatItem(
          label: AppString.expense,
          value: '-₹${formatAmount(totalExpense)}',
          valueColor: AppColor.error,
        ),
      ],
    );
  }
}
