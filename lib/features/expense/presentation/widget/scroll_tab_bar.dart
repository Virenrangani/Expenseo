import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/enums/app_enums.dart';

class ScrollTabBar extends StatefulWidget {

  final Function(ExpenseFilter filter) onFilterChanged;

  const ScrollTabBar({
    super.key,
    required this.onFilterChanged,
  });

  @override
  State<ScrollTabBar> createState() => _ScrollTabBarState();
}

class _ScrollTabBarState extends State<ScrollTabBar> {

  final List<String> tabs = [
    'All',
    'Today',
    'Week',
    'Month',
    'Income',
    'Expense'
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 44,

      child: ListView.separated(
        scrollDirection: Axis.horizontal,

        padding: const EdgeInsets.symmetric(horizontal: 12),

        itemCount: tabs.length,

        separatorBuilder: (_, _) =>
        AppGap.g8,

        itemBuilder: (context, index) {

          final isSelected =
              selectedIndex == index;

          return GestureDetector(

            onTap: () {

              setState(() {
                selectedIndex = index;
              });

              switch(index){
                case 0:
                  widget.onFilterChanged(
                    ExpenseFilter.all,
                  );

                case 1:
                  widget.onFilterChanged(
                    ExpenseFilter.today,
                  );

                case 2:
                  widget.onFilterChanged(
                    ExpenseFilter.week,
                  );

                case 3:
                  widget.onFilterChanged(
                    ExpenseFilter.month,
                  );

                case 4:
                  widget.onFilterChanged(
                    ExpenseFilter.income,
                  );

                case 5:
                  widget.onFilterChanged(
                    ExpenseFilter.expense,
                  );
              }
            },

            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250,),

              padding: AppPadding.edgeSymmetricHori12,

              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.primary
                    : AppColor.primary.withAlpha(25),

                borderRadius: AppBorderRadius.cir12,

                border: Border.all(
                  width: 1.5,
                  color: isSelected
                      ? AppColor.primary
                      : AppColor.textSecondary,
                ),
              ),

              child: Center(
                child: Text(
                  tabs[index],

                  style: AppTextStyles.captionMedium(
                    color: isSelected
                        ? Colors.white
                        : AppColor.textPrimary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}