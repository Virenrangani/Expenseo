import '../../domain/repository/expense_repository.dart';
import '../data_source/expense_data_source.dart';
import '../../domain/entity/expense.dart';
import '../model/expense_model.dart';

class ExpenseRepositoryImpl implements ExpenseRepository{
  final ExpenseDataSource dataSource;

  ExpenseRepositoryImpl(this.dataSource);

  @override
  Future<void> addExpense(String uid, Expense expense) async{
    final model = ExpenseModel(
      id: expense.id,
      title: expense.title,
      amount: expense.amount,
      type: expense.type,
      category: expense.category,
      paymentMethod: expense.paymentMethod,
      createdAt: expense.createdAt,
    );

    return  await dataSource.addExpense(uid, model);
  }

  @override
  Future<List<Expense>> getExpense(String uid)async {
    final expense=await dataSource.getExpense(uid);
    return expense.map((e)=>
        Expense(
            id: e.id,
            title: e.title,
            amount: e.amount,
            type: e.type,
            category: e.category,
            paymentMethod: e.paymentMethod,
            createdAt: e.createdAt
        )
    ).toList();
  }
}