import 'package:expenseo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:expenseo/features/expense/presentation/widget/amount_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/enums/app_enums.dart';
import '../../../../core/extension/localization_extension.dart';
import '../../../../core/widget/elevated_button/app_elevated_button.dart';
import '../../../../core/widget/text_field/app_text_field.dart';
import '../../domain/entity/expense.dart';
import '../cubit/expense_cubit.dart';
import '../cubit/expense_state.dart';
import '../widget/expense_category_selector.dart';
import '../widget/expense_type_toggle.dart';
import '../widget/payment_method_selector.dart';

class AddExpenseSheet extends StatefulWidget {
  const AddExpenseSheet({super.key});

  @override
  State<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<AddExpenseSheet> {
  final amountController = TextEditingController();
  final titleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
      child: Padding(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    context.read<ExpenseCubit>().type == TransactionType.expense
                        ? context.l10n.addExpense
                        : context.l10n.addIncome,
                    style: AppTextStyles.h5(),
                  ),
                ),
                AppGap.g16,

                AmountField(controller: amountController),
                AppGap.g16,

                ExpenseTypeToggle(
                  selectedType: context.read<ExpenseCubit>().type,
                  onChanged: (typeText) => setState(
                    () => context.read<ExpenseCubit>().type = typeText,
                  ),
                ),
                AppGap.g16,

                sectionLabel(context.l10n.title),
                AppGap.g8,
                AppFormField(
                  controller: titleController,
                  hintText: context.l10n.titleHint,
                  validator: (v) =>
                      v!.trim().isEmpty ? context.l10n.titleInvalid : null,
                ),

                AppGap.g16,
                sectionLabel(context.l10n.category),
                AppGap.g8,
                ExpenseCategorySelector(
                  selectedCategory: context.read<ExpenseCubit>().category,
                  onChanged: (cat) => setState(
                    () => context.read<ExpenseCubit>().category = cat,
                  ),
                ),

                AppGap.g16,
                sectionLabel(context.l10n.paymentMethod),
                AppGap.g8,
                PaymentMethodSelector(
                  selectedMethod: context.read<ExpenseCubit>().paymentMethod,
                  onChanged: (method) => setState(
                    () => context.read<ExpenseCubit>().paymentMethod = method,
                  ),
                ),
                AppGap.g20,
                submitButton(),
                AppGap.g20,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sectionLabel(String label) =>
      Text(label, style: AppTextStyles.captionMedium());

  Widget submitButton() {
    final isLoading = context.watch<ExpenseCubit>().state is ExpenseLoading;
    return AppElevatedButton(
      text: context.read<ExpenseCubit>().type == TransactionType.expense
          ? context.l10n.addExpense
          : context.l10n.addIncome,
      onPressed: onSubmit,
      isLoading: isLoading,
      isEnabled: true,
      borderRadius: 16,
    );
  }

  void onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ExpenseCubit>().addNewExpense(
      Expense(
        id: const Uuid().v4(),
        title: titleController.text.trim(),
        amount: double.parse(amountController.text.trim()),
        type: context.read<ExpenseCubit>().type,
        category: context.read<ExpenseCubit>().category,
        paymentMethod: context.read<ExpenseCubit>().paymentMethod,
        createdAt: DateTime.now(),
      ),
    );
  }
}
