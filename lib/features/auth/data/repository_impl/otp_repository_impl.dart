import 'package:expenseo/features/auth/data/data_source/otp_remote_data_source.dart';
import 'package:expenseo/features/auth/domain/repository/otp_repository.dart';

class OtpRepositoryImpl extends OtpRepository {
  final OtpRemoteDataSource otpDataSource;

  OtpRepositoryImpl(this.otpDataSource);

  @override
  Future<void> verifyOtp(String otp, String email) {
    return otpDataSource.verifyOtp(otp, email);
  }

  @override
  Future<void> resendOtp(String email) {
    return otpDataSource.resendOtp(email);
  }
}
