import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/gap/app_gap.dart';
import '../../../../../core/constant/padding/app_padding.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';

class BalanceCard extends StatelessWidget {
  final String uid;
  final String name;
  final double amount;
  final String groupId;
  final VoidCallback onSettle;

  const BalanceCard({super.key,
    required this.uid,
    required this.name,
    required this.amount,
    required this.groupId,
    required this.onSettle,
  });

  @override
  Widget build(BuildContext context) {
    final isOwedToMe = amount > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: AppPadding.edgeAll12,
      decoration: BoxDecoration(
        color: isOwedToMe
            ? AppColor.success.withAlpha(15)
            : AppColor.error.withAlpha(15),
        borderRadius: AppBorderRadius.cir12,
        border: Border.all(
          color: isOwedToMe
              ? AppColor.success.withAlpha(75)
              : AppColor.error.withAlpha(75),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isOwedToMe
                  ? AppColor.success.withAlpha(40)
                  : AppColor.error.withAlpha(40),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                name[0].toUpperCase(),
                style: AppTextStyles.captionBold(
                  color: isOwedToMe ? AppColor.success : AppColor.error,
                ),
              ),
            ),
          ),

          AppGap.g12,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: AppTextStyles.bodySmall(
                        color: AppColor.textPrimary)
                        .copyWith(fontWeight: FontWeight.w500)),
                AppGap.g4,
                Text(
                  isOwedToMe
                      ? '${AppString.owesYou} ₹${amount.toStringAsFixed(0)}'
                      : '${AppString.owe} ₹${amount.abs().toStringAsFixed(0)}',
                  style: AppTextStyles.descriptionSmall().copyWith(
                    color: isOwedToMe ? AppColor.success : AppColor.error,
                  ),
                ),
              ],
            ),
          ),

          if (!isOwedToMe)
            GestureDetector(
              onTap: onSettle,
              child: Container(
                padding: AppPadding.edgeAll8,
                decoration: BoxDecoration(
                  color: AppColor.primary.withAlpha(25),
                  borderRadius: AppBorderRadius.cir20,
                  border: Border.all(
                    color: AppColor.primary.withAlpha(100),
                  ),
                ),
                child: Text(
                  AppString.settleUp,
                  style: AppTextStyles.captionMedium(
                    color: AppColor.secondary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}