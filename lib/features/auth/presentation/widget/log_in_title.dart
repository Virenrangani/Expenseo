import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:flutter/cupertino.dart';

class LogInTitle extends StatelessWidget {
  const LogInTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(AppString.appName,style: AppTextStyles.h1(),),
          Text(AppString.appIntro,style: AppTextStyles.captionMedium(),)
        ],
      ),
    );
  }
}
