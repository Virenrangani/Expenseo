abstract class ForgotPasswordRepository {
  Future<void> forgotPassword(String email);
  Future<void> resetPassword(String email , String password , String otp);
}