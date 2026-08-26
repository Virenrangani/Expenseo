import 'package:expenseo/features/auth/presentation/page/log_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/extension/localization_extension.dart';
import '../../../../core/extension/snackbar_extension.dart';
import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/widget/elevated_button/app_elevated_button.dart';
import '../../../../core/widget/text_field/app_text_field.dart';
import '../cubit/forgot_password_cubit.dart';
import '../cubit/forgot_password_state.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;
  const ResetPasswordPage({super.key, required this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final FocusNode newPasswordFocusNode = FocusNode();

  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    newPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
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
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(context.l10n.resetPassword, style: AppTextStyles.h5()),

                  AppGap.g12,

                  Text(
                    context.l10n.resetPasswordDescription,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySmall(),
                  ),

                  AppGap.g24,

                  AppFormField(
                    hintText: context.l10n.enterOtp,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(
                      Icons.verified_outlined,
                      color: AppColor.textSecondary,
                    ),
                  ),

                  AppGap.g16,

                  AppFormField(
                    controller: newPasswordController,
                    hintText: context.l10n.newPassword,
                    obscureText: obscureNewPassword,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureNewPassword = !obscureNewPassword;
                        });
                      },
                      icon: Icon(
                        obscureNewPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),

                  AppGap.g16,

                  AppFormField(
                    controller: confirmPasswordController,
                    hintText: context.l10n.confirmPassword,
                    obscureText: obscureConfirmPassword,
                    textAction: TextInputAction.done,
                    focusNode: newPasswordFocusNode,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureConfirmPassword = !obscureConfirmPassword;
                        });
                      },
                      icon: Icon(
                        obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),

                  AppGap.g32,

                  BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                    builder: (context, state) {
                      return SizedBox(
                        height: 48,
                        child: AppElevatedButton(
                          text: context.l10n.resetPassword,
                          isEnabled: true,
                          isLoading: state is ForgotPasswordLoading,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (newPasswordController.text !=
                                  confirmPasswordController.text) {
                                context.showErrorSnackBar(
                                  context.l10n.passwordsDoNotMatch,
                                );
                                return;
                              }
                              context.read<ForgotPasswordCubit>().resetPassword(
                                widget.email,
                                newPasswordController.text.trim(),
                                otpController.text.trim(),
                                context,
                              );
                            }
                          },
                        ),
                      );
                    },
                    listener: (context, state) {
                      if (state is ForgotPasswordSuccess) {
                        newPasswordFocusNode.unfocus();
                        context.showSuccessSnackBar(state.message);
                        context.pushReplacement(const LogInPage());
                      }
                      if (state is ForgotPasswordFailure) {
                        context.showErrorSnackBar(state.message);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
