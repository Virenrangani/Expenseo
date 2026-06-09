import 'package:dio/dio.dart';

abstract class OtpRemoteDataSource {
  Future<void> verifyOtp(String otp, String email);
}

class OtpRemoteDataSourceImpl extends OtpRemoteDataSource {
  final Dio dio;

  OtpRemoteDataSourceImpl(this.dio);

  @override
  Future<void> verifyOtp(String otp, String email) async {
    try {
      await dio.post<Map<String, dynamic>>(
        '/verify-otp',
        data: {'email': email, 'otp': otp},
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'OTP verification failed');
    }
  }
}
