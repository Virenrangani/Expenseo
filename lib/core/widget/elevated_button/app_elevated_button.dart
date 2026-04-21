import 'dart:ffi';

import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:flutter/material.dart';
import '../../constant/colour/app_color.dart';
import '../../constant/text_style/app_text_style.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? color1;
  final Color? color2;
  final bool isEnabled;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height=52,
    this.borderRadius=24,
    this.color1,
    this.color2,
    this.isEnabled=false,
    this.prefixIcon,
    this.suffixIcon,
  });

  void handleTap() async {
    if (isLoading || !isEnabled) return;

    onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height,
      child: ElevatedButton(
        onPressed: (!isEnabled || isLoading) ? null : handleTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color1 ?? AppColor.primary,
          disabledBackgroundColor: color1 ??AppColor.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
        ),
        child: isLoading
            ? SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColor.divider,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(prefixIcon != null)
                  Icon(prefixIcon,color: AppColor.background,size:22,),
                AppGap.g4,
                Text(
                text, style: AppTextStyles.h4(color:AppColor.background)
                ),
                AppGap.g4,
                if(suffixIcon != null)
                  Icon(suffixIcon,color: AppColor.background,size:22,),
              ],
            ),
      ),
    );
  }
}
