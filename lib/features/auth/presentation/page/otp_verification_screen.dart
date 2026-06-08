import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/widget/elevated_button/app_elevated_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 52,
      textStyle: AppTextStyles.h5(color: AppColor.primary),
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.cir16,
        border: Border.all(color: AppColor.textSecondary),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          padding: AppPadding.edgeAll20,
          decoration: BoxDecoration(
            color: AppColor.background,
            borderRadius: AppBorderRadius.cir20,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                offset: const Offset(0, 4),
                color: Colors.black.withAlpha(20),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppString.emailVarification, style: AppTextStyles.h5()),

              AppGap.g12,

              Text(
                AppString.emailVarificationInto,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall(),
              ),

              AppGap.g24,

              Pinput(
                controller: otpController,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: BoxDecoration(
                    borderRadius: AppBorderRadius.cir16,
                    border: Border.all(color: AppColor.primary, width: 2),
                  ),
                ),
              ),

              AppGap.g32,

              SizedBox(
                height: 48,
                child: AppElevatedButton(
                  text: AppString.verifyOtp,
                  isEnabled: otpController.text.length == 6,
                  isLoading: isLoading,
                  onPressed: () {},
                ),
              ),

              AppGap.g16,

              Text(
                AppString.otpExpireIn10Min,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall(),
              ),

              AppGap.g24,

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyles.bodyMedium(),
                  children: [
                    const TextSpan(text: AppString.notReceivingOtp),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: InkWell(
                        onTap: () {
                          /// resend otp api
                        },
                        child: Text(
                          AppString.resendOtp,
                          style: AppTextStyles.bodyMedium(
                            color: AppColor.primary,
                          ).copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
