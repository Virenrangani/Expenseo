import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/text_style/app_text_style.dart';

class SplitExpense extends StatelessWidget {
  const SplitExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryLight,
      body:SafeArea(
          child: Padding(
            padding: AppPadding.edgeAll12,
            child: Column(
              children: [
                Text(AppString.splitBill,style: AppTextStyles.h4(color:AppColor.secondary),),

              ],
            ),
          )
      ),
    );
  }
}
