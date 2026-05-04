import 'package:expenseo/core/constant/string/app_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/app_enums.dart';
import '../../domain/entity/expense.dart';
import '../../domain/use_case/expense_use_case.dart';
import './expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState>{
  final ExpenseUseCase useCase;
  ExpenseCubit(this.useCase):super(ExpenseInitial());

  TransactionType type  = TransactionType.expense;
  ExpenseCategory category = ExpenseCategory.food;
  PaymentMethod paymentMethod = PaymentMethod.cash;

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
      emit(ExpenseLoaded(expense));
    }catch(e){
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> getExpensesByDate(DateTime date) async {
    emit(ExpenseLoading());
    try {
      final expense = await useCase.getExpense(currentUid);

      final filtered = expense.where((e) {
        final local = e.createdAt.toLocal();
        final expenseDate  = DateTime(local.year, local.month, local.day);
        final selectedDate = DateTime(date.year,  date.month,  date.day);
        return expenseDate == selectedDate;
      }).toList()

      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
      emit(ExpenseLoaded(filtered));
    } catch (e) {
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
}