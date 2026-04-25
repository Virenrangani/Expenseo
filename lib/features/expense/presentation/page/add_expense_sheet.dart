import 'package:expenseo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/string/app_string.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/enums/app_enums.dart';
import '../cubit/expense_cubit.dart';
import '../cubit/expense_state.dart';


class AddExpenseSheet extends StatefulWidget {
  const AddExpenseSheet({super.key});

  @override
  State<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<AddExpenseSheet> {

  TransactionType type  = TransactionType.expense;
  final _formKey  = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseCubit, ExpenseState>(
        listener: (context, state) {
          if (state is ExpenseSuccess) {
            Navigator.pop(context);
            CustomSnacksBar.showSuccess(context, state.message);
          }
          if (state is ExpenseError) {
            CustomSnacksBar.showSuccess(context, state.message);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.background,
            borderRadius: AppBorderRadius.verTop24,
          ),
          padding: AppPadding.edgeAll16,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width:  40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColor.divider,
                        borderRadius: AppBorderRadius.cir8,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      type == TransactionType.expense ? AppString.addExpense : AppString.addIncome,
                      style: AppTextStyles.h5(),
                    ),
                  ),
                ],
              ),
            ),
          ),
    ),
    );
  }
}