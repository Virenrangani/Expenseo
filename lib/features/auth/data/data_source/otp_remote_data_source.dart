import 'package:dio/dio.dart';

abstract class OtpRemoteDataSource {
  Future<void> verifyOtp(String otp, String email);
  Future<void> resendOtp(String email);
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
      final data = e.response?.data;

      final message = data is Map<String, dynamic>
          ? data['message']?.toString()
          : 'OTP verification failed';

      throw Exception(message);
    }
  }

  @override
  Future<void> resendOtp(String email) async {
    try{
      await dio.post(
        '/resend-otp',
        data: {'email':email}
      );
    }on DioException catch (e) {
      final data = e.response?.data;

      final message = data is Map<String, dynamic>
          ? data['message']?.toString()
          : 'OTP verification failed';

      throw Exception(message);
    }
  }
}
