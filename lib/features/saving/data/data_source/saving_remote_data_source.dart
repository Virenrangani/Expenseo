import 'package:dio/dio.dart';
import '../model/deposit_model.dart';
import '../model/saving_model.dart';

abstract class SavingRemoteDataSource {
  Future<void> createGoal(SavingModel savingGoal);
  Future<List<SavingModel>> getAllGoal();
  Future<void> addSavingAmount(DepositModel depositModel);
  Future<List<DepositModel>> getAllDeposit(String goalId);
}

class SavingRemoteDataSourceImpl extends SavingRemoteDataSource {
  final Dio dio;

  SavingRemoteDataSourceImpl(this.dio);

  @override
  Future<void> createGoal(SavingModel savingGoal) async {
    try {
      await dio.post<Map<String,dynamic>>('/saving', data: savingGoal.toJson());
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to create goal');
    }
  }

  @override
  Future<List<SavingModel>> getAllGoal() async {
    try {
      final response = await dio.get<List<dynamic>>('/saving');
      final data = response.data ?? [];
      return data.map((json) => SavingModel.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch goals');
    }
  }

  @override
  Future<void> addSavingAmount(DepositModel depositModel) async {
    try {
      await dio.post<Map<String, dynamic>>(
          '/saving/deposit',
          data: depositModel.toJson()
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to add deposit');
    }
  }

  @override
  Future<List<DepositModel>> getAllDeposit(String goalId) async {
    try {
      final response = await dio.get<List<dynamic>>('/saving/deposit/$goalId');
      final data = response.data ?? [];
      return data.map((json) => DepositModel.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch deposits');
    }
  }
}
