import 'package:dio/dio.dart';
import 'package:expenseo/features/split/data/model/settle_balance_model.dart';

import '../../../auth/data/model/user_model.dart';
import '../model/create_group_request_model.dart';
import '../model/group_response_model.dart';
import '../model/split_model.dart';

abstract class SplitRemoteDataSource {
  Future<GroupResponseModel> createGroup(CreateGroupRequest request);
  Future<UserModel?> searchUserByEmail(String email);
  Future<List<GroupResponseModel>> getGroups();
  Future<void> deleteGroup(String groupId);

  Future<void> addSplitExpense(SplitModel expense);
  Future<List<SplitModel>> getGroupExpenses(String groupId);
  Future<void> settleUp(SettleBalanceModel settlement);
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

  @override
  Future<void> addSplitExpense(SplitModel expense) async {
    try {
      await dio.post<Map<String,dynamic>>(
        '/group-expenses',
        data: expense.toJson(),
      );
    } on DioException catch (e) {
      final message = e.response?.data is Map<String, dynamic>
          ? e.response?.data['message']?.toString()
          : 'Failed to add expense';
      throw Exception(message);
    }
  }

  @override
  Future<List<SplitModel>> getGroupExpenses(String groupId) async {
    try {
      final response = await dio.get<List<dynamic>>('/group-expenses/group/$groupId');
      final data = response.data ?? [];

      return data.map((json) => SplitModel.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      final message = e.response?.data is Map<String, dynamic>
          ? e.response?.data['message']?.toString()
          : 'Failed to fetch group details';
      throw Exception(message);
    }
  }

  @override
  Future<void> settleUp(SettleBalanceModel settlement) async {
    try {
      await dio.post<Map<String,dynamic>>(
        '/group-expenses/settle',
        data: settlement.toJson(),
      );
    } on DioException catch (e) {
      final message = e.response?.data is Map<String, dynamic>
          ? e.response?.data['message']?.toString()
          : 'Failed to settle up';
      throw Exception(message);
    }
  }
}
