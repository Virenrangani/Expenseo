import '../repository/otp_repository.dart';

class VerifyOtpUseCase {
  final OtpRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<void> call(String otp, String email) {
    return repository.verifyOtp(otp, email);
  }

  Future<void> resendOtp(String email){
    return repository.resendOtp(email);
  }
}
