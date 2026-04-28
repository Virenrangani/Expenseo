import '../entity/expense.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(String uid, Expense expense);
  Future<List<Expense>> getExpense(String uid);
  Future<void> removeExpense(String uid,String expenseId);
}