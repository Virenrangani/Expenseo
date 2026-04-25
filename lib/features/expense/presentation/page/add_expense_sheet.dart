import 'package:expenseo/core/validation/amount_validation/amount_validation.dart';
import 'package:expenseo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/string/app_string.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/enums/app_enums.dart';
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
  final titleController  = TextEditingController();

  TransactionType type  = TransactionType.expense;
  ExpenseCategory category = ExpenseCategory.food;
  PaymentMethod paymentMethod = PaymentMethod.cash;
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
                  AppGap.g16,
                  Container(
                    width: double.infinity,
                    padding: AppPadding.edgeAll16,
                    decoration: BoxDecoration(
                      color: AppColor.primaryLight,
                      borderRadius: AppBorderRadius.cir16,
                    ),
                    child: Column(
                      children: [
                        Text(
                          AppString.addAmount,
                          style: AppTextStyles.captionMedium(color: AppColor.secondary),
                        ),
                        AppGap.g8,

                        AppFormField(
                          controller: amountController,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),

                          textAlign: TextAlign.center,
                          style: AppTextStyles.h2(color: AppColor.primary),

                          hintText: '0',
                          prefixText: '₹ ',
                          prefixStyle: AppTextStyles.h2(color: AppColor.primary),

                          contentPadding: EdgeInsets.zero,
                          fillColor: AppColor.secondary,
                          validator: (val)=>validateAmount(val!)
                        ),
                      ],
                    ),
                  ),
                  AppGap.g16,
                  ExpenseTypeToggle(
                    selectedType: type,
                    onChanged: (typeText) => setState(() => type = typeText),
                  ),
                  AppGap.g16,

                  sectionLabel(AppString.title),
                  AppGap.g8,
                  AppFormField(
                    controller: titleController,
                    hintText: AppString.titleHint  ,
                    validator:  (v) => v!.trim().isEmpty ? AppString.titleInvalid : null,
                  ),

                  AppGap.g16,
                  sectionLabel(AppString.category),
                  AppGap.g8,
                  ExpenseCategorySelector(
                    selectedCategory: category,
                    onChanged: (cat) => setState(() => category = cat),
                  ),

                  AppGap.g16,
                  sectionLabel(AppString.paymentMethod),
                  AppGap.g8,
                  PaymentMethodSelector(
                    selectedMethod: paymentMethod,
                    onChanged: (method) => setState(() => paymentMethod = method),
                  ),
                  AppGap.g20,
                  submitButton(),
                ],
              ),
            ),
          ),
    ),
    );
  }

  Widget sectionLabel(String label) =>
      Text(
        label,
        style: AppTextStyles.captionMedium(color: AppColor.textSecondary),
      );

  Widget submitButton() {
    final isLoading = context.watch<ExpenseCubit>().state is ExpenseLoading;
    return AppElevatedButton(
      text: type == TransactionType.expense ? AppString.addExpense : AppString.addIncome,
      onPressed:onSubmit,
      isLoading: isLoading,
      isEnabled: true,
      borderRadius: 16,
    );
  }
  void onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ExpenseCubit>().addNewExpense(
      Expense(
        id: Uuid().v4(),
        title: titleController.text.trim(),
        amount: double.parse(amountController.text.trim()),
        type: type,
        category: category,
        paymentMethod: paymentMethod,
        createdAt: DateTime.now(),
      ),
    );
  }
}