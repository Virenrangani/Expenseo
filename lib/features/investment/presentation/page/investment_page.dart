import 'package:auto_size_text/auto_size_text.dart';
import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/features/investment/main_page/stocks/presentation/page/stocks_page.dart';
import 'package:flutter/material.dart';

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
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.66,
        ),

        itemBuilder: (context, index) {
          final item = investments[index];

          final isSelected = selectedIndex == index;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,

            decoration: BoxDecoration(
              borderRadius: AppBorderRadius.cir24,

              border: Border.all(
                color: isSelected ? item.color : item.color.withAlpha(75),
                width: isSelected ? 2 : 1,
              ),
            ),

            child: InkWell(
              borderRadius: AppBorderRadius.cir24,

              onTap: () {
                setState(() {
                  selectedIndex = index;
                });

                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => StocksPage(title: item.title),
                    ),
                  );
                }
              },

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.icon, size: 28, color: item.color),

                  AppGap.g4,

                  AutoSizeText(
                    minFontSize: 14,
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.h5(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
