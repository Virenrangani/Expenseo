import 'package:expenseo/features/expense/presentation/cubit/expense_cubit.dart';
import 'package:expenseo/features/expense/presentation/page/user_expense_page.dart';
import 'package:expenseo/features/home/presentation/widget/expense_container.dart';
import 'package:expenseo/features/home/presentation/widget/greeting_user.dart';
import 'package:expenseo/features/home/presentation/widget/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/string/app_string.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/widget/app_icon_card/app_icon_card.dart';
import '../../../../core/widget/app_title/app_title.dart';
import '../../../expense/presentation/page/add_expense_sheet.dart';
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
    BlocProvider(
      create: (_) => GetIt.I<HomeCubit>()..getUserName(),
    ),
    BlocProvider(
      create: (_) => GetIt.I<ExpenseCubit>()..getExpense(),
    ),
  ],
  child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: AppPadding.edgeSymmetricHori16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTitle(style: AppTextStyles.h3(color: AppColor.secondary)),
                    AppGap.g16,
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
                        return GreetingUser(userName: context.read<HomeCubit>().userName,);
                        },
                    ),
                    AppGap.g20,
                    const ExpenseContainer(),
                    AppGap.g24,
                    Row(
                      children: [
                        Expanded(
                          child: AppIconCard(
                            icon: Icons.add_circle_outline_outlined,
                            text: AppString.addExpense,
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => BlocProvider.value(
                                  value: context.read<ExpenseCubit>(),
                                  child: const AddExpenseSheet(),
                                ),
                              );
                            },
                          ),
                        ),
                        AppGap.g16,
                        Expanded(
                          child: AppIconCard(
                            icon: Icons.splitscreen,
                            text: AppString.split,
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute<void>(
                                      builder: (context) => const UserExpensePage()));
                            },
                          ),
                        ),
                      ],
                    ),
                    AppGap.g32,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppString.recentTransaction,
                          style: AppTextStyles.captionBold(
                              color: AppColor.textPrimary),),
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<ExpenseCubit>(),
                                  child: const UserExpensePage(),
                                ),
                              ),
                            );
                          },
                            child: Text(AppString.showAll,style: AppTextStyles.caption(),)
                        )
                      ],
                    ),

                    AppGap.g16,

                    const Expanded(child: TransactionList())
                  ],
                ),
              ),
            ),
          );
        }
      ),
  );
  }
}