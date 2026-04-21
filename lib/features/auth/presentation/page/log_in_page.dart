import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/widget/text_field/app_text_field.dart';
import 'package:expenseo/features/auth/presentation/widget/log_in_title.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryLight,
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LogInTitle(),
              Padding(
                padding: AppPadding.edgeAll16,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: AppBorderRadius.cir12
                  ),
                  child:Padding(
                    padding: AppPadding.edgeSymmetricHori24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppGap.g32,
                        Text(AppString.logInIntro,
                          style: AppTextStyles.captionBold(color:AppColor.textPrimary),),
                        AppGap.g4,
                        Text(AppString.logInSubIntro,style: AppTextStyles.bodySmall(),),
                        AppGap.g32,
                        AppFormField(
                          hintText: AppString.email,
                          labelText: AppString.email,
                        ),
                        AppGap.g24,
                        AppFormField(
                          hintText: AppString.password,
                          labelText: AppString.password,
                        ),
                        AppGap.g16,
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: (){},
                            child: Text(AppString.forgotPassword,
                              style: AppTextStyles.description(color:AppColor.secondary),),
                          ),
                        ),
                        AppGap.g16,
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
      )
    );
  }
}
