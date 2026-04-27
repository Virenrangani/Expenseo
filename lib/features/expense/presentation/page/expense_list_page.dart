import 'package:flutter/material.dart';
import '../../../../core/widget/date_label/date_label.dart';
import '../../domain/entity/expense.dart';
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

    return Container();

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
