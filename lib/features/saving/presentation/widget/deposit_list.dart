import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../domain/entity/deposit.dart';
import '../../domain/entity/saving_goal.dart';
import 'deposit_tile.dart';

class DepositList extends StatelessWidget {
  final List<Deposit> deposits;
  final SavingGoal goal;

  const DepositList({super.key, required this.deposits, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,

            child: Hero(
              tag: goal.id,

              child: ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,

                    colors: [Colors.black.withAlpha(240), Colors.transparent],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.darken,
                child: Image.network(goal.goalImage, fit: BoxFit.cover),
              ),
            ),
          ),

          Positioned(
            top: 42,
            left: 8,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
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

          /// DRAGGABLE SHEET
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.55,
            maxChildSize: 0.86,
            snap: true,
            snapSizes: const [0.55, 0.86],
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColor.background,
                  borderRadius: AppBorderRadius.cir24,
                ),

                child: Column(
                  children: [
                    AppGap.g12,

                    Container(
                      width: 60,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    AppGap.g12,

                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: deposits.length + 1,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: AppPadding.edgeSymmetricHori16,

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deposit History',
                                    style: AppTextStyles.captionBold(),
                                  ),

                                  AppGap.g12,
                                ],
                              ),
                            );
                          }

                          final deposit = deposits[index - 1];
                          return DepositTile(deposit: deposit);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
