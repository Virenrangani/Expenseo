import '../../domain/repository/forgot_password_repository.dart';
import '../data_source/forgot_password_data_source.dart';

class ForgotPasswordRepositoryImpl extends ForgotPasswordRepository{
  final ForgotPasswordDataSource dataSource;
  ForgotPasswordRepositoryImpl(this.dataSource);

  @override
  Future<void> forgotPassword(String email) async {
     await dataSource.forgotPassword(email);
  }

  @override
  Future<void> resetPassword(String email , String password , String otp) async {
    await dataSource.resetPassword(email,password,otp);
  }

}