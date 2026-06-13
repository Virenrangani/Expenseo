import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/forgot_password_use_case.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase useCase;
  ForgotPasswordCubit(this.useCase):super(ForgotPasswordInitial());

  Future<void> forgotPassword(String email)async {
    emit(ForgotPasswordLoading());
    try{
      await useCase.forgotPassword(email);
      emit(ForgotPasswordSuccess('Password reset link sent to your email'));
    }catch(e){
      emit(ForgotPasswordFailure(e.toString()));
    }
  }

  Future<void> resetPassword(String email , String password , String otp)async {
    emit(ForgotPasswordLoading());
    try{
      await useCase.resetPassword(email,password,otp);
      emit(ForgotPasswordSuccess('Password reset link sent to your email'));
    }catch(e){
      emit(ForgotPasswordFailure(e.toString()));
    }
  }
}