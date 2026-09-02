import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/widget/elevated_button/app_elevated_button.dart';
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

import '../../../../core/extension/localization_extension.dart';
import '../../../../core/extension/snackbar_extension.dart';
import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../../../profile/presentation/page/complete_profile_page.dart';

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
          listener: (context, state) async {
            if (state is AuthFailure) {
              context.showErrorSnackBar(state.message);
            }

            if (state is AuthSuccess) {
              context.showSuccessSnackBar(context.l10n.userLogin);

              // After successful login, check if profile is complete.
              final isProfileComplete = SharedPrefService.isProfileComplete();
              if (!isProfileComplete) {
                final userId = SharedPrefService.getUserId() ?? '';
                // Navigate to profile completion flow
                await context.pushReplacement(CompleteProfilePage(userId: userId));
                return;
              }

              await context.pushReplacement(const AppBottomNav());
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

                        LogInTitle(
                          title: context.l10n.logInIntro,
                          subTitle: context.l10n.logInSubIntro,
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
                                  hintText: context.l10n.email,
                                  fillColor: AppColor.background,
                                  validator: (_) =>
                                      context.read<LoginCubit>().emailError,

                                  onChanged: (val) {
                                    context.read<LoginCubit>().emailValidation(
                                      val,
                                      context,
                                    );
                                  },
                                ),

                                AppGap.g20,

                                AppFormField(
                                  controller: passController,
                                  hintText: context.l10n.password,
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
                                        .passwordValidation(val, context);
                                  },
                                ),

                                AppGap.g16,

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      context.push(const ForgetPassword());
                                    },
                                    child: Text(
                                      context.l10n.forgotPassword,
                                      style: AppTextStyles.titleSmall(
                                        color: AppColor.primaryLight,
                                      ),
                                    ),
                                  ),
                                ),

                                AppGap.g24,

                                AppElevatedButton(
                                  text: context.l10n.logIn,
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
                                    await SharedPrefService.setGuestMode(true);
                                    if (!context.mounted) return;

                                    await context.pushReplacement(
                                      const AppBottomNav(),
                                    );
                                  },
                                  child: Text(
                                    context.l10n.continueAsGuest,
                                    style: AppTextStyles.titleSmall(
                                      color: AppColor.textSecondary,
                                    ),
                                  ),
                                ),

                                NavigationText(
                                  description: context.l10n.dontHaveAnAccount,
                                  pageName: context.l10n.signUp,
                                  onTap: () {
                                    context.push(const SignUpPage());
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
