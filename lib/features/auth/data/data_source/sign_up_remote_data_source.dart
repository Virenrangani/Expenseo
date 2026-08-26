import 'package:dio/dio.dart';

import '../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../model/user_model.dart';

abstract class SignUpRemoteDataSource {
  Future<UserModel> signUp(String email, String name, String password);
}

class SignUpRemoteDataSourceImpl extends SignUpRemoteDataSource {
  final Dio dio;

  SignUpRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> signUp(String email, String name, String password) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/auth/signup',
        data: {'email': email, 'name': name, 'password': password},
      );

      final user = UserModel.fromJson(response.data!);

      await SharedPrefService.saveUser(
        id: user.id,
        email: user.email,
        name: user.name,
      );

      return user;
    } on DioException catch (e) {
      throw Exception(
        ((e.response?.data as Map<String, dynamic>?)?['message'])?.toString() ??
            'Registration failed',
      );
    } catch (_) {
      throw Exception('Registration failed');
    }
  }
}
