import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/features/home/presentation/widget/show_amount.dart';
import 'package:expenseo/features/home/presentation/widget/tab_selector.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';

enum ExpenseTab { balance, income, expense }

class ExpenseContainer extends StatefulWidget {
  final double totalIncome;
  final double totalExpense;
  const ExpenseContainer({super.key, required this.totalIncome, required this.totalExpense});

  @override
  State<ExpenseContainer> createState() => _ExpenseContainerState();
}

class _ExpenseContainerState extends State<ExpenseContainer> {
  ExpenseTab _selectedTab = ExpenseTab.balance;
  bool isHidden = false;

   late final double totalIncome;
   late final double totalExpense ;
  double get balance => totalIncome - totalExpense;

  @override
  void initState() {
    super.initState();
    totalIncome=widget.totalIncome;
    totalExpense=widget.totalExpense;
  }

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