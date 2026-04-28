import 'package:expenseo/features/home/presentation/widget/expense_container.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/widget/format_amount/format_amount.dart';

class ShowAmount extends StatelessWidget {
  final String displayLabel;
  final double displayAmount;
  final bool isHidden;
  final ExpenseTab selectedTab;
  final VoidCallback onToggleHide;

  const ShowAmount({
    super.key,
    required this.displayLabel,
    required this.displayAmount,
    required this.isHidden,
    required this.selectedTab,
    required this.onToggleHide,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          displayLabel,
          style: AppTextStyles.caption(
            color: Colors.white.withAlpha(200),
          ),
        ),
        AppGap.g4,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: Text(
                isHidden
                    ? '₹ •••••'
                    : '₹ ${formatAmount(displayAmount)}',
                key: ValueKey('$isHidden$selectedTab'),
                style: AppTextStyles.h2(
                  color: AppColor.background,
                )
              ),
            ),
            AppGap.g12,
            GestureDetector(
              onTap: onToggleHide,
              child: Opacity(
                opacity: 0.75,
                child: Icon(
                  isHidden
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColor.background,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
