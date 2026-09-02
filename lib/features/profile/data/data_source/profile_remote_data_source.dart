import 'package:dio/dio.dart';
import 'package:expenseo/features/auth/data/model/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> completeProfile({
    required String userId,
    required String phoneNumber,
    required String gender,
    required String dob,
    String? profileImageUrl,
  });

  Future<UserModel> getProfile(String userId);
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> completeProfile({
    required String userId,
    required String phoneNumber,
    required String gender,
    required String dob,
    String? profileImageUrl,
  }) async {
    try {
      final response = await dio.put<Map<String, dynamic>>(
        '/profile/$userId',
        data: {
          'phoneNumber': phoneNumber,
          'gender': gender,
          'dob': dob,
          'profileImage': profileImageUrl,
        },
      );

      return UserModel.fromJson(response.data!);
    } on DioException catch (e) {
      final data = e.response?.data;

      final message = data is Map<String, dynamic>
          ? data['message']?.toString()
          : 'Failed to complete profile';

      throw Exception(message);
    }
  }

  @override
  Future<UserModel> getProfile(String userId) async {
    try {
      final response = await dio.get<Map<String, dynamic>>('/profile/$userId');
      return UserModel.fromJson(response.data!);
    } on DioException catch (e) {
      final data = e.response?.data;
      final message = data is Map<String, dynamic>
          ? data['message']?.toString()
          : 'Failed to fetch profile';
      throw Exception(message);
    }
  }
}
