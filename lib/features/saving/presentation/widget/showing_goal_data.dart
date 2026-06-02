import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/features/saving/domain/entity/saving_goal.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';

class ShowingGoalData extends StatelessWidget {
  final SavingGoal goal;

  const ShowingGoalData({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: goal.id,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColor.textPrimary.withAlpha(230),
                    AppColor.textPrimary.withAlpha(180),
                    AppColor.textPrimary.withAlpha(50),
                    Colors.transparent,
                  ],
                  stops: const [0.15, 0.3, 0.5, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.darken,
              child: Image.network(goal.goalImage),
            ),
            Positioned(
              top: 42,
              left: 15,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColor.background,
                    ),
                  ),
                  Text(
                    'Goal Details',
                    style: AppTextStyles.h4(color: AppColor.background),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
