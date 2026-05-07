import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';

void showSettleDialog({
  required BuildContext context,
  required String uid,
  required String name,
  required double amount,
}) {
  final isOwedToMe = amount > 0;
  showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.cir16),
      title: Text(AppString.settleUp, style: AppTextStyles.h5()),
      content: Text(
        isOwedToMe
            ? '$name ${AppString.owesYou} ₹${amount.toStringAsFixed(0)}.\n${AppString.markSettle}'
            : '${AppString.owe} $name ₹${amount.abs().toStringAsFixed(0)}.\n${AppString.markSettle}',
        style: AppTextStyles.bodySmall(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppString.cancel,
              style:
              AppTextStyles.captionMedium()),
        ),
        TextButton(
          onPressed: () {},
          child: Text(AppString.settled,
              style: AppTextStyles.captionMedium(
                  color: AppColor.primary)),
        ),
      ],
    ),
  );
}