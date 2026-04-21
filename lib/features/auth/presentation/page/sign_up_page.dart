import 'package:expenseo/core/widget/app_title/app_title.dart';
import 'package:expenseo/features/auth/presentation/widget/or_divider.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/string/app_string.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/widget/elevated_button/app_elevated_button.dart';
import '../../../../core/widget/text_field/app_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.primaryLight,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppTitle(style: AppTextStyles.h1(),),
              AppGap.g20,
              Padding(
                padding: AppPadding.edgeAll16,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor.background,
                      borderRadius: AppBorderRadius.cir12
                  ),
                  child: Padding(
                    padding: AppPadding.edgeSymmetricHori24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppGap.g32,
                        Text(AppString.signUpIntro,
                          style: AppTextStyles.h3(color:AppColor.textPrimary),),
                        AppGap.g4,
                        Text(AppString.signUpSubIntro,style: AppTextStyles.bodySmall(),),
                        AppGap.g32,
                        AppFormField(
                          hintText: AppString.name,
                          labelText: AppString.name,
                        ),
                        AppGap.g24,
                        AppFormField(
                          hintText: AppString.email,
                          labelText: AppString.email,
                        ),
                        AppGap.g24,
                        AppFormField(
                          hintText: AppString.password,
                          labelText: AppString.password,
                          suffix:Icon(Icons.remove_red_eye),
                        ),
                        AppGap.g32,
                        CustomElevatedButton(
                            text: AppString.createAccount,
                            suffixIcon:Icons.arrow_forward_outlined,
                            onPressed: (){}
                        ),
                        AppGap.g32,
                      ],
                    ),
                  ),
                ),
              ),
              AppGap.g32,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppString.dontHaveAnAccount,style: AppTextStyles.bodyMedium(),),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                    },
                    child: Text(
                        AppString.signUp,
                        style: AppTextStyles.bodyMedium(color: AppColor.secondary)
                    ),
                  ),
                ],
              )
            ],
          )
      )
    );
  }
}
