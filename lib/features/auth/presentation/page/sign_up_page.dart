import 'package:expenseo/core/widget/app_title/app_title.dart';
import 'package:expenseo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:expenseo/features/auth/presentation/cubit/auth_state.dart';
import 'package:expenseo/features/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:expenseo/features/auth/presentation/page/log_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/string/app_string.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/widget/elevated_button/app_elevated_button.dart';
import '../../../../core/widget/text_field/app_text_field.dart';
import '../widget/navigation_text.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<SignUpCubit>(),
      child: Scaffold(
        backgroundColor: AppColor.primaryLight,
        body: BlocConsumer<SignUpCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              return CustomSnacksBar.showError(context, state.message);
            }
            if (state is AuthSuccess) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=>LogInPage()));
              return CustomSnacksBar.showSuccess(context, AppString.userLogin);
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            return SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppTitle(),
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
                                  AppString.signUpIntro,
                                  style: AppTextStyles.h3(
                                    color: AppColor.textPrimary,
                                  ),
                                ),
                                AppGap.g4,
                                Text(
                                  AppString.signUpSubIntro,
                                  style: AppTextStyles.bodySmall(),
                                ),
                                AppGap.g32,
                                AppFormField(
                                  controller: nameController,
                                  hintText: AppString.name,
                                  labelText: AppString.name,
                                  validator: (_) =>
                                      context.read<SignUpCubit>().nameError,
                                  onChanged: (val) => context
                                      .read<SignUpCubit>()
                                      .nameValidation(val),
                                ),
                                AppGap.g24,
                                AppFormField(
                                  controller: emailController,
                                  hintText: AppString.email,
                                  labelText: AppString.email,
                                  validator: (_) =>
                                      context.read<SignUpCubit>().emailError,
                                  onChanged: (val) => context
                                      .read<SignUpCubit>()
                                      .emailValidation(val),
                                ),
                                AppGap.g24,
                                AppFormField(
                                  controller: passwordController,
                                  hintText: AppString.password,
                                  labelText: AppString.password,
                                  obscureText: context
                                      .read<SignUpCubit>()
                                      .isPasswordHidden,
                                  suffix: Icon(
                                    context.read<SignUpCubit>().isPasswordHidden
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onSuffixTap: () {
                                    context.read<SignUpCubit>().showPassword();
                                  },
                                  validator: (_) =>
                                      context.read<SignUpCubit>().passwordError,
                                  onChanged: (val) => context
                                      .read<SignUpCubit>()
                                      .passwordValidation(val),
                                ),
                                AppGap.g32,

                                isLoading
                                    ? const CircularProgressIndicator(
                                        color: AppColor.primary,
                                      )
                                    : AppElevatedButton(
                                        text: AppString.createAccount,
                                        isEnabled: context
                                            .read<SignUpCubit>()
                                            .isFormValid,
                                        suffixIcon:
                                            Icons.arrow_forward_outlined,
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            context.read<SignUpCubit>().signUp(
                                              email: emailController.text
                                                  .trim(),
                                              password: passwordController.text,
                                              name: nameController.text.trim(),
                                            );
                                          }
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
                      description: AppString.alReadyHaveAnAccount,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LogInPage()),
                        );
                      },
                      pageName: AppString.signIN,
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
