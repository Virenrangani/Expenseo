import 'package:carousel_slider/carousel_slider.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entity/saving_goal.dart';
import '../widget/saving_card.dart';

class SavingGoalsList extends StatelessWidget {

  final List<SavingGoal> savingGoals;

  const SavingGoalsList({
    super.key,
    required this.savingGoals,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: savingGoals.length,
      itemBuilder: (context, index, realIndex) {
        final goal = savingGoals[index];
        return SavingsCard(goal: goal);
      },
      options: CarouselOptions(
        enlargeCenterPage: true,
        aspectRatio: 1.8,
        enlargeFactor: 0.35,
        viewportFraction: 0.65,
        clipBehavior: Clip.none,
        scrollPhysics:const BouncingScrollPhysics(),
      ),
    );
  }
}