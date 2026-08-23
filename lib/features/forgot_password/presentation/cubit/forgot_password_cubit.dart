import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extension/localization_extension.dart';
import '../../domain/use_case/forgot_password_use_case.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase useCase;
  ForgotPasswordCubit(this.useCase) : super(ForgotPasswordInitial());

  Future<void> forgotPassword(String email, BuildContext context) async {
    emit(ForgotPasswordLoading());
    try {
      await useCase.forgotPassword(email);
      emit(ForgotPasswordSuccess(context.l10n.passwordResetLinkSent));
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }

  Future<void> resetPassword(
    String email,
    String password,
    String otp,
    BuildContext context,
  ) async {
    emit(ForgotPasswordLoading());
    try {
      await useCase.resetPassword(email, password, otp);
      emit(ForgotPasswordSuccess(context.l10n.passwordResetLinkSent));
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }
}
