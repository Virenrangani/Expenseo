import 'package:expenseo/features/split/presentation/widget/group_details_view/expenses_card.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entity/split_entity.dart';

class ExpenseSection extends StatelessWidget {

  final List<SplitEntity> expenses;

  const ExpenseSection({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: expenses.length,
        itemBuilder: (context , index){
          return ExpensesCard(expense: expenses[index]);
        }
    );

  }
}