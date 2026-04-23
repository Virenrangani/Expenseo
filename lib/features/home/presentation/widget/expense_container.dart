import 'package:flutter/material.dart';
import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/string/app_string.dart';
import '../../../../core/constant/text_style/app_text_style.dart';

class ExpenseContainer extends StatelessWidget {
  const ExpenseContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: AppBorderRadius.cir16,
          color: AppColor.primary
      ),
      child: Column(
        children: [
          AppGap.g16,
          Text("My Expense", style: AppTextStyles.bodyLarge()),
          AppGap.g8,
          Text(
            "\$ 23455",
            style: AppTextStyles.h3(color: AppColor.background),
          ),
          AppGap.g16,
        ],
      ),
    );
  }
}
