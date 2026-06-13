import '../repository/forgot_password_repository.dart';

class ForgotPasswordUseCase {
  final ForgotPasswordRepository repository;
  ForgotPasswordUseCase(this.repository);

  Future<void> forgotPassword(String email) async {
    await repository.forgotPassword(email);
  }

  Future<void> resetPassword(String email , String password , String otp) async {
    await repository.resetPassword(email,password,otp);
  }
}