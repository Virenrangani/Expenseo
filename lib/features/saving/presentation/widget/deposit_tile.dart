import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/widget/date_label/date_label.dart';
import 'package:expenseo/features/saving/domain/entity/deposit.dart';
import 'package:flutter/material.dart';

class DepositTile extends StatelessWidget {
  final Deposit deposit;

  const DepositTile({
    super.key,
    required this.deposit,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppBorderRadius.cir12,
      child: Container(
        padding: AppPadding.edgeAll12,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: AppColor.primaryLight,
          borderRadius: AppBorderRadius.cir12,
          border: Border.all(color: AppColor.primary, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              padding: AppPadding.edgeAll12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(40),
              ),
              child: const Icon(
                Icons.monetization_on_outlined,
                color: AppColor.background,
                size: 28,
              ),
            ),

            AppGap.g16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '₹${deposit.amount}',
                    style: AppTextStyles.h5(color: AppColor.background),
                  ),

                  AppGap.g4,

                  Text(
                    dateLabel(deposit.createdAt),
                    style: AppTextStyles.description(
                      color: AppColor.background.withAlpha(225),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
