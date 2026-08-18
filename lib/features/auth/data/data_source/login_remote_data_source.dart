import 'package:dio/dio.dart';

import '../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../model/user_model.dart';

abstract class LoginRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final Dio dio;

  LoginRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      final user = UserModel.fromJson(response.data!);

      await SharedPrefService.saveUser(
        id: user.id,
        email: user.email,
        name: user.name,
        // isProfileComplete: user.isProfileComplete,
      );

      await SharedPrefService.saveTokens(
        accessToken: user.token,
        refreshToken: user.refreshToken ?? ' ',
      );

      return user;
    } on DioException catch (e) {
      final data = e.response?.data;

      final message = data is Map<String, dynamic>
          ? data['message']?.toString()
          : 'Login failed';

      throw Exception(message);
    }
  }
}
