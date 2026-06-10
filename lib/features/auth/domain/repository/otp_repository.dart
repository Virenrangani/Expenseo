abstract class OtpRepository {
  Future<void> verifyOtp(String otp, String email);
  Future<void> resendOtp(String email);
}
