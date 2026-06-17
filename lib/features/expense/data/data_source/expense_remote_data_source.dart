import 'package:dio/dio.dart' show Dio, DioException;

import '../model/expense_model.dart';

abstract class ExpenseRemoteDataSource {
  Future<void> addExpense(String uid, ExpenseModel expense);
  Future<List<ExpenseModel>> getExpense(String uid);
  Future<void> removeExpense(String uid, String expenseId);
}

class ExpenseRemoteDataSourceImpl extends ExpenseRemoteDataSource {
  ExpenseRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<void> addExpense(String uid, ExpenseModel expense) async {
    try {
      await dio.post<Map<String, dynamic>>('/expenses', data: expense.toJson());
    } on DioException catch (e) {
      final data = e.response?.data;

      final message = data is Map<String, dynamic>
          ? data['message']?.toString()
          : 'Expense is not added';

      throw Exception(message);
    }
  }

  // @override
  // Future<List<ExpenseModel>> getExpense(String uid) async {
  //   try {
  //     final response = await dio.get<List<Map<String, dynamic>>>('/expenses');
  //
  //     final data = response.data ?? [];
  //
  //     return data;
  //     // return data.map(ExpenseModel.fromJson).toList();
  //   } on DioException catch (e) {
  //     final data = e.response?.data;
  //
  //     final message = data is Map<String, dynamic>
  //         ? data['message']?.toString()
  //         : 'Failed to fetch expenses';
  //
  //     throw Exception(message);
  //   }
  // }

  @override
  Future<void> removeExpense(String uid, String expenseId) {
    // TODO: implement removeExpense
    throw UnimplementedError();
  }

  @override
  Future<List<ExpenseModel>> getExpense(String uid) {
    // TODO: implement getExpense
    throw UnimplementedError();
  }
}
