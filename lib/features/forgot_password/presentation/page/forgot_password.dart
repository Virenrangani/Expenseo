import 'package:expenseo/features/forgot_password/presentation/page/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/widget/elevated_button/app_elevated_button.dart';
import '../../../../core/widget/snack_bar/custom_snack_bar.dart';
import '../../../../core/widget/text_field/app_text_field.dart';
import '../cubit/forgot_password_cubit.dart';
import '../cubit/forgot_password_state.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailController =
  TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordCubit>(
      create: (_) => GetIt.I<ForgotPasswordCubit>(),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: AppPadding.edgeAll20,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Forgot Password',
                  style: AppTextStyles.h4(),
                ),

                AppGap.g12,

                Text(
                  "Enter your registered email address and we'll send you a verification code to reset your password.",
                  style: AppTextStyles.bodyMedium(),
                ),

                AppGap.g32,

                AppFormField(
                  controller: emailController,
                  hintText: 'Enter your email',
                  prefixIcon: const Icon(Icons.mail_outline,color: AppColor.textSecondary,),
                  keyboardType: TextInputType.emailAddress,
                ),

                AppGap.g32,

                BlocConsumer<ForgotPasswordCubit,ForgotPasswordState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 48,
                        child: AppElevatedButton(
                          text: 'Send OTP',
                          isEnabled: true,
                          isLoading: state is ForgotPasswordLoading,
                          onPressed: () {
                            if (formKey.currentState!
                                .validate()) {
                              context.read<ForgotPasswordCubit>().forgotPassword(
                                emailController.text.trim(),
                              );
                            }
                          },
                        )
                    );
                  }, listener: (context, state) {
                    final cubit = context.read<ForgotPasswordCubit>();
                    if (state is ForgotPasswordSuccess) {
                      CustomSnacksBar.showSuccess(context, state.message);

                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(builder:
                              (context)=>BlocProvider.value(
                                  value: cubit,
                              child: ResetPasswordPage(email: emailController.text.trim()))
                          )
                      );
                    }

                    if(state is ForgotPasswordFailure){
                      CustomSnacksBar.showError(context, state.message);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}