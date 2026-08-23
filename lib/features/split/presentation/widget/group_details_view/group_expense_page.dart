import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/features/split/domain/entity/split_entity.dart';
import 'package:expenseo/features/split/presentation/widget/group_details_view/expenses_card.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';
import '../../../../../core/extension/localization_extension.dart';
import 'expense_donut_chart.dart';

class GroupExpensesPage extends StatelessWidget {
  final List<SplitEntity> expenses;

  const GroupExpensesPage({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> userTotals = {};
    double totalExpense = 0;

    for (final expense in expenses) {
      final name = expense.paidByName.split(' ').first;
      userTotals[name] = (userTotals[name] ?? 0) + expense.amount;
      totalExpense += expense.amount;
    }

    final colors = [
      Colors.blue.shade600,
      Colors.yellow.shade400,
      Colors.grey.shade900,
      Colors.teal.shade400,
      Colors.pinkAccent.shade400,
    ];

    final List<ChartData> chartDataList = [];
    var colorIndex = 0;

    for (final entry in userTotals.entries) {
      chartDataList.add(
        ChartData(entry.key, entry.value, colors[colorIndex % colors.length]),
      );
      colorIndex++;
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(context.l10n.allExpenses, style: AppTextStyles.h4()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColor.textPrimary),
      ),
      body: expenses.isEmpty
          ? Center(
              child: Text(
                context.l10n.noGroupsYet,
                style: AppTextStyles.captionBold(),
              ),
            )
          : Column(
              children: [
                GroupSplitChart(data: chartDataList, totalAmount: totalExpense),

                AppGap.g12,

                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      return ExpensesCard(expense: expenses[index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
