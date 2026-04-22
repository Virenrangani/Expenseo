import 'package:expenseo/features/auth/presentation/cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/validation/email_validation/email_password_validation.dart';
import '../../../../core/validation/password_validation/password_validation.dart';
import '../../domain/use_case/sign_up_use_case.dart';

class SignUpCubit extends Cubit<AuthState>{
  final SignUpUseCase signUpUseCase;
  SignUpCubit(this.signUpUseCase) : super(AuthInitial());

  bool emailTouched = false;
  bool passwordTouched = false;
  bool nameTouched=false;
  bool isPasswordHidden = true;

  String? emailError;
  String? passwordError;
  String? nameError;

  void showPassword(){
    isPasswordHidden!=isPasswordHidden;
  }

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

  void nameValidation(String value) {
    nameTouched=true;
    nameError = value.isEmpty ? 'Name is required' : null;
    emit(AuthFormValid());
  }

  bool get isFormValid {
    return emailError == null
        && passwordError == null
        && emailTouched
        && passwordTouched;
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(AuthLoading());
    try {
      final user = await signUpUseCase.callSignUp(email, name, password);

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.toString()));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}