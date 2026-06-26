import 'package:expenseo/features/expense/presentation/cubit/expense_cubit.dart';
import 'package:expenseo/features/expense/presentation/cubit/expense_state.dart';
import 'package:expenseo/features/home/presentation/widget/expense_container.dart';
import 'package:expenseo/features/home/presentation/widget/greeting_user.dart';
import 'package:expenseo/features/home/presentation/widget/show_all_expense_button.dart';
import 'package:expenseo/features/home/presentation/widget/transaction_list.dart';
import 'package:expenseo/features/saving/presentation/page/user_saving_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/string/app_string.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/widget/app_icon_card/app_icon_card.dart';
import '../../../expense/presentation/page/add_expense_sheet.dart';
import '../../../split/presentation/page/split_expense.dart';
import '../cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<HomeCubit>()..getUserName()),
        BlocProvider(create: (_) => GetIt.I<ExpenseCubit>()..getExpense()),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Padding(
              padding: AppPadding.edgeAll16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppGap.g32,
                  AppGap.g12,
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return const SizedBox(
                          height: 48,
                          child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      }
                      return GreetingUser(
                        userName: context.read<HomeCubit>().userName,
                      );
                    },
                  ),
                  AppGap.g12,
                  BlocBuilder<ExpenseCubit, ExpenseState>(
                    builder: (context, state) {
                      if (state is ExpenseLoading) {
                        return Skeletonizer(
                          child: ExpenseContainer(
                            totalExpense: context
                                .read<ExpenseCubit>()
                                .totalExpense,
                            totalIncome: context
                                .read<ExpenseCubit>()
                                .totalIncome,
                          ),
                        );
                      }
                      if (state is ExpenseLoaded) {
                        return ExpenseContainer(
                          totalExpense: context
                              .read<ExpenseCubit>()
                              .totalExpense,
                          totalIncome: context.read<ExpenseCubit>().totalIncome,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  AppGap.g16,

                   Row(
                      children: [
                        AppIconCard(
                          icon: Icons.add,
                          text: AppString.addExpense,
                          onTap: () {
                            showBottomSheet(
                              context: context,
                              enableDrag: true,
                              showDragHandle: true,
                              backgroundColor: Colors.white,
                              builder: (_) => BlocProvider.value(
                                value: context.read<ExpenseCubit>(),
                                child: const AddExpenseSheet(),
                              ),
                            );
                          },
                        ),

                        AppGap.g8,

                        AppIconCard(
                          icon: Icons.splitscreen,
                          text: AppString.split,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) =>
                                    const SplitExpense(),
                              ),
                            );
                          },
                        ),

                        AppGap.g8,

                        AppIconCard(
                          icon: Icons.savings_outlined,
                          text: AppString.saving,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) =>
                                const UserSavingPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                  AppGap.g16,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppString.recentTransaction,
                        style: AppTextStyles.h5(),
                      ),
                      const ShowAllExpenseButton(),
                    ],
                  ),
                  const Flexible(child: TransactionList()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
