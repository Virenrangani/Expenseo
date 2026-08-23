import 'package:expenseo/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/validation/email_validation/email_password_validation.dart';
import '../../../../core/validation/password_validation/password_validation.dart';
import '../../domain/use_case/login_use_case.dart';

class LoginCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  LoginCubit(this.loginUseCase) : super(AuthInitial());

  bool emailTouched = false;
  bool passwordTouched = false;

  bool isPasswordHidden = true;

  String? emailError;
  String? passwordError;

  void showPassword() {
    isPasswordHidden = !isPasswordHidden;
    emit(AuthFormValid());
  }

  void emailValidation(String value, BuildContext context) {
    emailTouched = true;
    emailError = validateEmail(value, context);
    emit(AuthFormValid());
  }

  void passwordValidation(String value, BuildContext context) {
    passwordTouched = true;
    passwordError = validatePassword(value, context);
    emit(AuthFormValid());
  }

  bool get isFormValid {
    return emailError == null &&
        passwordError == null &&
        emailTouched &&
        passwordTouched;
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await loginUseCase.loginWithEmail(email, password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
