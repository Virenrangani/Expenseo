import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/widget/format_amount/format_amount.dart';
import 'package:expenseo/features/saving/domain/entity/saving_goal.dart';
import 'package:expenseo/features/saving/presentation/widget/side_button.dart';
import 'package:flutter/material.dart';

class SavingsCard extends StatelessWidget {
  final SavingGoal goal;
  const SavingsCard({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppPadding.edgeSymmetricHori12,
        child: ClipPath(
          clipper: CardClipper(),
          child: Stack(
            fit: StackFit.expand,
            children: [

              Image.network(goal.goalImage, fit: BoxFit.fill,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SideButton(iconData: Icons.add),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(goal.goal,
                          style: AppTextStyles.h2(color: AppColor.background),overflow: TextOverflow.ellipsis),
                        Text(formatAmount(goal.targetAmount),
                          style: AppTextStyles.h5(color: AppColor.background,),),
                        AppGap.g8
                      ],
                    ),
                  ),

                 const SideButton(iconData: Icons.arrow_forward)
                ],
              ),
            ],
          ),
        ),
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
      )

      ..quadraticBezierTo(
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
      )

      ..quadraticBezierTo(
        size.width / 2,
        size.height - 10,
        radius,
        size.height,
      )

      ..quadraticBezierTo(
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
