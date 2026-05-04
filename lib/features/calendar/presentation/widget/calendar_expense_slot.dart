import 'package:flutter/cupertino.dart';

import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/enums/app_enums.dart';
import '../../../../core/widget/format_amount/format_amount.dart';
import '../../../expense/domain/entity/expense.dart';
import '../../../expense/presentation/widget/category_list_option.dart';

class CalendarExpenseSlot extends StatelessWidget {
  final String hourLabel;
  final List<Expense> expenses;
  const CalendarExpenseSlot({super.key, required this.hourLabel, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: expenses.map((expense) {
        final option = categoryListOption[expense.category]!;
        final isExpense = expense.type == TransactionType.expense;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: AppPadding.edgeAll4,
          decoration: BoxDecoration(
            color: option.bgColor,
            borderRadius: AppBorderRadius.cir12,
            border: Border.all(color: option.bgColor),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: option.bgColor,
                  borderRadius: AppBorderRadius.cir8,
                ),
                child: Icon(option.icon, color: option.iconColor, size: 16),
              ),
              AppGap.g8,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.title,
                      style: AppTextStyles.captionBold(color: AppColor.textSecondary),
                    ),
                    Text(
                      expense.category.label,
                      style: AppTextStyles.descriptionSmall(),
                    ),
                  ],
                ),
              ),

              Text(
                '${isExpense ? '-' : '+'}₹${formatAmount(expense.amount)}',
                style: AppTextStyles.captionMedium(
                  color: isExpense ? AppColor.error : AppColor.success,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
