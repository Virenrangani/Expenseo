import 'package:dio/dio.dart';

import '../../../auth/data/model/user_model.dart';
import '../model/create_group_request_model.dart';
import '../model/group_response_model.dart';

abstract class SplitRemoteDataSource {
  Future<GroupResponseModel> createGroup(CreateGroupRequest request);
  Future<UserModel?> searchUserByEmail(String email);
  Future<List<GroupResponseModel>> getGroups();
  Future<void> deleteGroup(String groupId);
}

class SplitRemoteDataSourceImpl extends SplitRemoteDataSource {
  final Dio dio;
  SplitRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel?> searchUserByEmail(
      String email) async {
    try {
      final response =
      await dio.get<Map<String, dynamic>>(
        '/auth/search-user',
        queryParameters: {
          'email': email,
        },
      );

      return UserModel.fromJson(
        response.data!,
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ??
            'User not found',
      );
    }
  }

  @override
  Future<GroupResponseModel> createGroup(
      CreateGroupRequest request) async {
    try {
      final response =
      await dio.post<Map<String, dynamic>>(
        '/group',
        data: request.toJson(),
      );

      return GroupResponseModel.fromJson(
        response.data!,
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ??
            'Failed to create group',
      );
    }
  }

  @override
  Future<List<GroupResponseModel>> getGroups() async {
    try {

      final response = await dio.get<List<dynamic>>('/group');

      final data = response.data ?? [];

      return data
          .map((json) => GroupResponseModel.fromJson(json as Map<String, dynamic>))
          .toList();

    } on DioException catch (e) {
      final data = e.response?.data;

      final message = data is Map<String, dynamic>
          ? data['message']?.toString()
          : 'Failed to fetch groups';

      throw Exception(message);
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    try {

      await dio.delete<String>('/group/$groupId');

    } on DioException catch (e) {
      final data = e.response?.data;

      final message = data is Map<String, dynamic>
          ? data['message']?.toString()
          : 'Failed to delete group';

      throw Exception(message);
    } catch (e) {
      throw Exception('An unexpected error occurred while deleting the group');
    }
  }
}
