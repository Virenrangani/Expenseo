import 'package:flutter/material.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/constant/string/app_string.dart';
import 'package:expenseo/features/home/presentation/widget/expense_container.dart';

class TabSelector extends StatelessWidget {
  final ExpenseTab selectedTab;
  final ValueChanged<ExpenseTab> onTabChanged;

  const TabSelector({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: AppBorderRadius.cir28,
      ),
      padding: AppPadding.edgeAll4,
      child: Row(
        children: ExpenseTab.values.map((tab) {
          final isActive = selectedTab == tab;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(tab),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: AppPadding.edgeSymmetricVer8,
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColor.backgroundLight
                      : Colors.transparent,
                  borderRadius: AppBorderRadius.cir24,
                ),
                child: Text(
                  tabLabel(tab),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption(
                    color: isActive
                        ? AppColor.background
                        : AppColor.textLight,
                  ).copyWith(
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w300,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String tabLabel(ExpenseTab tab) {
    switch (tab) {
      case ExpenseTab.balance: return AppString.balance;
      case ExpenseTab.income:  return AppString.income;
      case ExpenseTab.expense: return AppString.expense;
    }
  }
}