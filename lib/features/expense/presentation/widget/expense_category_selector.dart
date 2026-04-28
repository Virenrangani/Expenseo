import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/enums/app_enums.dart';
import './category_list_option.dart';

class ExpenseCategorySelector extends StatelessWidget {
  final ExpenseCategory selectedCategory;
  final ValueChanged<ExpenseCategory> onChanged;

  const ExpenseCategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 94,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: ExpenseCategory.values.map((cat) {
          final option = categoryListOption[cat]!;
          final isSelected = selectedCategory == cat;
          return GestureDetector(
            onTap: () => onChanged(cat),
            child: AnimatedContainer(
              duration:  const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right:8),
              padding:AppPadding.edgeSymmetricHori16,
              decoration: BoxDecoration(
                borderRadius: AppBorderRadius.cir16,
                border: Border.all(
                  color: isSelected ? AppColor.primary : AppColor.divider,
                  width: isSelected ? 1.5 : 0.5,
                ),
                color: isSelected
                    ? AppColor.primary.withAlpha(15)
                    : AppColor.background,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width:  30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: option.bgColor,
                      borderRadius: AppBorderRadius.cir8,
                    ),
                    child: Icon(option.icon, color: option.iconColor, size: 16),
                  ),
                  AppGap.g4,
                  Text(
                    cat.label,
                    style: AppTextStyles.captionMedium(
                      color: isSelected ? AppColor.secondary : AppColor.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}