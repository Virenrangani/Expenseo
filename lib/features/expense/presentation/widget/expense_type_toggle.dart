import 'package:flutter/material.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/border_radius/app_border_radius.dart';
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
        final isExpense  = type == TransactionType.expense;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(type),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: AppPadding.edgeSymmetricVer12,
              decoration: BoxDecoration(
                color: isSelected
                    ? (isExpense
                    ? AppColor.error.withOpacity(0.1)
                    : AppColor.success.withOpacity(0.1))
                    : AppColor.background,
                borderRadius: AppBorderRadius.cir12,
                border: Border.all(
                  color: isSelected
                      ? (isExpense ? AppColor.error : AppColor.success)
                      : AppColor.divider,
                ),
              ),
              child: Text(
                type.label,
                textAlign: TextAlign.center,
                style: AppTextStyles.captionBold(
                  color: isSelected
                      ? (isExpense ? AppColor.error : AppColor.success)
                      : AppColor.textSecondary,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}