import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/otp_verify_use_case.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final VerifyOtpUseCase verifyOtpUseCase;

  OtpCubit(this.verifyOtpUseCase) : super(OtpInitial());

  Future<void> verifyOtp(String otp, String email) async {
    try {
      emit(OtpLoading());

      await verifyOtpUseCase(otp, email);

      emit(OtpSuccess());
    } catch (e) {
      emit(OtpFailure(e.toString()));
    }
  }
}
