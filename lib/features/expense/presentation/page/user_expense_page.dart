import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/features/expense/presentation/cubit/expense_state.dart';
import 'package:expenseo/features/expense/presentation/widget/expense_card.dart';
import 'package:expenseo/features/expense/presentation/widget/fake_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../cubit/expense_cubit.dart';
import './add_expense_sheet.dart';
import 'expense_list_page.dart';

class UserExpensePage extends StatelessWidget {
  const UserExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider<ExpenseCubit>(
      create: (_) => GetIt.I<ExpenseCubit>()..getExpense(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body:BlocBuilder<ExpenseCubit,ExpenseState>(
                builder: (context,state){
                  if(state is ExpenseLoading){
                    return Padding(
                      padding: AppPadding.edgeAll16,
                      child: Skeletonizer(
                          child: ListView.builder(
                            itemCount: 6,
                              itemBuilder: (_,_)=>ExpenseCard(
                                  expense: FakeExpense.fake()
                              )
                          )
                      ),
                    );
                  }
                  if(state is ExpenseError){
                    return Center(child: Text(state.message),);
                  }
                  if(state is ExpenseLoaded){
                    return ExpenseListPage(
                      expenses: state.expenses ?? [],
                    );
                  }
                  return const SizedBox.shrink();
                }),

            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColor.secondary,
              onPressed: () {
                final expenseCubit = context.read<ExpenseCubit>();

                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => BlocProvider.value(
                    value: expenseCubit,
                    child: const AddExpenseSheet(),
                  ),
                );
              },
              child: const Icon(Icons.add_circle_outline,size:32,color:AppColor.background,),
            ),
          );
        },
      ),
    );
  }
}