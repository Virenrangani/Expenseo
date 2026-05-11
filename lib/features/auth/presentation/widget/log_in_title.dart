import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';

class LogInTitle extends StatelessWidget {
  const LogInTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            AppString.logInIntro,
            textAlign: TextAlign.center,
            style: AppTextStyles.h1(
              color: AppColor.background,
            ),
          ),

          AppGap.g12,

          Text(
            AppString.logInSubIntro,
            style: AppTextStyles.bodySmall(
              color: AppColor.background,
            ),
          ),
        ],
      ),
    );
  }
}
