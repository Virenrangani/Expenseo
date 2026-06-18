import '../entity/expense.dart';
import '../repository/expense_repository.dart';

class ExpenseUseCase {
  final ExpenseRepository repository;

  ExpenseUseCase(this.repository);

  Future<void> addExpense(Expense expense) {
    return repository.addExpense(expense);
  }

  Future<List<Expense>> getExpense(String uid){
    return repository.getExpense(uid);
  }

  Future<void> removeExpense(String uid,String expenseId){
    return repository.removeExpense(uid, expenseId);
  }
}