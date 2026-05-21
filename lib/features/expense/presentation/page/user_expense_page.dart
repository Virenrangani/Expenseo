import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/core/widget/text_field/app_text_field.dart';
import 'package:expenseo/features/expense/presentation/cubit/expense_state.dart';
import 'package:expenseo/features/expense/presentation/widget/expense_card.dart';
import 'package:expenseo/features/expense/presentation/widget/fake_expense.dart';
import 'package:expenseo/features/expense/presentation/widget/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../cubit/expense_cubit.dart';
import './add_expense_sheet.dart';
import 'expense_list_page.dart';

class UserExpensePage extends StatelessWidget {
  const UserExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        title: Text(AppString.allExpenses, style: AppTextStyles.titleLarge()),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: AppPadding.edgeSymmetricHori16,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: AppFormField(
                          controller: searchController,
                          hintText: 'Search your Expense..',
                          fillColor: AppColor.primary.withAlpha(30),
                          prefixIcon: const Icon(Icons.search_rounded ,
                            color: AppColor.textSecondary,),
                          onChanged: (value){
                            context.read<ExpenseCubit>().searchExpense(value);
                          },
                        ),
                      ),
                    ),
                    AppGap.g8,
                    const FilterButton()
                  ],
                ),
              ),

              Expanded(
                child: BlocBuilder<ExpenseCubit, ExpenseState>(
                  builder: (context, state) {
                    if (state is ExpenseLoading) {
                      return Padding(
                        padding: AppPadding.edgeAll16,
                        child: Skeletonizer(
                          child: ListView(
                            children: List.generate(1, (index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 120,
                                    height: 14,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.textLight,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  ...List.generate(
                                    6,
                                        (_) =>
                                        ExpenseCard(
                                          expense: FakeExpense.fake(),
                                        ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              );
                            }),
                          ),
                        ),
                      );
                    }
                    if (state is ExpenseError) {
                      return Center(child: Text(state.message));
                    }
                    if (state is ExpenseLoaded) {
                      return ExpenseListPage(expenses: state.expenses ?? []);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
          Positioned(
            right: 20,
            bottom: 30,
            child: Builder(
                builder: (context) {
                  return FloatingActionButton(
                    backgroundColor: AppColor.primary,
                    onPressed: () {
                      final expenseCubit = context.read<ExpenseCubit>();
                      showBottomSheet(
                        context: context,
                        builder: (_) =>
                            BlocProvider.value(
                              value: expenseCubit,
                              child: const AddExpenseSheet(),
                            ),
                        enableDrag: true,
                        showDragHandle: true,
                        backgroundColor: AppColor.background,
                      );
                    },
                    child: const Icon(
                      Icons.add_circle_outline,
                      size: 32,
                      color: AppColor.background,
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
