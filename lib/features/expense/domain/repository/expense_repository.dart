import '../entity/expense.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(Expense expense);
  Future<List<Expense>> getExpense();
  Future<void> removeExpense(String expenseId);
}