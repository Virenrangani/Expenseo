import 'package:flutter/cupertino.dart';
import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/enums/app_enums.dart';
import '../../domain/entity/expense.dart';
import 'category_list_option.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final option = categoryListOption[expense.category]!;
    final isExpense = expense.type == TransactionType.expense;

    return Container(
      margin:AppPadding.edgeSymmetricVer4,
      padding: AppPadding.edgeAll12,
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: AppBorderRadius.cir16,
        border: Border.all(color: AppColor.divider.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Container(
            width:  44,
            height: 44,
            decoration: BoxDecoration(
              color: option.bgColor,
              borderRadius: AppBorderRadius.cir12,
            ),
            child: Icon(option.icon, color: option.iconColor, size: 22),
          ),

          AppGap.g12,

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.title,
                style: AppTextStyles.bodySmall(color: AppColor.textPrimary)
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              AppGap.g4,
              Row(
                children: [
                  Text(
                    expense.category.label,
                    style: AppTextStyles.descriptionSmall(),
                  ),
                  AppGap.g4,
                  Text('•',
                      style: AppTextStyles.descriptionSmall()),
                  AppGap.g4,
                  Text(
                    expense.paymentMethod.label,
                    style: AppTextStyles.descriptionSmall(),
                  ),
                ],
              ),
            ]
          )
        ),

        ],
      ),
    );
  }
}