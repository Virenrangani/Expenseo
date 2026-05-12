import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';

class LogInTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  const LogInTitle({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.h1(
              color: AppColor.background,
            ).copyWith(height:1.2),
          ),

          AppGap.g12,

          Text(
            subTitle,
            style: AppTextStyles.bodySmall(
              color: AppColor.background,
            ),
          ),
        ],
      ),
    );
  }
}
