import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/enums/app_enums.dart';

class PaymentMethodSelector extends StatelessWidget {
  final PaymentMethod selectedMethod;
  final ValueChanged<PaymentMethod> onChanged;

  const PaymentMethodSelector({
    super.key,
    required this.selectedMethod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: PaymentMethod.values.map((method) {
        final isSelected = selectedMethod == method;
        debugPrint('PaymentMethod values: ${PaymentMethod.values}');
        return GestureDetector(
          onTap: () => onChanged(method),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 180),
            padding:  AppPadding.edgeSymmetricHori16,
            decoration: BoxDecoration(
              borderRadius: AppBorderRadius.cir12,
              border: Border.all(
                color: isSelected ? AppColor.primary : AppColor.divider,
                width: isSelected ? 1.5 : 0.5,
              ),
              color: isSelected
                  ? AppColor.primary.withOpacity(0.07)
                  : AppColor.background,
            ),
            child: Text(
              method.label,
              style: AppTextStyles.captionMedium(
                color: isSelected ? AppColor.secondary : AppColor.textSecondary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}