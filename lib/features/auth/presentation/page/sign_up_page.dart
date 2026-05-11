import 'package:expenseo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:expenseo/features/auth/presentation/cubit/auth_state.dart';
import 'package:expenseo/features/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:expenseo/features/auth/presentation/page/log_in_page.dart';
import 'package:expenseo/features/auth/presentation/widget/grid_design.dart';
import 'package:expenseo/features/auth/presentation/widget/log_in_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/string/app_string.dart';
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
        body: BlocConsumer<SignUpCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              return CustomSnacksBar.showError(context, state.message);
            }
            if (state is AuthSuccess) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute<void>(builder: (context)=>const LogInPage()));
              return CustomSnacksBar.showSuccess(context, AppString.verifyEmail);
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
                      padding: AppPadding.edgeSymmetricHori16,

                      child: Column(
                        children: [
                          AppGap.g64,

                          const Icon(Icons.account_balance_wallet_outlined,
                            color: AppColor.background,size:42,),

                          AppGap.g20,

                          const LogInTitle(title: AppString.signUpIntro, subTitle: AppString.signUpSubIntro,),

                          AppGap.g32,

                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColor.background,
                              borderRadius: AppBorderRadius.cir24,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                  color: AppColor.textPrimary.withAlpha(15),
                                ),
                              ],
                            ),

                            child: Padding(
                              padding: AppPadding.edgeSymmetricHori24,

                              child: Form(
                                key: formKey,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                child: Column(
                                  children: [
                                    AppGap.g32,

                                    AppFormField(
                                      controller: nameController,
                                      fillColor: AppColor.background,
                                      hintText: AppString.name,
                                      validator: (_) => context.read<SignUpCubit>().nameError,
                                      onChanged: (val) {
                                        context.read<SignUpCubit>().nameValidation(val);
                                      },
                                    ),

                                    AppGap.g24,

                                    AppFormField(
                                      controller: emailController,
                                      fillColor: AppColor.background,
                                      hintText: AppString.email,
                                      validator: (_) => context.read<SignUpCubit>().emailError,
                                      onChanged: (val) {
                                        context.read<SignUpCubit>().emailValidation(val);
                                      },
                                    ),

                                    AppGap.g24,

                                    AppFormField(
                                      controller: passwordController,
                                      hintText: AppString.password,
                                      fillColor: AppColor.background,
                                      obscureText: context.watch<SignUpCubit>().isPasswordHidden,
                                      suffix: Icon(
                                        context.watch<SignUpCubit>().isPasswordHidden
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),

                                      onSuffixTap: () {
                                        context.read<SignUpCubit>().showPassword();
                                      },
                                      validator: (_) => context.read<SignUpCubit>().passwordError,
                                      onChanged: (val) {
                                        context.read<SignUpCubit>().passwordValidation(val);
                                      },
                                    ),

                                    AppGap.g32,

                                    AppElevatedButton(
                                      text: AppString.createAccount,
                                      isLoading: isLoading,
                                      isEnabled: context.watch<SignUpCubit>().isFormValid,
                                      suffix: const Icon(
                                        Icons.arrow_forward_rounded,
                                        color: AppColor.background,
                                      ),

                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          context.read<SignUpCubit>().signUp(
                                            email: emailController.text.trim(),
                                            password: passwordController.text,
                                            name: nameController.text.trim(),
                                          );
                                        }
                                      },
                                    ),

                                    AppGap.g24,

                                    NavigationText(
                                      description:
                                      AppString.alReadyHaveAnAccount,
                                      pageName: AppString.logIn,
                                      onTap: () {
                                        Navigator.push(context,
                                          MaterialPageRoute<void>(builder:
                                              (_) => const LogInPage(),),
                                        );
                                      },
                                    ),

                                    AppGap.g24,
                                  ],
                                ),
                              ),
                            ),
                          ),

                          AppGap.g32,
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}
