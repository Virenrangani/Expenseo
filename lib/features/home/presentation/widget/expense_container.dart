import 'package:flutter/material.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/padding/app_padding.dart';
import 'package:expenseo/features/home/presentation/widget/tab_selector.dart';
import '../../../../core/constant/gap/app_gap.dart';
import 'package:expenseo/features/home/presentation/widget/show_amount.dart';
import 'package:expenseo/features/home/presentation/widget/expense_stats.dart';

enum ExpenseTab { balance, income, expense }

class ExpenseContainer extends StatefulWidget {
  const ExpenseContainer({super.key});

  @override
  State<ExpenseContainer> createState() => _ExpenseContainerState();
}

class _ExpenseContainerState extends State<ExpenseContainer> {
  ExpenseTab _selectedTab = ExpenseTab.balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.primary,
      ),
      padding: AppPadding.edgeAll12,
      child: Column(
        children: [
          TabSelector(
            selectedTab: _selectedTab,
            onTabChanged: (tab) => setState(() => _selectedTab = tab),
          ),
          AppGap.g24,
        ],
      ),
    );
  }
}