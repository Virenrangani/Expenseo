import 'package:expenseo/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extension/localization_extension.dart';
import '../../../../core/validation/email_validation/email_password_validation.dart';
import '../../../../core/validation/password_validation/password_validation.dart';
import '../../domain/use_case/sign_up_use_case.dart';

class SignUpCubit extends Cubit<AuthState> {
  final SignUpUseCase signUpUseCase;
  SignUpCubit(this.signUpUseCase) : super(AuthInitial());

  bool emailTouched = false;
  bool passwordTouched = false;
  bool nameTouched = false;
  bool isPasswordHidden = true;

  String? emailError;
  String? passwordError;
  String? nameError;

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

  void nameValidation(String value, BuildContext context) {
    nameTouched = true;
    nameError = value.isEmpty ? context.l10n.nameInvalid : null;
    emit(AuthFormValid());
  }

  bool get isFormValid {
    return emailError == null &&
        passwordError == null &&
        emailTouched &&
        passwordTouched;
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(AuthLoading());
    try {
      await signUpUseCase.signUpWithEmail(email, name, password);

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
