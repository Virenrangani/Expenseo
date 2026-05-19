import 'package:flutter/material.dart';

import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/enums/app_enums.dart';

class ExpenseTypeToggle extends StatelessWidget {
  final TransactionType selectedType;
  final ValueChanged<TransactionType> onChanged;

  const ExpenseTypeToggle({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: TransactionType.values.map((type) {
        final isSelected = selectedType == type;
        final isExpense = type == TransactionType.expense;
        final activeColor =
        isExpense ? AppColor.error : AppColor.success;
        final icon =
        isExpense ? Icons.arrow_upward : Icons.arrow_downward;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GestureDetector(
              onTap: () => onChanged(type),

              child: AnimatedScale(
                duration: const Duration(milliseconds: 180),
                scale: isSelected ? 1.03 : 1,

                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  padding: AppPadding.edgeSymmetricVer12,

                  decoration: BoxDecoration(
                    borderRadius: AppBorderRadius.cir16,

                    gradient: isSelected ? LinearGradient(
                      colors: [
                        activeColor.withAlpha(35),
                        activeColor.withAlpha(10),
                      ],
                    ) : null,

                    color: isSelected ? null : AppColor.background,
                    border: Border.all(
                      color: isSelected
                          ? activeColor
                          : AppColor.divider.withAlpha(120),
                      width: isSelected ? 2 : 1,
                    ),

                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: activeColor.withAlpha(40),
                          blurRadius: 16,
                          spreadRadius: 1,
                          offset: const Offset(0, 4),
                        ),
                    ],
                  ),

                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),

                    child: Row(
                      key: ValueKey(isSelected),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        AnimatedRotation(
                          turns: isSelected ? 1 : 0,
                          duration: const Duration(milliseconds: 400),
                          child: Icon(icon, size: 18,
                            color: isSelected ? activeColor
                                : AppColor.textSecondary,
                          ),
                        ),

                        AppGap.g8,

                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          style: AppTextStyles.captionBold(
                            color: isSelected
                                ? activeColor
                                : AppColor.textSecondary,
                          ),
                          child: Text(type.label),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}