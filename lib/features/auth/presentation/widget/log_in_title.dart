import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/widget/app_title/app_title.dart';

class LogInTitle extends StatelessWidget {
  const LogInTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const AppTitle(),
          Text(AppString.appIntro, style: AppTextStyles.captionMedium()),
        ],
      ),
    );
  }
}
