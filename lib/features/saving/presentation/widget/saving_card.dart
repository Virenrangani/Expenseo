import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/features/saving/domain/entity/saving_goal.dart';
import 'package:expenseo/features/saving/presentation/widget/goal_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'card_clipper.dart';

class SavingsCard extends StatelessWidget {
  final SavingGoal goal;

  const SavingsCard({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Hero(
        tag: goal.id,
        child: ClipPath(
          clipper: CardClipper(),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(goal.goalImage, fit: BoxFit.cover),
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
      ),
    );
  }
}
