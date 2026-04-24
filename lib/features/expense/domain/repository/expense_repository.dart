import '../entity/expense.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(String uid, Expense expense);
}