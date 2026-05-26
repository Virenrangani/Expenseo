import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/widget/elevated_button/app_elevated_button.dart';
import 'package:expenseo/core/widget/format_amount/format_amount.dart';
import 'package:expenseo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:expenseo/core/widget/text_field/app_text_field.dart';
import 'package:expenseo/features/saving/domain/entity/saving_goal.dart';
import 'package:expenseo/features/saving/presentation/cubit/saving_cubit.dart';
import 'package:expenseo/features/saving/presentation/widget/progress_bar.dart';
import 'package:expenseo/features/saving/presentation/widget/side_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/string/app_string.dart';

class SavingsCard extends StatelessWidget {
  final SavingGoal goal;

  const SavingsCard({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    final savingAmountController = TextEditingController();
    return ClipPath(
      clipper: CardClipper(),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(goal.goalImage, fit: BoxFit.fill,),
          Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                begin:Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColor.textPrimary,
                    AppColor.textPrimary.withAlpha(100),
                    Colors.transparent
              ])
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ProgressBar(goal: goal),
              AppGap.g4,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SideButton(
                    iconData: Icons.add,
                    onTap: () {
                      final savingCubit = context.read<SavingCubit>();
                      showDialog<void>(
                        context: context,
                        builder: (_) {
                          return BlocProvider.value(
                            value: savingCubit,
                            child: AlertDialog(
                              title:  const Text(AppString.addSaving),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppFormField(
                                    controller: savingAmountController,
                                    hintText: AppString.addAmount,
                                    prefixText: '₹ ',
                                    fillColor: AppColor.primaryLight.withAlpha(50),
                                  ),
                                ],
                              ),

                              actions: [

                                AppElevatedButton(
                                  isEnabled: true,
                                  text: AppString.cancel,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),

                                AppElevatedButton(
                                  isEnabled: true,
                                  text: AppString.save,
                                  onPressed: () {
                                    context.read<SavingCubit>().addSavingAmount(
                                        goal.id,
                                        double.tryParse(savingAmountController.text) ?? 0
                                    );
                                    Navigator.pop(context);

                                    CustomSnacksBar.showSuccess(context, AppString.savingAmountAdded);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        AutoSizeText(goal.goal,
                            maxLines: 1,
                            style: AppTextStyles.h2(
                                color: AppColor.background),
                            overflow: TextOverflow.ellipsis
                        ),
                        Text(formatAmount(goal.targetAmount),
                          style: AppTextStyles.h5(
                            color: AppColor.background,),),
                        AppGap.g8
                      ],
                    ),
                  ),

                  const SideButton(iconData: Icons.arrow_forward)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CardClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    const double radius = 60;

    final path = Path()

      ..moveTo(radius, 0)

      ..quadraticBezierTo(
        size.width / 2,
        10,
        size.width - radius,
        0,
      )..quadraticBezierTo(
        size.width,
        0,
        size.width,
        radius,
      )

      ..lineTo(size.width, size.height - radius)

      ..quadraticBezierTo(
        size.width,
        size.height,
        size.width - radius,
        size.height,
      )..quadraticBezierTo(
        size.width / 2,
        size.height - 10,
        radius,
        size.height,
      )..quadraticBezierTo(
        0,
        size.height,
        0,
        size.height - radius,
      )

      ..lineTo(0, radius)

      ..quadraticBezierTo(
        0,
        0,
        radius,
        0,
      )

      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
