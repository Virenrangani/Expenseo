import 'package:flutter/material.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/widget/date_label/date_label.dart';
import '../../domain/entity/expense.dart';
import '../widget/expense_card.dart';
import '../widget/expense_empty_list_screen.dart';

class ExpenseListPage extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseListPage({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) return ExpenseEmptyListScreen();

    final grouped = _groupByDate(expenses);
    return SafeArea(
      child: ListView(
        padding: AppPadding.edgeAll16,
        children: grouped.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: AppTextStyles.captionMedium(
                  color: AppColor.textSecondary,
                ),
              ),
              AppGap.g8,

              ...entry.value.map((expense) => ExpenseCard(expense: expense)),

              AppGap.g16,
            ],
          );
        }).toList(),
      ),
    );
  }

  Map<String, List<Expense>> _groupByDate(List<Expense> list) {
    final Map<String, List<Expense>> map = {};
    for (final e in list) {
      final key = dateLabel(e.createdAt);
      map.putIfAbsent(key, () => []).add(e);
    }
    return map;
  }
}
