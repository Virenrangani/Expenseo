import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/extension/localization_extension.dart';
import 'package:expenseo/core/extension/snackbar_extension.dart';
import 'package:expenseo/core/widget/app_app_bar.dart';
import 'package:expenseo/features/split/domain/entity/split_entity.dart';
import 'package:expenseo/features/split/presentation/widget/group_details_view/expenses_card.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/pdf/pdf_export_bottom_sheet.dart';
import '../group_expense_pdf_builder.dart';
import 'expense_donut_chart.dart';

class GroupExpensesPage extends StatelessWidget {
  final String groupName;
  final List<SplitEntity> expenses;

  const GroupExpensesPage({
    super.key,
    this.groupName = 'Group Expenses',
    required this.expenses,
  });

  static const List<Color> _chartPalette = [
    Color(0xFF2563EB),
    Color(0xFFFBBF24),
    Color(0xFF0F172A),
    Color(0xFF14B8A6),
    Color(0xFFEC4899),
    Color(0xFF8B5CF6),
  ];

  void _handlePdfExport(BuildContext context) {
    if (expenses.isEmpty) {
      context.showErrorSnackBar('No expenses available to export.');
      return;
    }

    final pdfBuilder = GroupExpensePdfBuilder(
      groupName: groupName,
      expenses: expenses,
    );

    PdfExportBottomSheet.show(context, pdfBuilder);
  }

  (List<ChartData>, double) _calculateChartMetrics() {
    final Map<String, double> userTotals = {};
    double totalExpense = 0;

    for (final expense in expenses) {
      final firstName = expense.paidByName.trim().split(' ').first;
      userTotals[firstName] = (userTotals[firstName] ?? 0) + expense.amount;
      totalExpense += expense.amount;
    }

    final List<ChartData> chartDataList = [];
    var colorIndex = 0;

    for (final entry in userTotals.entries) {
      chartDataList.add(
        ChartData(
          entry.key,
          entry.value,
          _chartPalette[colorIndex % _chartPalette.length],
        ),
      );
      colorIndex++;
    }

    return (chartDataList, totalExpense);
  }

  @override
  Widget build(BuildContext context) {
    final (chartDataList, totalExpense) = _calculateChartMetrics();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppAppBar(
        title: context.l10n.allExpenses,
        actions: [
          IconButton(
            tooltip: 'Export PDF Statement',
            icon: const Icon(
              Icons.picture_as_pdf_rounded,
              color: Colors.white,
              size: 22,
            ),
            onPressed: () => _handlePdfExport(context),
          ),
        ],
      ),
      body: expenses.isEmpty
          ? _EmptyExpensesView(message: context.l10n.noGroupsYet)
          : _GroupExpensesContent(
              chartDataList: chartDataList,
              totalExpense: totalExpense,
              expenses: expenses,
            ),
    );
  }
}

class _GroupExpensesContent extends StatelessWidget {
  final List<ChartData> chartDataList;
  final double totalExpense;
  final List<SplitEntity> expenses;

  const _GroupExpensesContent({
    required this.chartDataList,
    required this.totalExpense,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppGap.g12,
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
    );
  }
}

class _EmptyExpensesView extends StatelessWidget {
  final String message;

  const _EmptyExpensesView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message, style: AppTextStyles.captionBold()));
  }
}
