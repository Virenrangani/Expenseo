import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../widget/investment_list.dart';

class InvestmentPage extends StatefulWidget {
  const InvestmentPage({super.key});

  @override
  State<InvestmentPage> createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<InvestmentPage> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Investments', style: AppTextStyles.h3()),
        centerTitle: true,
      ),

      body: GridView.builder(
        padding: AppPadding.edgeAll16,
        itemCount: investments.length,

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.78,
        ),

        itemBuilder: (context, index) {
          final item = investments[index];

          final isSelected = selectedIndex == index;

          return AnimatedScale(
            duration: const Duration(milliseconds: 250),
            scale: isSelected ? 0.96 : 1,

            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,

              decoration: BoxDecoration(
                borderRadius: AppBorderRadius.cir24,

                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isSelected
                      ? [item.color.withAlpha(85), item.color.withAlpha(40)]
                      : [item.color.withAlpha(45), item.color.withAlpha(10)],
                ),

                border: Border.all(
                  color: isSelected ? item.color : item.color.withAlpha(75),
                  width: isSelected ? 2 : 1,
                ),

                boxShadow: [
                  BoxShadow(
                    color: item.color.withAlpha(isSelected ? 85 : 28),
                    blurRadius: isSelected ? 18 : 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: InkWell(
                borderRadius: AppBorderRadius.cir24,

                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },

                child: Padding(
                  padding: AppPadding.edgeAll12,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: item.title,

                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),

                          padding: EdgeInsets.all(isSelected ? 18 : 14),

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            color: item.color.withAlpha(isSelected ? 75 : 45),
                          ),

                          child: Icon(
                            item.icon,
                            size: isSelected ? 38 : 32,
                            color: item.color,
                          ),
                        ),
                      ),

                      AppGap.g12,

                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 250),

                        style: AppTextStyles.h5().copyWith(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w600,

                          color: isSelected ? item.color : AppColor.textPrimary,
                        ),

                        child: Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
