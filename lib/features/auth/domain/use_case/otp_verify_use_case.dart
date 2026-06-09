import '../repository/otp_repository.dart';

class VerifyOtpUseCase {
  final OtpRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<void> call(String otp, String email) {
    return repository.verifyOtp(otp, email);
  }
}
