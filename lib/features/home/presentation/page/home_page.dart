import 'package:flutter/material.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/widget/app_title/app_title.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/padding/app_padding.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:Padding(
              padding:AppPadding.edgeSymmetricHori16,
          child:Column(
            children: [
              AppTitle(style: AppTextStyles.h3(color:AppColor.primary)),
            ],
          )
          ),
      )
    );
  }
}
