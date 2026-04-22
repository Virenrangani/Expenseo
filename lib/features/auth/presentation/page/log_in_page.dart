import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/widget/elevated_button/app_elevated_button.dart';
import 'package:expenseo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:expenseo/core/widget/text_field/app_text_field.dart';
import 'package:expenseo/features/auth/presentation/cubit/auth_state.dart';
import 'package:expenseo/features/auth/presentation/cubit/login_cubit.dart';
import 'package:expenseo/features/auth/presentation/page/sign_up_page.dart';
import 'package:expenseo/features/auth/presentation/widget/log_in_title.dart';
import 'package:expenseo/features/auth/presentation/widget/or_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../widget/navigation_text.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<LoginCubit>(),
      child: Scaffold(
        backgroundColor: AppColor.primaryLight,
        body: BlocConsumer<LoginCubit, AuthState>(
          listener: (BuildContext context, AuthState state) {
            if (state is AuthFailure) {
              return CustomSnacksBar.showError(context, state.message);
            }
            if (state is AuthSuccess) {
              return CustomSnacksBar.showSuccess(context, AppString.userLogin);
            }
          },

          builder: (context, state) {
            final isLoading = state is AuthLoading;
            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LogInTitle(),
                    AppGap.g20,
                    Padding(
                      padding: AppPadding.edgeAll16,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.background,
                          borderRadius: AppBorderRadius.cir12,
                        ),
                        child: Padding(
                          padding: AppPadding.edgeSymmetricHori24,
                          child: Form(
                            key: formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppGap.g32,
                                Text(
                                  AppString.logInIntro,
                                  style: AppTextStyles.captionBold(
                                    color: AppColor.textPrimary,
                                  ),
                                ),
                                AppGap.g4,
                                Text(
                                  AppString.logInSubIntro,
                                  style: AppTextStyles.bodySmall(),
                                ),
                                AppGap.g32,
                                AppFormField(
                                  controller: emailController,
                                  hintText: AppString.email,
                                  labelText: AppString.email,
                                  validator: (_) =>
                                      context.read<LoginCubit>().emailError,
                                  onChanged: (val) => context
                                      .read<LoginCubit>()
                                      .emailValidation(val),
                                ),
                                AppGap.g24,
                                AppFormField(
                                  controller: passController,
                                  hintText: AppString.password,
                                  labelText: AppString.password,
                                  suffix: Icon(
                                    context.watch<LoginCubit>().isPasswordHidden
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  obscureText: context
                                      .read<LoginCubit>()
                                      .isPasswordHidden,
                                  onSuffixTap: () {
                                    context.read<LoginCubit>().showPassword();
                                  },
                                  validator: (_) =>
                                      context.read<LoginCubit>().passwordError,
                                  onChanged: (val) => context
                                      .read<LoginCubit>()
                                      .passwordValidation(val),
                                ),
                                AppGap.g16,
                                Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      AppString.forgotPassword,
                                      style: AppTextStyles.description(
                                        color: AppColor.secondary,
                                      ),
                                    ),
                                  ),
                                ),
                                AppGap.g16,

                                isLoading
                                    ? CircularProgressIndicator()
                                    : AppElevatedButton(
                                        text: AppString.signIN,
                                        suffixIcon:
                                            Icons.arrow_forward_outlined,
                                        isEnabled: context
                                            .read<LoginCubit>()
                                            .isFormValid,
                                        onPressed: () {
                                          if (formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            context.read<LoginCubit>().login(
                                              email: emailController.text
                                                  .trim(),
                                              password: passController.text,
                                            );
                                          }
                                        },
                                      ),
                                AppGap.g24,
                                OrDivider(),
                                AppGap.g24,
                                AppElevatedButton(
                                  text: AppString.signInWithGoogle,
                                  color1: AppColor.textPrimary,
                                  prefixIcon: Icons.g_mobiledata_outlined,
                                  onPressed: () async {
                                    await context
                                        .read<LoginCubit>()
                                        .signInWithGoogle();
                                  },
                                ),

                                AppGap.g32,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    AppGap.g32,

                    NavigationText(
                      description: AppString.dontHaveAnAccount,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      pageName: AppString.signUp,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
