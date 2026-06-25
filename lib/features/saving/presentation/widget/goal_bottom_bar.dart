import 'package:auto_size_text/auto_size_text.dart';
import 'package:expenseo/features/saving/presentation/widget/add_saving_alert_box.dart';
import 'package:expenseo/features/saving/presentation/widget/progress_bar.dart';
import 'package:expenseo/features/saving/presentation/widget/side_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/widget/format_amount/format_amount.dart';
import '../../domain/entity/saving_goal.dart';
import '../cubit/saving_cubit.dart';
import '../page/goal_detail_page.dart';

class GoalBottomBar extends StatelessWidget {
  final SavingGoal goal;

  const GoalBottomBar({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        ProgressBar(goal: goal),
        AppGap.g4,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SideButton(
              iconData: Icons.add,
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (_) {
                    return BlocProvider.value(
                      value: GetIt.I<SavingCubit>(),
                      child: AddSavingAlertBox(goal: goal),
                    );
                  },
                );
              },
            ),
            Expanded(
              child: Column(
                children: [
                  AutoSizeText(
                    goal.goal,
                    maxLines: 1,
                    style: AppTextStyles.h2(color: AppColor.background),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    formatAmount(goal.targetAmount),
                    style: AppTextStyles.h5(color: AppColor.background),
                  ),
                  AppGap.g8,
                ],
              ),
            ),

            SideButton(
              iconData: Icons.arrow_forward,
              onTap: () async {
                final shouldRefresh = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(builder: (_) => GoalDetailPage(goal: goal)),
                );

                if (shouldRefresh == true && context.mounted) {
                  await context.read<SavingCubit>().getAllGoal();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
