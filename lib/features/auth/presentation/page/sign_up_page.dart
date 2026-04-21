import 'package:expenseo/core/widget/app_title/app_title.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/text_style/app_text_style.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppTitle(style: AppTextStyles.h1(),),
              AppGap.g20,
            ],
          )
      )
    );
  }
}
