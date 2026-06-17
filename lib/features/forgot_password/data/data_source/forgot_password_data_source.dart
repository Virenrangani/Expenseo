import 'package:dio/dio.dart';

abstract class ForgotPasswordDataSource {
  Future<void> forgotPassword(String email);
  Future<void> resetPassword(String email, String password,String otp);
}

class ForgotPasswordDataSourceImpl extends ForgotPasswordDataSource {
  final Dio dio;
  ForgotPasswordDataSourceImpl(this.dio);
  @override
  Future<void> forgotPassword(String email) async {
    try{
      await dio.post<String>('/auth/forgot-password', data: {
        'email': email,
      });
    }on DioException catch (e) {
      final data = e.response?.data;

      final message =
      data is Map<String, dynamic>
          ? data['message']?.toString()
          : 'Login failed';

      throw Exception(message);
    }
  }

  @override
  Future<void> resetPassword(String email , String password , String otp) async {
    try{
      await dio.post<String>('/auth/reset-password', data: {
        'email':email,
        'password': password,
        'otp':otp
      });
    }on DioException catch (e) {
      final data = e.response?.data;
      final message =
      data is Map<String, dynamic>
          ? data['message']?.toString()
          : 'Login failed';
      throw Exception(message);
    }
  }
}