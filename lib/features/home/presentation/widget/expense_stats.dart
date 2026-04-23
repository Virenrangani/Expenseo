import 'package:flutter/material.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/constant/string/app_string.dart';
import '../../../../core/widget/format_amount/format_amount.dart';
import 'expense_state_items.dart';
import '../../../../core/constant/colour/app_color.dart';

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
        Container(width: 3, height: 28, color: Colors.white.withOpacity(0.3)),
        StatItem(
          label: AppString.expense,
          value: '-₹${formatAmount(totalExpense)}',
          valueColor: AppColor.error,
        ),
      ],
    );
  }
}
