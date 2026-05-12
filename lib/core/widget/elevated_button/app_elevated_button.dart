import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:flutter/material.dart';

import '../../constant/colour/app_color.dart';
import '../../constant/text_style/app_text_style.dart';

class AppElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? color;
  final Color textColor;
  final bool isEnabled;
  final Widget? prefix;
  final Widget? suffix;

  const AppElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 60,
    this.borderRadius = 24,
    this.color,
    this.isEnabled = false,
    this.suffix,
    this.prefix,
    this.textColor = AppColor.background,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height,
      child: ElevatedButton(
        onPressed: (!isEnabled || isLoading) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColor.primary,
          disabledBackgroundColor: color ?? AppColor.primary,
          side: const BorderSide(
            color: AppColor.textLight,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: AppColor.background,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefix != null) AppGap.g4,
                  ?prefix,

                  AppGap.g8,

                  Text(
                    text,
                    style: AppTextStyles.h5(color: textColor),
                  ),
                  AppGap.g4,

                  if (suffix != null) AppGap.g4,
                  ?suffix,
                ],
              ),
      ),
    );
  }
}
