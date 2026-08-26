import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/navigation/app_navigation.dart';
import 'package:expenseo/core/widget/elevated_button/app_elevated_button.dart';
import 'package:expenseo/core/widget/text_field/app_text_field.dart';
import 'package:expenseo/features/saving/presentation/cubit/saving_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/extension/localization_extension.dart';
import '../../../../core/extension/snackbar_extension.dart';
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
            context.showSuccessSnackBar(state.message);
            context.pop(context);
          }

          if (state is SavingError) {
            context.showErrorSnackBar(state.message);
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
                        context.l10n.newSavingGoal,
                        style: AppTextStyles.h5(),
                      ),
                    ),

                    Text(
                      context.l10n.goalImage,
                      style: AppTextStyles.caption(color: AppColor.textPrimary),
                    ),
                    AppGap.g4,
                    AppFormField(
                      controller: goalImageController,
                      hintText: context.l10n.goalHint,
                      prefixIcon: const Icon(
                        Icons.image_outlined,
                        color: AppColor.textSecondary,
                      ),
                      fillColor: AppColor.primaryLight.withAlpha(50),
                      validator: (value) {
                        return context.read<SavingCubit>().validateGoalImage(
                          value ?? '',
                          context,
                        );
                      },
                    ),

                    AppGap.g20,

                    Text(
                      context.l10n.goal,
                      style: AppTextStyles.caption(color: AppColor.textPrimary),
                    ),
                    AppGap.g4,
                    AppFormField(
                      controller: goalController,
                      hintText: context.l10n.goalHint,
                      prefixIcon: const Icon(
                        Icons.savings_outlined,
                        color: AppColor.textSecondary,
                      ),
                      fillColor: AppColor.primaryLight.withAlpha(50),
                      validator: (value) {
                        return context.read<SavingCubit>().validateGoal(
                          value ?? '',
                          context,
                        );
                      },
                    ),

                    AppGap.g20,

                    Row(
                      children: [
                        Text(
                          context.l10n.targetAmount,
                          style: AppTextStyles.caption(
                            color: AppColor.textPrimary,
                          ),
                        ),
                        AppGap.g8,
                        Expanded(
                          child: AppFormField(
                            controller: targetAmountController,
                            hintText: context.l10n.targetAmountGoal,
                            prefixText: '₹ ',
                            fillColor: AppColor.primaryLight.withAlpha(50),
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            textAction: TextInputAction.done,
                            validator: (value) {
                              return context
                                  .read<SavingCubit>()
                                  .validateTargetAmount(value ?? '', context);
                            },
                          ),
                        ),
                      ],
                    ),

                    AppGap.g20,

                    AppElevatedButton(
                      text: context.l10n.addGoal,
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
      context: context,
      goal: goalController.text.trim(),
      goalImage: goalImageController.text.trim(),
      targetAmount: double.parse(targetAmountController.text.trim()),
    );
  }
}
