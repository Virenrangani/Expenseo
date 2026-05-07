import 'package:flutter/material.dart';

import '../../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/gap/app_gap.dart';
import '../../../../../core/constant/padding/app_padding.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';
import '../../../domain/entity/split_entity.dart';

class ExpensesCard extends StatelessWidget {

  final SplitEntity expense;

  const ExpensesCard({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin:  const EdgeInsets.only(bottom: 8),
      padding: AppPadding.edgeAll12,
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: AppBorderRadius.cir12,
        border: Border.all(color: AppColor.divider.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width:  40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColor.primaryLight,
                  borderRadius: AppBorderRadius.cir12,
                ),
                child: const Icon(Icons.receipt_outlined,
                    color: AppColor.secondary, size: 20),
              ),

              AppGap.g12,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(expense.title,
                        style: AppTextStyles.bodySmall(
                            color: AppColor.textPrimary)
                            .copyWith(fontWeight: FontWeight.w500)),
                    AppGap.g4,
                    Text(
                      'Paid by ${expense.paidByName}',
                      style: AppTextStyles.descriptionSmall(),
                    ),
                  ],
                ),
              ),

              Text(
                '₹${expense.amount.toStringAsFixed(0)}',
                style: AppTextStyles.captionBold(
                    color: AppColor.textPrimary),
              ),
            ],
          ),

          AppGap.g8,

          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: expense.splitAmong.entries.map((entry) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color:  AppColor.primaryLight,
                  borderRadius: AppBorderRadius.cir8,
                ),
                child: Text(
                  '₹${entry.value.toStringAsFixed(0)}',
                  style: AppTextStyles.descriptionSmall()
                      .copyWith(color: AppColor.secondary),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}