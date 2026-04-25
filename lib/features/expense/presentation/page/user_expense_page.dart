import 'package:flutter/material.dart';
import './add_expense_sheet.dart';
import '../cubit/expense_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/constant/colour/app_color.dart';

class UserExpensePage extends StatelessWidget {
  const UserExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (_) => GetIt.I<ExpenseCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Container(),

            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColor.secondary,
              onPressed: () {
                final expenseCubit = context.read<ExpenseCubit>();

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => BlocProvider.value(
                    value: expenseCubit,
                    child: AddExpenseSheet(),
                  ),
                );
              },
              child: Icon(Icons.add_circle_outline,size:32,color:AppColor.background,),
            ),
          );
        },
      ),
    );
  }
}