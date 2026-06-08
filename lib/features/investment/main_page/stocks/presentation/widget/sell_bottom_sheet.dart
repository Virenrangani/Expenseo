import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constant/colour/app_color.dart';
import '../../../../../../core/constant/gap/app_gap.dart';
import '../../../../../../core/constant/text_style/app_text_style.dart';
import '../../../../../../core/widget/elevated_button/app_elevated_button.dart';
import '../../../../../../core/widget/text_field/app_text_field.dart';

class SellBottomSheet extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onConfirm;

  const SellBottomSheet({
    super.key,
    required this.controller,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.edgeAll16,
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.verTop24,
        color: AppColor.background,
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppString.updateSellPrice, style: AppTextStyles.description()),

          AppGap.g12,

          AppFormField(
            prefixIcon: const Icon(
              Icons.currency_rupee_rounded,
              color: AppColor.primaryLight,
            ),
            hintText: AppString.sellingPrice,
            fillColor: AppColor.primaryLight.withAlpha(35),
          ),

          AppGap.g16,
          Row(
            children: [
              Expanded(
                child: AppElevatedButton(
                  text: AppString.confirm,
                  onPressed: onConfirm,
                ),
              ),

              AppGap.g12,

              Expanded(
                child: AppElevatedButton(
                  text: AppString.cancel,
                  onPressed: () => Navigator.pop(context),
                  color: AppColor.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
