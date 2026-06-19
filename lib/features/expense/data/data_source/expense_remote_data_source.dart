import 'package:dio/dio.dart' show Dio, DioException;

import '../model/expense_model.dart';

abstract class ExpenseRemoteDataSource {
  Future<void> addExpense(ExpenseModel expense);
  Future<List<ExpenseModel>> getExpense();
  Future<void> removeExpense(String expenseId);
}

class ExpenseRemoteDataSourceImpl extends ExpenseRemoteDataSource {
  ExpenseRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    try {
      await dio.post<Map<String, dynamic>>('/expenses', data: expense.toJson());
    } on DioException catch (e) {
      final data = e.response?.data;

      final message = data is Map<String, dynamic>
          ? data['message']?.toString()
          : 'Failed to create expense';

      throw Exception(message);
    }
  }

  @override
  Future<List<ExpenseModel>> getExpense() async {
    try {
      final response = await dio.get<List<dynamic>>('/expenses');

      final data = response.data ?? [];

      return data
          .map((json) => ExpenseModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final data = e.response?.data;

      final message = data is Map<String, dynamic>
          ? data['message']?.toString()
          : 'Failed to fetch expenses';

      throw Exception(message);
    }
  }

  @override
  Future<void> removeExpense(String expenseId) async {
    try {
      await dio.delete<String>('/expenses/$expenseId');
    } on DioException catch (e) {
      final data = e.response?.data;

      final message = data is Map<String, dynamic>
          ? data['message']?.toString()
          : 'Failed to delete expense';

      throw Exception(message);
    }
  }
}
