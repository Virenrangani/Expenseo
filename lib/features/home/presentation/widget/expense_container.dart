import 'package:expenseo/features/home/presentation/widget/tab_selector.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import 'package:expenseo/features/home/presentation/widget/show_amount.dart';

enum ExpenseTab { balance, income, expense }

class ExpenseContainer extends StatefulWidget {
  const ExpenseContainer({super.key});

  @override
  State<ExpenseContainer> createState() => _ExpenseContainerState();
}

class _ExpenseContainerState extends State<ExpenseContainer> {
  ExpenseTab _selectedTab = ExpenseTab.balance;
  bool isHidden = false;

  final double totalIncome = 50000;
  final double totalExpense = 23250;
  double get balance => totalIncome - totalExpense;

  String get displayLabel {
    switch (_selectedTab) {
      case ExpenseTab.balance: return 'My Balance';
      case ExpenseTab.income:  return 'Total Income';
      case ExpenseTab.expense: return 'Total Expense';
    }
  }

  double get displayAmount {
    switch (_selectedTab) {
      case ExpenseTab.balance: return balance;
      case ExpenseTab.income:  return totalIncome;
      case ExpenseTab.expense: return totalExpense;
    }
  }

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
          ShowAmount(
            displayLabel: displayLabel,
            displayAmount: displayAmount,
            isHidden: isHidden,
            selectedTab: _selectedTab,
            onToggleHide: () => setState(() =>isHidden = !isHidden),
          ),

        ],
      ),
    );
  }
}