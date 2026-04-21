import 'package:expenseo/features/auth/presentation/cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/validation/email_validation/email_password_validation.dart';
import '../../../../core/validation/password_validation/password_validation.dart';
import '../../domain/use_case/login_use_case.dart';

class LoginCubit extends Cubit<AuthState>{
  final LoginUseCase loginUseCase;
  LoginCubit(this.loginUseCase) : super(AuthInitial());

  bool emailTouched = false;
  bool passwordTouched = false;

  String? emailError;
  String? passwordError;


  void emailValidation(String value) {
    emailTouched=true;
    emailError = validateEmail(value);
    emit(AuthFormValid());
  }

  void passwordValidation(String value) {
    passwordTouched=true;
    passwordError = validatePassword(value);
    emit(AuthFormValid());
  }

  bool get isFormValid {
    return emailError == null
        && passwordError == null
        && emailTouched
        && passwordTouched;
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await loginUseCase.callLogin(email, password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.toString()));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}