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
import 'package:expenseo/features/auth/presentation/widget/grid_design.dart';
import 'package:expenseo/features/auth/presentation/widget/log_in_title.dart';
import 'package:expenseo/features/auth/presentation/widget/navigation_text.dart';
import 'package:expenseo/features/bottom_nav/app_bottom_nav.dart';
import 'package:expenseo/features/forgot_password/presentation/page/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/storage/shared_pref/shared_pref_service.dart';

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
      create: (_) => GetIt.I<LoginCubit>(),
      child: Scaffold(
        backgroundColor: AppColor.background,
        body: BlocConsumer<LoginCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              CustomSnacksBar.showError(context, state.message);
            }

            if (state is AuthSuccess) {
              CustomSnacksBar.showSuccess(context, AppString.userLogin);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(builder: (_) => const AppBottomNav()),
              );
            }
          },

          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Stack(
                children: [
                  const GridDesign(),

                  Padding(
                    padding: AppPadding.edgeSymmetricHori24,
                    child: Column(
                      children: [
                        AppGap.g64,

                        const Icon(
                          Icons.account_balance_wallet,
                          color: AppColor.background,
                          size: 38,
                        ),

                        AppGap.g24,

                        const LogInTitle(
                          title: AppString.logInIntro,
                          subTitle: AppString.logInSubIntro,
                        ),

                        AppGap.g32,

                        Container(
                          width: double.infinity,
                          padding: AppPadding.edgeAll24,
                          decoration: BoxDecoration(
                            color: AppColor.background,
                            borderRadius: AppBorderRadius.cir12,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                                color: Colors.black.withAlpha(20),
                              ),
                            ],
                          ),

                          child: Form(
                            key: formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                AppFormField(
                                  controller: emailController,
                                  hintText: AppString.email,
                                  fillColor: AppColor.background,
                                  validator: (_) =>
                                      context.read<LoginCubit>().emailError,

                                  onChanged: (val) {
                                    context.read<LoginCubit>().emailValidation(
                                      val,
                                    );
                                  },
                                ),

                                AppGap.g20,

                                AppFormField(
                                  controller: passController,
                                  hintText: AppString.password,
                                  textAction: TextInputAction.done,
                                  obscureText: context
                                      .watch<LoginCubit>()
                                      .isPasswordHidden,
                                  fillColor: AppColor.background,
                                  suffix: Icon(
                                    context.watch<LoginCubit>().isPasswordHidden
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppColor.textSecondary,
                                    size: 22,
                                  ),

                                  onSuffixTap: () {
                                    context.read<LoginCubit>().showPassword();
                                  },
                                  validator: (_) =>
                                      context.read<LoginCubit>().passwordError,
                                  onChanged: (val) {
                                    context
                                        .read<LoginCubit>()
                                        .passwordValidation(val);
                                  },
                                ),

                                AppGap.g16,

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (context) =>
                                              const ForgetPassword(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      AppString.forgotPassword,
                                      style: AppTextStyles.titleSmall(
                                        color: AppColor.primaryLight,
                                      ),
                                    ),
                                  ),
                                ),

                                AppGap.g24,

                                AppElevatedButton(
                                  text: AppString.logIn,
                                  isLoading: isLoading,
                                  borderRadius: 12,
                                  isEnabled: context
                                      .watch<LoginCubit>()
                                      .isFormValid,

                                  onPressed: () {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      context.read<LoginCubit>().login(
                                        email: emailController.text.trim(),
                                        password: passController.text,
                                      );
                                    }
                                  },
                                ),

                                AppGap.g8,

                                TextButton(
                                  onPressed: () async {
                                    final navigator = Navigator.of(context);
                                    await SharedPrefService.setGuestMode(true);
                                    if (!mounted) return;
                                    await navigator.pushReplacement(
                                      MaterialPageRoute<void>(
                                        builder: (_) => const AppBottomNav(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Continue as Guest',
                                    style: AppTextStyles.titleSmall(
                                      color: AppColor.textSecondary,
                                    ),
                                  ),
                                ),

                                NavigationText(
                                  description: AppString.dontHaveAnAccount,
                                  pageName: AppString.signUp,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (_) => const SignUpPage(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        AppGap.g20,
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
