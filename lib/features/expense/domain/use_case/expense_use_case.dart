import '../entity/expense.dart';
import '../repository/expense_repository.dart';

class ExpenseUseCase {
  final ExpenseRepository repository;

  ExpenseUseCase(this.repository);

  Future<void> addExpense(Expense expense) {
    return repository.addExpense(expense);
  }

  Future<List<Expense>> getExpense(){
    return repository.getExpense();
  }

  Future<void> removeExpense(String expenseId){
    return repository.removeExpense(expenseId);
  }
}