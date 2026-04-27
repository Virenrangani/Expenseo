import 'package:flutter/cupertino.dart';
import '../../../../core/enums/app_enums.dart';
import '../../domain/entity/expense.dart';
import 'category_list_option.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final option = categoryListOption[expense.category]!;
    final isExpense = expense.type == TransactionType.expense;

    return Container();
  }
}