import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/app_enums.dart';
import '../../domain/entity/expense.dart';
import '../../domain/use_case/expense_use_case.dart';
import './expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState>{
  final ExpenseUseCase useCase;
  ExpenseCubit(this.useCase):super(ExpenseInitial());

  ExpenseFilter selectedFilter = ExpenseFilter.all;

  List<Expense> allExpenses = [];
  List<Expense> filteredExpenses = [];

  TransactionType type  = TransactionType.expense;
  ExpenseCategory category = ExpenseCategory.food;
  PaymentMethod paymentMethod = PaymentMethod.cash;

  double totalIncome=0;
  double totalExpense=0;

  final int recentTransactionCount=4;

  String get currentUid => FirebaseAuth.instance.currentUser!.uid;

  Future<void> addNewExpense(Expense expense) async {
    emit(ExpenseLoading());
    try{
      await useCase.addExpense(currentUid,expense);
      emit(ExpenseSuccess(AppString.expenseAdded));
      await getExpense();
    }catch (e){
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> getExpense() async {
    emit(ExpenseLoading());
    try{
      final expense=await useCase.getExpense(currentUid);
      expense.sort((a,b)=>b.createdAt.compareTo(a.createdAt));
      totalIncome=0;
      totalExpense=0;
      allExpenses = expense;
      getTotalIncomeExpense(expense);
      applyFilter(selectedFilter);

    }catch(e){
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> removeExpense(String expenseId) async {
    emit(ExpenseLoading());
    try{
      await useCase.removeExpense(currentUid, expenseId);
      emit(ExpenseSuccess('Expense Removed...!'));
      await getExpense();
    }catch(e){
      emit(ExpenseError(e.toString()));
    }
  }

  void getTotalIncomeExpense(List<Expense> expense){
    for (var item in expense){
      if(item.type ==TransactionType.income){
        totalIncome=totalIncome+item.amount;
      }else if(item.type ==TransactionType.expense){
        totalExpense = totalExpense+ item.amount;
      }
    }
  }

  void applyFilter(ExpenseFilter filter) {
    selectedFilter = filter;
    if (filter == ExpenseFilter.all) {
      filteredExpenses = allExpenses;
    }

    else if (filter == ExpenseFilter.income) {
      filteredExpenses = allExpenses.where((e) {
        return e.type == TransactionType.income;
      }).toList();
    }

    else if (filter == ExpenseFilter.expense) {
      filteredExpenses = allExpenses.where((e) {
        return e.type == TransactionType.expense;
      }).toList();
    }

    else if (filter == ExpenseFilter.today) {
      final now = DateTime.now();
      filteredExpenses = allExpenses.where((e) {
        return e.createdAt.day == now.day &&
            e.createdAt.month == now.month &&
            e.createdAt.year == now.year;
      }).toList();

    }

    else if (filter == ExpenseFilter.week) {
      final now = DateTime.now();
      filteredExpenses = allExpenses.where((e) {
        return now.difference(e.createdAt).inDays <= 7;
      }).toList();
    }

    else if (filter == ExpenseFilter.month) {
      final now = DateTime.now();
      filteredExpenses = allExpenses.where((e) {
        return e.createdAt.month == now.month &&
            e.createdAt.year == now.year;
      }).toList();
    }

    emit(ExpenseLoaded(filteredExpenses));
  }
}