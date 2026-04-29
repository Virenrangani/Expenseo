import 'package:expenseo/features/expense/presentation/cubit/expense_cubit.dart';
import 'package:expenseo/features/expense/presentation/cubit/expense_state.dart';
import 'package:expenseo/features/expense/presentation/widget/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../expense/presentation/widget/fake_expense.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      builder: (context, state) {
        if (state is ExpenseLoading) {
          return Skeletonizer(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (_, _) => ExpenseCard(expense: FakeExpense.fake()),
            ),
          );
        }

        if (state is ExpenseError) {
          return Center(child: Text(state.message));
        }

        if (state is ExpenseLoaded) {
          final transaction = state.expenses;
          final recentTransaction = context
              .read<ExpenseCubit>()
              .recentTransactionCount;
          final count = (transaction!.length < recentTransaction)
              ? transaction.length
              : recentTransaction;
          return ListView.builder(
            itemCount: count,
            itemBuilder: (context, index) {
              return ExpenseCard(expense: transaction[index]);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
