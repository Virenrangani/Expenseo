import 'package:flutter/material.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/string/app_string.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/widget/app_title/app_title.dart';
import 'package:expenseo/features/home/presentation/widget/expense_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPadding.edgeSymmetricHori16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTitle(style: AppTextStyles.h3(color: AppColor.secondary)),
              AppGap.g16,
              Text(AppString.hello + " Viren", style: AppTextStyles.h4()),
              Text(
                AppString.homeIntro,
                style: AppTextStyles.caption(color: AppColor.textPrimary),
              ),
              AppGap.g20,
              ExpenseContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
