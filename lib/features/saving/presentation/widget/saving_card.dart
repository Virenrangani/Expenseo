import 'package:expenseo/features/saving/domain/entity/saving_goal.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import 'card_clipper.dart';
import 'goal_bottom_bar.dart';

class SavingsCard extends StatelessWidget {
  final SavingGoal goal;

  const SavingsCard({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ClipPath(
        clipper: CardClipper(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: goal.id,
              child: Image.network(goal.goalImage, fit: BoxFit.cover),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColor.textPrimary,
                    AppColor.textPrimary.withAlpha(100),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            GoalBottomBar(goal: goal),
          ],
        ),
      ),
    );
  }
}
