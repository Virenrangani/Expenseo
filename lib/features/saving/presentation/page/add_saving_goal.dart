import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/widget/elevated_button/app_elevated_button.dart';
import 'package:expenseo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:expenseo/core/widget/text_field/app_text_field.dart';
import 'package:expenseo/features/saving/presentation/cubit/saving_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubit/saving_cubit.dart';

class AddSavingGoal extends StatefulWidget {
  const AddSavingGoal({super.key});

  @override
  State<AddSavingGoal> createState() => _AddSavingGoalState();
}

class _AddSavingGoalState extends State<AddSavingGoal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController goalController = TextEditingController();
  final TextEditingController targetAmountController = TextEditingController();
  final TextEditingController goalImageController = TextEditingController();
  SavingCubit cubit = GetIt.I<SavingCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocConsumer<SavingCubit, SavingState>(
        listener: (context, state) {
          if (state is SavingSuccess) {
            CustomSnacksBar.showSuccess(context, state.message);
            Navigator.pop(context);
          }

          if (state is SavingError) {
            CustomSnacksBar.showError(context, state.message);
          }
        },

        builder: (context, state) {
          final isLoading = state is SavingLoading;

          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
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
                        AppString.newSavingGoal,
                        style: AppTextStyles.h5(),
                      ),
                    ),

                    Text(
                      AppString.goalImage,
                      style: AppTextStyles.caption(color: AppColor.textPrimary),
                    ),
                    AppGap.g4,
                    AppFormField(
                      controller: goalImageController,
                      hintText: AppString.goalHint,
                      prefixIcon: const Icon(
                        Icons.image_outlined,
                        color: AppColor.textSecondary,
                      ),
                      fillColor: AppColor.primaryLight.withAlpha(50),
                      validator: (value) {
                        return context.read<SavingCubit>().validateGoalImage(
                          value ?? '',
                        );
                      },
                    ),

                    AppGap.g20,

                    Text(
                      AppString.goal,
                      style: AppTextStyles.caption(color: AppColor.textPrimary),
                    ),
                    AppGap.g4,
                    AppFormField(
                      controller: goalController,
                      hintText: AppString.goalHint,
                      prefixIcon: const Icon(
                        Icons.savings_outlined,
                        color: AppColor.textSecondary,
                      ),
                      fillColor: AppColor.primaryLight.withAlpha(50),
                      validator: (value) {
                        return context.read<SavingCubit>().validateGoal(
                          value ?? '',
                        );
                      },
                    ),

                    AppGap.g20,

                    Row(
                      children: [
                        Text(
                          AppString.targetAmount,
                          style: AppTextStyles.caption(
                            color: AppColor.textPrimary,
                          ),
                        ),
                        AppGap.g8,
                        Expanded(
                          child: AppFormField(
                            controller: targetAmountController,
                            hintText: AppString.targetAmountGoal,
                            prefixText: '₹ ',
                            fillColor: AppColor.primaryLight.withAlpha(50),
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            textAction: TextInputAction.done,
                            validator: (value) {
                              return context
                                  .read<SavingCubit>()
                                  .validateTargetAmount(value ?? '');
                            },
                          ),
                        ),
                      ],
                    ),

                    AppGap.g20,

                    AppElevatedButton(
                      text: AppString.addGoal,
                      onPressed: onSubmit,
                      isLoading: isLoading,
                      isEnabled: true,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    await GetIt.I<SavingCubit>().createGoal(
      goal: goalController.text.trim(),
      goalImage: goalImageController.text.trim(),
      targetAmount: double.parse(targetAmountController.text.trim()),
    );
  }
}
