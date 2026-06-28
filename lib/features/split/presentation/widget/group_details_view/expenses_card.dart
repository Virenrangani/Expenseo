import 'package:flutter/material.dart';

import '../../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/gap/app_gap.dart';
import '../../../../../core/constant/padding/app_padding.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';
import '../../../domain/entity/split_entity.dart';

class ExpensesCard extends StatelessWidget {
  final SplitEntity expense;
  final VoidCallback? onTap;

  const ExpensesCard({super.key, required this.expense, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: AppBorderRadius.cir16,
        boxShadow: [
          BoxShadow(
            color: AppColor.textPrimary.withAlpha(15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: AppPadding.edgeAll12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColor.primary.withAlpha(15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.receipt_long_rounded,
                      color: AppColor.primary,
                      size: 22,
                    ),
                  ),
                  AppGap.g16,

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expense.title,
                          style: AppTextStyles.titleMedium(
                            color: AppColor.textPrimary,
                          ).copyWith(fontWeight: FontWeight.w700),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Paid by ${expense.paidByName}',
                          style: AppTextStyles.captionMedium(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  Text(
                    '₹${expense.amount.toStringAsFixed(0)}',
                    style: AppTextStyles.h4().copyWith(
                      color: AppColor.textPrimary,
                    ),
                  ),
                ],
              ),

              Divider(color: Colors.grey.shade200),

              Row(
                children: [
                  Icon(
                    Icons.pie_chart_outline,
                    size: 14,
                    color: Colors.grey.shade400,
                  ),
                  AppGap.g4,
                  Text(
                    'Split breakdown',
                    style: AppTextStyles.descriptionSmall().copyWith(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
              AppGap.g8,

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: expense.splitAmong.entries.map((entry) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: AppBorderRadius.cir8,
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(
                      '₹${entry.value.toStringAsFixed(0)}',
                      style: AppTextStyles.captionBold(),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
