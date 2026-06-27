import 'package:expenseo/features/split/domain/entity/split_entity.dart';
import 'package:expenseo/features/split/presentation/widget/group_details_view/expenses_card.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';

class GroupExpensesPage extends StatelessWidget {
  final List<SplitEntity> expenses;

  const GroupExpensesPage({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryLight,
      appBar: AppBar(
        title: Text('All Expenses', style: AppTextStyles.h4()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColor.textPrimary),
      ),
      body: expenses.isEmpty
          ? Center(
              child: Text(
                'No expenses yet!',
                style: AppTextStyles.captionBold(),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ExpensesCard(expense: expenses[index]),
                );
              },
            ),
    );
  }
}
